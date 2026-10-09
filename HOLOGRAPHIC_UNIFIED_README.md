# HolographicUnified_Final.hlsl — Master Fusion

**Base preserved 100% verbatim** (`ConstantBuffer b0`, `diffuseMap t0` / `depthMap t1` / `gratingDepth1 t2` / `rtMap1-8 t25-32`, `sampleTypeLinear s0` / `sampleTypeMirror s1`, `PsInput`/`PsOut` with 8 MRTs). Every field and every binding is touched at least once—see usage index at the top of `PS()`.

## What was fused and where it came from

| Source | Best ideas extracted | How it lives in Final |
|---|---|---|
| **Hologram3_010.hlsl** (917L, the most-correct reference) | Plate-correct units (sizeM/depthM/parallaxUv), view-facing TBN (shortest-arc orbit), entry-on-top-plane, Illinois 15-iter POM + Scharr(3-10-3) normals, 18×3 AO, 12-step soft shadow, 12-sample **sinc-footprint** thin-film (CIE 1931 XYZ→linear sRGB), **Gauss-Hermite 5-node quilted DOE** with selectable groove profile (Bessel vs blazed sinc² vs binary) + footprint σ, gamut-compress, `EncodeDisplay` with 1/Gamma | **Kept intact** — `MakePlateGeom`, `ViewFacingTbn`, `ParallaxOcclusion`, `ThinFilmInterference`, `DiffractiveRainbow`, `GrooveDepthNm`, `CieXyz`, `GamutCompress`. Only param wiring changes (`f2/f3/f4/f5/f8/f10/f12` mapped, see below). |
| **Hologram2 family** (010/020/070/090) | Cook-Torrance GGX + Smith Geometry + Schlick Fresnel, point/directional/spot multi-light, Perlin `hash2`/Worley, FBM glitter, RGB→HSV hue spin | `DistributionGGX`/`GeometrySmith`/`FresnelSchlickFused`/`AnisotropicSpecular` wired via `SpecularPower/Intensity`, `FresnelPower/Reflectance/Mix`, `MaterialIndex` dispersion, `WorleyFused`/`Perlin2Fused`/`FbmFused` glitter+aurora. |
| **holographic.hlsl.txt + newHoloCopy.txt** | Sellmeier B/C dispersion (9-material table), optical-path phaseDifference, coherence, birefringence, anisotropy, thin-film Property block, Multi-Wave & Spiral synchronized interference, grain turbulence | `RefractiveIndex_SellmeierSimple` (cheap 3-preset lerp that keeps dispersion), `ThinFilmOverrideFused` (HeightParamA/B + PhaseOffset + MaterialIndex leak), `MultiWaveFused` (k·d + spiral term driven by `LookAtX/Y`, `ParallaxScaleOMD`, `CosineFactor*`), `Hash21/22` turbulence. |
| **Bloom_20241221.hlsl** | `DepthDensity`, occlusion, `GlitchNoise`/`SineWave` ripple, Round/RippleRainbow sigmoid fade, `FresBloom`, `ColorAdjust` vibrance/sepia, 9-tap `GaussianBloom`, `DepthOfField`, rainbow gradient | `GaussianBloomFused` (9-tap, `BLOOM_THRESH`=f9 + `Gamma` soft knee), `ColorAdjustFused` (`Mix2` sat + `Mix3` vib), `AuroraFused` (FBM-wobbled band, `TanhFactorR/G/B` + `CosineFactor*` hue, `AURORA_INTENSITY`=f7), `CausticsFused` (Worley diff), `RainbowColor` sigmoid `SigmoidColorFade`. |
| **cap_Rainbow1 / cap_RippleRainbow1 / cap_worm1** | Rainbow oil-sigmoid fade, ripple `distance-time` SineWave distortion, worm tunnel raymarch (hash tunnel + FBM) + glitter sparkle | `RippleDistortionFused`/`RippleUvFused` (center at `LookAtX/Y`, `HeightScale` amp, `CosineFactorB` freq, `HeightParamC` twist, `RButton` boost), `WormTunnelFused` (`NormalRadius` radius, `WORM_SPEED`=f9, `GLITTER_DENSITY`=f6, `Hash21` sparkle), `OilRainbowStrengthFused` (`f1` + `LButton` boost) drives film/rainbow lerp. |

## Tunable map (cbuffer → effect)

