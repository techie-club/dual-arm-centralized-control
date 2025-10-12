clear all
close all
clc

%% MANIPULATOR PARAMETERS

a1 = 1; a2 = 1;            % arm length [m]
l1 = 0.5; l2 = 0.5;        % distance from center of mass [m]
ml1 = 50; ml2 = 50;        % arm mass [kg]
Il1 = 10; Il2 = 10;        % arm inertia [kg m^2]
kr1 = 100; kr2 = 100;      % motor gear ratio
mm1 = 5; mm2 = 5;          % motor mass [kg]
Im1 = 0.01; Im2 = 0.01;    % rotor inertia [kg m^2]
g = 9.81;                  % gravitational acceleration [m/s^2]
qi = [0; pi/4];            % initial joint variables [rad]
qf = [pi/2; pi/2];         % final joint variables [rad]

%% OBSTACLE
% ceiling height [m]
global lc; lc = 1.8;
% circle radius and center coordinates [m]
global cx; global cy; global rc; rc = 1; cx = 2; cy = 2;

obstacle = 'ceiling';
% ceiling or circle

%% CONTROLLER SETTINGS

nx = 4;                    % number of states
ny = 4;                    % number of outputs
nu = 2;                    % number of inputs
x0 = [0 pi/4 0 0]';        % initial state
x = x0; 
u = zeros(nu, 1);          % initial input
Tc = 0.005;                % sampling time [s]
Hp = 20;                   % prediction horizon
Hc = 2;                    % control horizon
Tf = 5;                    % simulation duration [s]
tempo = 0 : Tc : Tf;       % time vector [s]
nc = length(tempo);        % number of samples
r = [pi/2 pi/2 0 0]'...
    .* ones(4, nc);        % references

%% GENERATE STATE JACOBIAN

generateJacobian

%% CREATE CONTROLLER

mpcobj = nlmpc(nx, ny, nu);
mpcobj.Ts = Tc; mpcobj.PredictionHorizon = Hp; mpcobj.ControlHorizon = Hc;

mpcobj.Optimization.SolverOptions.UseParallel = true;

mpcobj.Model.StateFcn = 'StateFcn'; mpcobj.Model.OutputFcn = 'OutputFcn';
mpcobj.Jacobian.StateFcn = 'JacStateFcn'; mpcobj.Jacobian.OutputFcn = 'JacOutputFcn';

% PASSIVITY:
mpcobj.Passivity.EnforceConstraint = true;
mpcobj.Passivity.InputFcn = "PassivityInput"; mpcobj.Passivity.OutputFcn = "PassivityOutput";

% MODEL VALIDATION:
validateFcns(mpcobj, rand(nx, 1), rand(nu, 1))

% WEIGHTS:
switch obstacle
    case {'ceiling'}
        mpcobj.Weights.OutputVariables = [5 5 0 0];
    case {'circle'}
        mpcobj.Weights.OutputVariables = [5 5 0 0];
end
mpcobj.Weights.ManipulatedVariablesRate = [0 0];
mpcobj.Weights.ManipulatedVariables = [0 0];

% CONSTRAINTS:
switch obstacle
    case {'ceiling'}
        mpcobj.Optimization.CustomIneqConFcn = 'ceiling';
    case {'circle'}
        mpcobj.Optimization.CustomIneqConFcn = 'circle';
end
for i = 1 : nu
    % actuator saturation
    mpcobj.ManipulatedVariables(i).Min = -1000;
    mpcobj.ManipulatedVariables(i).Max = 1000;
end

%% SIMULATION

u_history = []; x_history = []; y_history = [];
r_history = []; v_history = []; c_history = [];
tic;
for k = 1 : nc
    [u, ~, info] = nlmpcmove(mpcobj, x, u, r(:, k)');
    x = info.Xopt(2, :); y = info.Yopt(1, :); V = info.Cost;
    
    c_history = [c_history; toc]; x_history = [x_history; x]; 
    y_history = [y_history; y]; r_history = [r_history; r(:, k)']; 
    v_history = [v_history; V]; u_history = [u_history; u']; tic;
end

%% RESULTS

trace_figures