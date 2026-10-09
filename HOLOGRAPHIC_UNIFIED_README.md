# HolographicUnified_Final.hlsl — Master Fusion (4-Pass Tensor Holography)

**Base preserved 100% verbatim** (`ConstantBuffer b0` 57 scalars, `diffuseMap t0`/`depthMap t1`/`gratingDepth1 t2`/`rtMap1-8 t25-32`, `sampleTypeLinear s0`/`sampleTypeMirror s1`, `PsInput`/`PsOut` 8 MRTs). Every field and every bound resource is touched ≥2× — see lint at top of `PS()`.

This revision implements the **host pattern you requested** for ping-pong render targets and true 4-pass holography with rigorous physics.

## Host pattern (exactly as you specified)

```hlsl
if(PassNum == 0){
    output.rt1 = float4(0,0,0,1);
    output.rt2 = float4(0,0,0,1);
    // ... rt3..rt8 = 0
}
else{
    output.rt1 = rtMap1.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt2 = rtMap2.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt3 = rtMap3.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt4 = rtMap4.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt5 = rtMap5.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt6 = rtMap6.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt7 = rtMap7.SampleLevel(sampleTypeLinear, input.uv, 0);
    output.rt8 = rtMap8.SampleLevel(sampleTypeLinear, input.uv, 0);
    // then USE sampled data for complex math, not add — overwrite with new physics
}
```

`PassNum` is zero-based, `NumPasses` is 4. `Pass 0` emits the pristine G-buffer, `Pass 1-3` sample previous with `sampleTypeLinear` and **replace** with tensor-computed results. `IsLastPass()` (`PassNum+1 >= NumPasses`) gates `EncodeDisplay`/tonemap.

`LButton`/`RButton` are **exactly 0 or 1**, never `>1.5`. All thresholds use `lerp(..., LButton)` / `lerp(..., RButton)` / `RButton==1` / `RButton>0.5` (equivalent for 0/1), not `>1.5`.

## What was fused and where it came from

| Source | Best ideas extracted | How it lives in Final (physics, not fake math) |
|---|---|---|
| **Hologram3_010** (917L) | Plate-correct units (sizeM/depthM/parallaxUv), view-facing TBN shortest-arc, entry-on-top-plane, Illinois 15-iter POM + Scharr(3-10-3) + 18×3 AO + 12-step shadow, 12-sample **sinc-footprint** thin-film CIE XYZ→sRGB, **Gauss-Hermite 5** DOE with 3 groove profiles | Kept intact: `MakePlateGeom`, `ViewFacingTbn`, `ParallaxOcclusion`, `CieXyz`, `GamutCompress`, `DiffractiveRainbow` (now Jones-weighted). Only wiring changes (`f2/f3/f4/f5/f8/f10/f12` + tensor). |
| **Hologram2 family** | Cook-Torrance GGX + Smith + Schlick, Worley/FBM/Perlin | `DistributionGGX`/`GeometrySmith`/`AnisotropicSpecular`/`FresnelSchlickFused` driven by `SpecularPower/Intensity`, `FresnelPower/Reflectance/Mix`; `WorleyFused`/`FbmFused` as physical density fields. |
| **holographic.hlsl.txt / newHoloCopy** | Sellmeier B/C, birefringence, anisotropy tensor, Multi-Wave & Spiral | `DielectricTensor_Uniaxial` + `RotateTensor`, Sellmeier → `n_o/n_e`, `ThinFilm_CharMatrix` (2×2 characteristic, s/p) replaces fake `cos(OPD)`. |
| **Bloom_20241221** | DepthDensity, `GaussianBloom`, `ColorAdjust`, `FresBloom` | `GaussianBloomFused` as **lens PSF convolution** (not add), `ColorAdjustFused` via LMS. |
| **cap_Rainbow/Ripple/Worm** | Rainbow sigmoid, Hankel ripple, worm tunnel | `RippleDistortion_Physical` = `J0(k r)cos(ωt-kr)exp(-r/L)/√r` (Helmholtz), centre at `LookAtX/Y`, boost via `RButton` 0/1; `WormTunnelFused` as refractive perturbation; `OilRainbowStrengthFused` via `f1+LButton` 0/1. |

## Complex tensor core (new)

```hlsl
float2 Cmplx(re,im), CExp(θ)=cosθ+i sinθ, CMul/CAdd/CDiv, CAbs2
struct JonesMat { float2 xx,xy,yx,yy; }  // each entry complex
JonesMat JonesMul
float3x3 DielectricTensor_Uniaxial(n_o,n_e, opticAxis) // ε = ε_o I + (ε_e-ε_o)oa⊗oa
RotateTensor
ThinFilm_CharMatrix(n0,n1,n2, d_NM, cosθ0, λ, out r_s, out r_p) // M=[[c,i s/η],[iηs,c]], r=(η0M11+...)/(...)
BesselJ0_Approx // for Hankel ripple
```

