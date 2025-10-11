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
qi = [0; pi/4];            % valori iniziali delle varibili di giunto [rad]
qf = [pi/2; pi/2];         % valori finali delle varibili di giunto [rad]

%% OSTACOLO
% altezza del soffitto [m]
global lc; lc = 1.8;
% raggio e coordinate del centro del cerchio [m]
global cx; global cy; global rc; rc = 1; cx = 2; cy = 2;

ostacolo = 'ceiling';
% ceiling or circle

%% DATI DEL CONTROLLORE

nx = 4;                    % numero di stati
ny = 4;                    % numero di uscite
nu = 2;                    % numero di ingressi
x0 = [0 pi/4 0 0]';        % stato iniziale
x = x0; 
u = zeros(nu, 1);          % ingresso iniziale
Tc = 0.005;                % tempo di campionamento [s]
Hp = 20;                   % orizzonte di predizione
Hc = 2;                    % orizzonte di controllo
Tf = 5;                    % durata della simulazione [s]
tempo = 0 : Tc : Tf;       % vettore dei tempi [s]
nc = length(tempo);        % numero di campioni
r = [pi/2 pi/2 0 0]'...
    .* ones(4, nc);        % riferimenti

%% GENERAZIONE DELLO JACOBIANO DELLO STATO

generaJacobiano

%% CREAZIONE DEL CONTROLLORE

mpcobj = nlmpc(nx, ny, nu);
mpcobj.Ts = Tc; mpcobj.PredictionHorizon = Hp; mpcobj.ControlHorizon = Hc;

mpcobj.Optimization.SolverOptions.UseParallel = true;

mpcobj.Model.StateFcn = 'StateFcn'; mpcobj.Model.OutputFcn = 'OutputFcn';
mpcobj.Jacobian.StateFcn = 'JacStateFcn'; mpcobj.Jacobian.OutputFcn = 'JacOutputFcn';

% PASSIVITA':
mpcobj.Passivity.EnforceConstraint = true;
mpcobj.Passivity.InputFcn = "PassivityInput"; mpcobj.Passivity.OutputFcn = "PassivityOutput";

% VALIDAZIONE DEL MODELLO:
validateFcns(mpcobj, rand(nx, 1), rand(nu, 1))

% PESI:
switch ostacolo
    case {'soffitto'}
        mpcobj.Weights.OutputVariables = [5 5 0 0];
    case {'cerchio'}
        mpcobj.Weights.OutputVariables = [5 5 0 0];
end
mpcobj.Weights.ManipulatedVariablesRate = [0 0];
mpcobj.Weights.ManipulatedVariables = [0 0];

% VINCOLI:
switch ostacolo
    case {'soffitto'}
        mpcobj.Optimization.CustomIneqConFcn = 'Soffitto';
    case {'cerchio'}
        mpcobj.Optimization.CustomIneqConFcn = 'Cerchio';
end
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
    [u, ~, info] = nlmpcmove(mpcobj, x, u, r(:, k)');
    x = info.Xopt(2, :); y = info.Yopt(1, :); V = info.Cost;
    
    c_history = [c_history; toc]; x_history = [x_history; x]; 
    y_history = [y_history; y]; r_history = [r_history; r(:, k)']; 
    v_history = [v_history; V]; u_history = [u_history; u']; tic;
end

%% RISULTATI

traccia_figure