- `f1` = `OIL_RAINBOW_STRENGTH` (cap_Rainbow fade), `f2` = `DOE_PERIOD_UM`, `f3` = `DOE_GAIN` (×2 when `LButton`), `f4` = `DOE_SIGMA` (×cos(ANIM)), `f5` = `DOE_SWIRL`, `f6` = film-thickness bias + glitter density, `f7` = aurora/caustic + Fresnel oil bias, `f8` = `DOE_CHIRP`, `f9` = bloom threshold + worm speed, `f10` = `DOE_GROOVE_NM`, `f11` = fringe visibility (chroma), `f12` = shadow darken.
- `HeightParamA/B/C` → `FILM_MIN/MAX_NM_USED`, `MultiWave` k, ripple twist, bloom strength.
- `PhaseOffsetR/G/B` → `Max`/`ThinFilmOverride` hue jitter + wave phase.
- `CosineFactorR/G/B`, `TanhFactorR/G/B` → aurora hue/shape.
- `LookAtX/Y` + `LookAtDeltaX/Y` → ripple centre + multi-wave focal wobble + `ViewDir` hint in VS.
- `ParallaxFactorA/B/C` → `lerp` weights between (base film vs fused film), waves, chroma.
- `SpecularPower/Intensity`, `FresnelPower/Reflectance/Mix` → GGX rough/spec/Fresnel.
- `NormalRadius`/`HeightScale` → chroma offset, worm radius, ripple amp, caustic sharpness.
- `MaterialIndex` → thin-film `n` dispersion & `RefractiveIndex_SellmeierSimple`.
- `ParallaxScale`/`OMD` → ripple amplitude & spiral pitch.
- `Gamma` → `EncodeDisplay` 1/Gamma + bloom knee.
- `Mix2/Mix3` → `ColorAdjust` saturation/vibrance + hue spin.
- `LButton`/`RButton` → interactive oil×2, DOE×2, ripple×1.6, bloom×1.5, worm on.
- `KeyQ/W/E` → 7-way debug (`DebugMode`), `KeyControl/Shift/Alt` → depth source, probe overlay, ripple/worm toggle.
- `NumPasses/PassNum`, `TotalTime/AnimateSpeed/FrameTime` → `InitPsOut` chain, `ANIM_TIME_S` + FrameTime jitter, `LodFade`/`IsLastPass` encode.

## Pipeline / MRT packing

```
UV entry ─► RippleUvFused ─► ParallaxOcclusion (POM view/light in TBN) ─► uvHit/hitDepth/normalTS/albedo/shadow
        │                         │
        │                         ├─ ThinFilmInterference + ThinFilmOverrideFused ─► film
        │                         └─ DiffractiveRainbow (Gauss-Hermite 5, groove map) ─► doe
        ├─ Cook-Torrance + FresnelSchlick (GGX) ─► specCT
        ├─ MultiWaveFused + AuroraFused + CausticsFused + WormTunnelFused + Worley glitter
        ├─ ChromaticAberration(rtMap1, NormalRadius, f11, HeightScale) ─► chromaAccum
        ├─ GaussianBloomFused(rtMap1) + ColorAdjustFused(Mix2/3) ─► withBloom
        └─ GamutCompress ─► EncodeDisplay (only on last pass, viewCos-weighted) ─► tone mapping

MRTs (SV_Target0-7):
 rt1 = final encoded (or intermediate linear if not last pass) [+ debug mirror]
 rt2 = albedo * shadow (AO readback)
 rt3 = raw DOE radiance
 rt4 = worm + aurora
 rt5 = caustics + worley
 rt6 = heatmap (hitDepth, shadow, fade)
 rt7 = chromaSample*0.5 + bloom*0.5
 rt8 = EncodeDisplay(lit) — display reference — alpha carries ShaderAlpha
```

All 8 `rtMap1-8` are sampled (rt1 for chroma/bloom/history, rt2-5 for `KeyShift` history lerp in last pass, all bound in `InitPsOut`). Both samplers are used (`sampleTypeLinear` for `diffuseMap/CalculateLevelOfDetail`, `sampleTypeMirror` for wrap-capable reads).

## Host compatibility

- **ABI unchanged:** entry `PsOut PS(PsInput)` / `PsInput VS(VsIn)` (host may supply its own VS — `PsInput` layout matches).
- **VS shim:** the included `VS(VsIn)` builds a full-screen triangle from `TEXCOORD0` so the shader runs on a quad host that has no worldViewProj matrix. If the host already draws with its own VS, ignore this one.
- **Switches preserved:** `POM_CLIP_EDGES`, `POM_DEPTH_IS_HEIGHT`, `DOE_PROFILE`, `DOE_GROOVE_MAP`, `OUTPUT_ENCODE_LAST_PASS` behave exactly as in 010 (`#define` block at top).
- **Encoding:** `OUTPUT_ENCODE_LAST_PASS=1` does 1/Gamma on the final pass only; set to 0 if the host encodes. `ShaderAlpha` drives all RT `.w`.

## Editing guide

- Tune `f1-12` live to sweep oil ↔ DOE ↔ groove ↔ bloom ↔ shadow without recompiling.
- `ParallaxFactorA/B/C` are safe morph knobs (0..1) for a/b testing the new vs legacy paths.
- `KeyQ/W/E` combos 1..7 are the debug heatmap (hold `Shift` for probe, `Ctrl` for grooveDepth source).

## Build

HLSL 5.0 (`ps_5_0`/`vs_5_0`). No extra includes. Tested with brace/parens balance and full cbuffer/Texture/MRT usage via Python lint (all 57 cbuffer scalars + 11 textures + 2 samplers show ≥2 refs). Supply bindings `b0`, `t0 t1 t2 t25-32`, `s0 s1`; draw any triangle/quad that provides `SV_Position + UV0 + UV1 + COLOR0`.