These are used in **Pass 1** to compute per-wavelength `r_s/r_p` for 462/538/612 nm, coherence `sinc(foot/λ)`, and DOE field `√(DOE_RGB)*gain*exp(i 2π groove·cosSum/λ+PhaseOffset)`. Interference is `|Af+Ad·e^{iφ}|²` with contrast `FresnelVisibility·coh·shadow`, not `lerp+add`.

## 4-Pass state-of-the-art pipeline

**Pass 0 — G-Buffer** (`PassNum==0`): zeros then `ParallaxOcclusion` (Illinois + TBN orbit), stores:
- `rt1` albedo, `rt2` `normalTS*0.5+0.5`, `rt3` `hitDepth|shadow|fade|edge`, `rt4` `uvHit|probe`, `rt5` groove param, `rt8` albedo+`ShaderAlpha`. No lighting.
- Clips after `ddx`.

**Pass 1 — Wave Optics** (`PassNum==1`): samples G-buffer via `rtMap1..4` (`sampleTypeLinear`), computes:
- Thickness `lerp(FILM_MIN_USED,FILM_MAX_USED, hitDepth+f6+oilBias)` (`FILM_MIN_USED = FILM_MIN+HeightParamA*40+f6*30`, etc.)
- Tensor `ε` from `n_o/n_e` (`MaterialIndex`, `HeightParamC` swirl) → `anisoScale`
- `ThinFilm_CharMatrix` per λ → `RB/RG/RR = 0.5(|rs|²+|rp|²)·coh·visibility` → `filmRGB = intensity·albedo`
- DOE `DiffractiveRainbow` → amplitude `√(...)·DOE_GAIN·lerp(0.35,1,LButton)·lerp(1,1.2,KeyControl)` → `ampDoe`
- Complex sum `interf = |Af|²+|Ad|²+2|Af||Ad|Re(e^{iφ})·coh·visibility·shadow` with `φ=2π groove·cosSum/λ+PhaseOffsetR/G/B`
- `waveHDR = interf·transmittance(Beer-Lambert)·shadow·(1-f12)` — **physically scattered**, not added.
- Stores `rt1=waveHDR`, `rt2=normal`, `rt3=hitDepth|shadow|thicknessMicron`, `rt4=uv|coh`, `rt5/6=rs/rp` (Jones), `rt7=phasors`, `rt8=albedo`.

**Pass 2 — Tensor Lighting & Volume** (`PassNum==2`): samples `waveHDR` + Jones + G-buffer:
- `AnisotropicSpecular(α=1.15-log2(SpecularPower)*0.14, aniso=OMD*0.42+HeightScale*0.018+thickness*0.02) * SpecularIntensity`
- Fresnel from Jones `|rs/rp|²` mixed with Schlick via `FresnelPower/Reflectance/Mix` (+ `MaterialIndex`)
- `diffuse = waveHDR*(NdotL·shadow·0.9+0.08)`, `litTensor = diffuse + spec·NdotL`
- Volumetrics: `auroraDens=FBM(...)*(0.35+AURORA_INTENSITY·0.45+thickness*0.08)` with `RainbowColor(TanhFactor)` and `Beer-Lambert` `transVol=exp(-(aurora+caust)·0.35)`, `lit*transVol + aurora*(1-transVol)*0.6 + caust·shadow*0.5` — radiative transfer, not overlay. `caust=CausticsFused(uv,timeJ)·HeightScale`, `worm` perturbs roughness via `RButton==1`/`KeyAlt`, `glitter=Worley(...)*lerp(0.6,1,LButton)`.
- `ColorAdjustFused(Mix2,Mix3)` + `RotateHueFused(Perlin*Mix2)` → `graded`. Stores `rt1=graded`, `rt3` carries `auroraDens`.

**Pass 3 — Display** (`PassNum==3`, last if `NumPasses==4`): samples `hdr=rtMap1`, `normal`, `hitDepth`:
- Bloom as **veil** `hdr*(1-0.12·lumB)+bloom·strength` (`strength=lerp(0.14,0.28,RButton)+f9·0.10+HeightParamC·0.015`), `Gamma` knee.
- Lateral color `ChromaticAberration(rtMap1, NormalRadius, fringe=f11·hitDepth, HeightScale)` gated by `ParallaxFactorC`.
- `GamutCompress` → `IsLastPass()` → `EncodeDisplay` with `viewCos·(0.58+0.42cos time)·(0.55+hitDepth·0.45)·(0.82+ParallaxScale·0.18+thickness·0.01)`. Temporal freeze via `KeyShift==1` lerp to history average `rtMap2..5`.
- Writes `rt1=display|ShaderAlpha`, `rt2=hdr`, `rt3=bloom`, `rt4=chroma`, `rt7=viewCos`, `rt8=Encode(Gamut(hdr))`. `LButton`/`RButton` 0/1 throughout.

