clear all
close all
clc

%% DATI DEL MANIPOLATORE

a1 = 1; a2 = 1;            % lunghezza del braccio [m]
l1 = 0.5; l2 = 0.5;        % distanza dal centro di massa [m]
ml1 = 50; ml2 = 50;        % massa del braccio [kg]
Il1 = 10; Il2 = 10;        % momento d'inerzia del braccio [kg m^2]
kr1 = 100; kr2 = 100;      % rapporto di riduzione del motore
mm1 = 5; mm2 = 5;          % massa del motore [kg]
Im1 = 0.01; Im2 = 0.01;    % momento d'inerzia del rotore [kg m^2]
g = 9.81;                  % accelerazione di gravità [m/s^2]

%% DATI DEL CONTROLLORE

nx = 4;                    % numero di stati
ny = 4;                    % numero di uscite
nu = 2;                    % numero di ingressi
x0 = [0 pi/4 0 0]';        % stato iniziale
x = x0; 
u = zeros(nu, 1);          % ingresso iniziale
Tc = 0.005;                % tempo di campionamento [s]
Hp = 4;                   % orizzonte di predizione
Hc = 2;                    % orizzonte di controllo
Tf = 5;                    % durata della simulazione [s]
tempo = 0 : Tc : Tf;       % vettore dei tempi [s]
nc = length(tempo);        % numero di campioni

%% GENERAZIONE TRAIETTORIA

wpts1 = [0 pi/2]; wpts2 = [pi/4 pi/2];

[q1, qd1, qdd1, ~] = trapveltraj(wpts1, nc, EndTime=Tf);
[q2, qd2, qdd2, ~] = trapveltraj(wpts2, nc, EndTime=Tf);

q = [q1; q2];              % posizione
qd = [qd1; qd2];           % velocità
qdd = [qdd1; qdd2];        % accelerazione
r = [q; qd];               % riferimenti

%% GENERAZIONE DELLO JACOBIANO DELLO STATO

generaJacobiano

%% LINEARIZZAZIONE DEL SISTEMA

[A, B] = JacStateFcn(x0, u);
C = JacOutputFcn;
D = zeros(ny, nu);
sys = ss(A, B, C, D);

%% CREAZIONE DEL CONTROLLORE

mpcobj = mpc(sys, Tc); xc = mpcstate(mpcobj, x0);
mpcobj.Ts = Tc; mpcobj.PredictionHorizon = Hp; mpcobj.ControlHorizon = Hc;

% PESI:
mpcobj.Weights.OutputVariables = [1 1 1 1];
mpcobj.Weights.ManipulatedVariablesRate = [0 0];
mpcobj.Weights.ManipulatedVariables = [0 0];

% VINCOLI:
for i = 1 : nu
    % saturazione attuatori
    mpcobj.ManipulatedVariables(i).Min = -1000;
    mpcobj.ManipulatedVariables(i).Max = 1000;
end

%% SIMULAZIONE

u_history = []; x_history = []; y_history = [];
r_history = []; v_history = []; c_history = [];
tic;
for k = 1 : nc
    y = C * xc.Plant;

    [u, info] = mpcmove(mpcobj, xc, y, r(:, k)');
    x = xc.Plant; V = info.Cost;
    
    c_history = [c_history; toc]; x_history = [x_history; x']; 
    y_history = [y_history; y']; r_history = [r_history; r(:, k)']; 
    v_history = [v_history; V]; u_history = [u_history; u']; tic;
end

%% RISULTATI

trace_figures