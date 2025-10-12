clear all
close all
clc

%% MANIPULATOR DATA

a1 = 1; a2 = 1;            % arm length [m]
l1 = 0.5; l2 = 0.5;        % distance from center of mass [m]
ml1 = 50; ml2 = 50;        % arm mass [kg]
Il1 = 10; Il2 = 10;        % link inertia [kg m^2]
kr1 = 100; kr2 = 100;      % motor reduction ratio
mm1 = 5; mm2 = 5;          % motor mass [kg]
Im1 = 0.01; Im2 = 0.01;    % rotor inertia [kg m^2]
g = 9.81;                  % gravitational acceleration [m/s^2]
n = 2;                     % number of joints
qi = [0; pi/4];            % initial joint variables [rad]
qf = [pi/2; pi/2];         % final joint variables [rad]

%% SIMULATION DATA
Tc = 0.005;                % sampling time [s]
Tf = 5;                    % simulation duration [s]
tempo = 0 : Tc : Tf;       % time vector [s]
nc = length(tempo);        % number of samples

%% TRAJECTORY GENERATION

wpts1 = [0 pi/2]; wpts2 = [pi/4 pi/2]; 

[q1ref, qd1ref, qdd1ref, ~] = trapveltraj(wpts1, nc, EndTime=Tf);
[q2ref, qd2ref, qdd2ref, ~] = trapveltraj(wpts2, nc, EndTime=Tf);

qref = [tempo; q1ref; q2ref]';       % position
qdref = [tempo; qd1ref; qd2ref]';    % velocity
qddref = [tempo; qdd1ref; qdd2ref]'; % acceleration

%% CONTROL LOGIC MODELING

ro = 0.1;
eps = 0.004;

H = zeros(2 * n, 2 * n);
H(1:n, n+1:end) = eye(n);

D = [zeros(n, n); eye(n)];

Kp = 25 * eye(n);
Kd = 5 * eye(n);
K = [Kp Kd];

H_tilde = H - D * K;

P = eye(2 * n);
Q = lyap(H_tilde, P); % Lyapunov criterion
try chol(Q);
    fprintf('The computed matrix Q is positive definite.\n')
catch ME
    fprintf('The computed matrix Q is not positive definite.\n')
end

%% SIMULATION

tic;
sim('robust_control.slx')
tf = toc;

%% RESULTS

trace_figures