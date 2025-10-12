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
n = 2;                     % number of joints
qi = [0; pi/4];            % initial joint variables [rad]
qf = [pi/2; pi/2];         % final joint variables [rad]

%% SIMULATION SETTINGS
Tc = 0.005;                % sampling time [s]
Tf = 5;                    % simulation duration [s]
tempo = 0 : Tc : Tf;       % time vector [s]
nc = length(tempo);        % number of samples

%% TRAJECTORY GENERATION

% trajectory with trapezoidal velocity profile
wpts1 = [0 pi/2]; wpts2 = [pi/4 pi/2]; 
[q1ref, qd1ref, qdd1ref, ~] = trapveltraj(wpts1, nc, EndTime=Tf);
[q2ref, qd2ref, qdd2ref, ~] = trapveltraj(wpts2, nc, EndTime=Tf);

% % third-order polynomial trajectory
% tpts = [0 Tf];
% [q1ref, qd1ref, qdd1ref, ~] = cubicpolytraj(wpts1, tpts, tempo);
% [q2ref, qd2ref, qdd2ref, ~] = cubicpolytraj(wpts2, tpts, tempo);

qref = [tempo; q1ref; q2ref]';       % position
qdref = [tempo; qd1ref; qd2ref]';    % velocity
qddref = [tempo; qdd1ref; qdd2ref]'; % acceleration

%% CONTROLLER LOGIC

lambda = 5 * eye(n);
Kd = 750 * eye(n);
Kpi = 0.01 * eye(8);

% initial parameter vector, before variation
pi1 = ml1 + mm2;
pi2 = ml1 * (l1 - a1);
pi3 = Il1 + ml1 * (l1 - a1)^2 + Im2;
pi4 = Im1;
pi5 = ml2;
pi6 = ml2 * (l2 - a2);
pi7 = Il2 + ml2 * (l2 - a2)^2;
pi8 = Im2;
pi = [pi1 pi2 pi3 pi4 pi5 pi6 pi7 pi8]';

% final parameter vector, after variation
delta_m2 = 10;
delta_m2lc2 = 11;
delta_I2hat = 12.12;

pi5 = pi5 - delta_m2;
pi6 = pi6 - delta_m2lc2;
pi7 = pi7 - delta_I2hat;

% final parameter vector, with time history
I = ones(1, length(tempo));
pi_t = [tempo; I*pi1; I*pi2; I*pi3; I*pi4; I*pi5; I*pi6; I*pi7; I*pi8]';

%% SIMULATION

tic;
sim('adaptive_control.slx')
tf = toc;

%% RESULTS

trace_figures