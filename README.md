# Dual-Arm Centralized Control (MATLAB/Simulink)

This repository contains example controllers and reference implementations for a planar two-joint manipulator. The projects demonstrate different control approaches: adaptive control, robust control, linear MPC, nonlinear MPC, and MPC with passivity constraints.

## Top-level folders
- `adaptive control/` — Adaptive controller implemented with a Simulink model and accompanying MATLAB scripts.
- `robust control/` — Example of a robust control setup (Simulink + scripts).
- `linear mpc/` — Linear Model Predictive Control (MPC) example and supporting functions.
- `nonlinear mpc/` — Nonlinear MPC example using MATLAB and symbolic Jacobian generation.
- `mpc - passivity/` — Nonlinear MPC example with passivity constraints and custom input/output passivity definitions.

## Other files
- `inertial_matrix.m` — Script to compute the manipulator inertia matrix.
- [Relation](https://github.com/simo1101/dual-arm-centralized-control/blob/main/relation.pdf) - Detailed description of the proposed methods. 

## Quick start
1. Open MATLAB and set the repository root as the current folder or add it to the MATLAB path.
2. Choose the example folder you want to run (for example `linear mpc/`) and open the folder in MATLAB.
3. Follow the folder README (each example folder contains a README with quick instructions). Typical steps:

```matlab
% (optional) regenerate symbolic Jacobians
generateJacobian
% run the main script for the example
main
```

## Requirements
- MATLAB (R2019b or later recommended)
- Simulink (required for examples that use a Simulink model)
- Symbolic Math Toolbox
- Robotics System Toolbox
- Control System Toolbox
- Model Predictive Control Toolbox (required by MPC examples)
