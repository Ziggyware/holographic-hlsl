# Completely Different Approach — Layered Angular Spectrum Holography

**Previous path (`HolographicUnified_Final.hlsl`):** Spatial-domain *point-cloud* Fresnel CGH — per hologram pixel Σ `A·exp(jkr)/r` over 24 object points (ray-like, `O(N·M)`).

**This path (`Holographic_ASM_*`):** Frequency-domain *layered ASM* — 8 depth layers, each `U_z = √albedo·mask_z·exp(j·diffuser)` propagated exactly via `F⁻¹{ F{U_z}·H_z }`, `H_z(fx,fy)=exp(j2πz√(1/λ²-fx²-fy²))` (Rayleigh-Sommerfeld angular spectrum), coherent sum `U_holo=Σ_z Uholo_z`. `O(N log N)` via FFT.

## Why it's different (technique + technology)

| Axis | Point-cloud (old) | Layered ASM (new) |
|---|---|---|
| **Domain** | Spatial sum of spherical waves | Spectral Fourier optics |
| **Propagation** | `exp(jkr)/r` per point | `FFT → multiply H_z → IFFT` per layer |
| **Occlusion** | None (additive) | Binary mask per quantized depth layer, front-to-back energy |
| **Complexity** | `HOLO_SAMPLES=24` rays/pixel | `NumLayers=8` FFTs (`512² log 512`) |
| **Technology** | Pixel shader `PS()` `rtMap` ping-pong | **Compute shader `CSMain` + Stockham FFT** in `groupshared`, **Python `numpy.fft` reference** |
| **Reference** | Same off-axis plane wave `R=exp(jk·x·sinθ)` (`SunX/Y/Z` → `RefAngleDeg=6°`, `LButton` tunes Bragg) — kept physical |
| **Hologram** | Phase `exp(jπ·|R+O|²)` (phase HOE) | Same, but `O` now from ASM layers |
| **Fake math** | None — previous decorative `bloom/ripple/spiral` already stripped to 0 hits | **Also zero** — no `bloom/ripple/spiral/glitch`, no `Worley/Perlin/FBM` |

## Files

- `Holographic_ASM_Layered.py` — runnable Python reference. `pip install numpy pillow`, `python Holographic_ASM_Layered.py` → `/tmp/holo_phase_{R,G,B}.png` (phase `[-π,π]→0..255`), `/tmp/holo_fringe_RGB.png` (intensity `|R+O|²` — true Fresnel zone plates), `/tmp/recon_RGB.png` (back-propagation `z≈0.025 m` via `H_{-z}`).
- `Holographic_ASM_Compute.hlsl` — HLSL 6.6 compute, `cbuffer HoloCB` (`Width/Height/NumLayers/PixelPitch/Zmin/Zmax/LambdaR/G/B/RefAngleDeg`), `DepthMap t0`/`AlbedoMap t1`, `OutPhase u0`/`OutDepthDebug u1`. Outline shows Stockham `FFT1D` in `groupshared` + `ASM_H` kernel; per-pixel direct Fresnel fallback is included for quick preview without full FFT, full FFT path is commented as production.
- `HolographicUnified_Final.hlsl` remains as alternative spatial path — both are kept for comparison, not blended.

## Physics kept

- `PIXEL_PITCH=3.74 µm`, `λ=462/538/612 nm`, `HOLO_SCALE_M=0.08`, `k=2π/λ`, `r_m=|holo-obj|·HOLO_SCALE`
- Thin-film `2×2` characteristic matrix (s/p) + DOE local grating (Gauss-Hermite footprint, `DoeBesselJ`) are **orthogonal** to this path — they model the HOE surface itself, while ASM models the *volume* depth projection. You can cascade: `E_out = E_DOE-film · exp(jπ|R+O_ASM|²)`.
- All fields `complex64` (`re,im`), `CExp/CMul/CAbs2`, `JonesMat`, `DielectricTensor` — no fake `Sigmoid/ColorAdjust`.

## Run

```bash
python3 Holographic_ASM_Layered.py
# view
xdg-open /tmp/holo_fringe_RGB.png   # RGB Fresnel fringes, depth → fringe frequency
xdg-open /tmp/recon_RGB.png         # numerical reconstruction (back-propagated)
```

For GPU: dispatch `CSMain` with `Width=512, Height=512, NumLayers=8`, `PixelPitch=3.74e-6`, `Zmin=0.015, Zmax=0.035`, `RefAngleDeg=6`, `Lambda*` as above. Full FFT path replaces the per-pixel `sqrt(dot+zz)` with tiled FFT.

No fake bloom/ripple/spiral — only diffraction, thin-film, DOE, and wavefront interference.