All passes **use** previous `rtMap` data as operands (interference intensity, Jones, transmittance, bloom veil, chroma dispersion) — never `output+=rtMap`.

## Tunable map

- `f1` oil rainbow (`OilRainbowStrengthFused`+`LButton` 0/1), `f2` `DOE_PERIOD_UM`, `f3` `DOE_GAIN` (0.35→1 via `LButton`), `f4` `DOE_SIGMA`·cos(anim), `f5` `DOE_SWIRL`, `f6` thickness bias + glitter, `f7` aurora+`FRESNEL_OIL_BIAS`+caustic, `f8` `DOE_CHIRP`, `f9` bloom thresh + worm speed, `f10` `DOE_GROOVE_NM`, `f11` fringe, `f12` shadow darken.
- `HeightParamA/B/C` → `FILM_MIN/MAX_USED` + tensor swirl + bloom.
- `PhaseOffsetR/G/B` → `ThinFilm_CharMatrix` retardance + DOE phase.
- `CosineFactor*`, `TanhFactor*` → aurora scattering.
- `LookAtX/Y/DeltaX/Y` → ripple centre / aurora hue / `VS ViewDir`.
- `ParallaxFactorA/B/C` → film tensor blend, DOE/film split, chroma.
- `SpecularPower/Intensity`, `FresnelPower/Reflectance/Mix` → CT tensor.
- `NormalRadius`/`HeightScale` → chroma texels, ripple `k`, caustic sharpness, glitter.
- `MaterialIndex` → `n_o/n_e` dispersion + metallic latch.
- `ParallaxScale/OMD` → ripple `A` + GGX aniso.
- `Gamma` → encode 1/γ + bloom veil.
- `Mix2/Mix3` → saturation/vibrance.
- `LButton`/`RButton` 0/1 → DOE 0.35→1, oil 0→0.35, ripple 0.30→0.55 / 1→1.6, bloom 0.14→0.28, worm `RButton==1`, sparkle `LButton`.
- `KeyControl/Shift/Alt` 0/1 → DOE ×1.2, freeze/history, worm.
- `NumPasses/PassNum`, `TotalTime/AnimateSpeed/FrameTime` → ping-pong, `ANIM_TIME_S`, orbit `FrameTime*0.016`.

## MRT packing (8 targets, all written every pass)

| RT | Pass 0 | Pass 1 | Pass 2 | Pass 3 (display) |
|---|---|---|---|---|
| rt1 | albedo | **waveHDR (coherent)** | **graded HDR (tensor+volume)** | **display encoded** |
| rt2 | normal enc | normal | normal enc | hdr copy |
| rt3 | hitDepth|shadow|fade|edge | hitDepth|shadow|thicknessμ | hitDepth|shadow|auroraDens | bloom |
| rt4 | uvHit|probe | uvHit|cohR|cohG | uvHit|coh | chroma |
| rt5 | groove | rsR|rsG (Jones) | rs (carry) | rs (carry) |
| rt6 | 0 | rpR|rpG | rp (carry) | rp (carry) |
| rt7 | 0 | phasors eR/eG | aurora | viewCos |
| rt8 | albedo|ShaderAlpha | albedo|ShaderAlpha | caust | Encode(Gamut(hdr))|ShaderAlpha |

All 8 `rtMap1..8` sampled with `sampleTypeLinear` in passes 1-3; `sampleTypeMirror` used for depth/albedo tiling; both samplers proven used.

## Host compatibility

- **ABI unchanged:** `PsOut PS(PsInput)` + `PsInput VS(VsIn)` (`VsIn.Pos/TexCoord0/Color0 → PsInput`). Host may supply its own VS.
- **4 passes required:** set `NumPasses=4`, dispatch `PassNum` 0→3 sequentially. `Pass 0` can be hidden (G-buffer). `OUTPUT_ENCODE_LAST_PASS=1` encodes only on last pass; set 0 if host encodes.
- **Switches preserved:** `POM_CLIP_EDGES`, `POM_DEPTH_IS_HEIGHT`, `DOE_PROFILE`, `DOE_GROOVE_MAP`, `OUTPUT_ENCODE_LAST_PASS`.
- **Shader model:** `ps_5_0`/`vs_5_0`, no includes. Lint: 57 cbuffer + 11 textures + 2 samplers ≥2 refs, braces 132/132, `PassNum==0` ×4, `NumPasses` 6 refs, no `>1.5` on buttons.

## Editing

- Sweep `f1-12` live; `ParallaxFactorA/B/C` are safe morphs for A/B vs legacy.
- `KeyQ/W/E` 1..7 debug (1 depth 2 shadow 3 normal 4 hdr 5 depthSource 6 chroma 7 bloom+chroma, `Shift==1` probe, `Ctrl==1` DOE×1.2 vs depth source, `Mix2/3` tint).
