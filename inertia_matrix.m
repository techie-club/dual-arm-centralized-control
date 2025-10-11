
clear all
close all
clc

%% SYMBOLIC VARIABLES
syms a1 a2           % arm lengths [m]
syms theta_1 theta_2 % joint variables
syms l1 l2           % distances from the center of mass [m]
syms ml1 ml2         % arm masses [kg]
syms mm1 mm2         % motor masses [kg]
syms kr1 kr2         % motor reduction ratios
syms g               % gravitational acceleration [m/s^2]
syms Il1 Il2         % link inertia [kg m^2]
syms Im1 Im2         % rotor inertia [kg m^2]

s1 = sin(theta_1); s2 = sin(theta_2); c1 = cos(theta_1); c2 = cos(theta_2);
s12 = sin(theta_1 + theta_2); c12 = cos(theta_1 + theta_2);

%% JACOBIANS
JP_l1 = [-l1*s1 0; l1*c1 0; 0 0];
JP_l2 = [-a1*s1-l2*s12 -l2*s12; a1*c1+l2*c12 l2*c12; 0 0];

JO_l1 = [0 0; 0 0; 1 0];
JO_l2 = [0 0; 0 0; 1 1];

JP_m1 = [0 0; 0 0; 0 0];
JP_m2 = [-a1*s1 0; a1*c1 0; 0 0];

JO_m1 = [0 0; 0 0; kr1 0];
JO_m2 = [0 0; 0 0; 1 kr2];

%% INERTIA MATRIX
B1 = ml1 * JP_l1.' * JP_l1 + JO_l1.' * Il1 * JO_l1 + mm1 * JP_m1.' * JP_m1 ...
     + JO_m1.' * Im1 * JO_m1;
B2 = ml2 * JP_l2.' * JP_l2 + JO_l2.' * Il2 * JO_l2 + mm2 * JP_m2.' * JP_m2 ...
     + JO_m2.' * Im2 * JO_m2;

B = B1 + B2;
b11 = B(1,1);
b12 = B(1,2);
b22 = B(2,2);

% b11 =
%  Il1 + Il2 + Im2 + Im1*kr1^2 + ml2*(l2*cos(theta_1 + theta_2) + a1*cos(theta_1))^2 + ml2*(l2*sin(theta_1 + theta_2) + a1*sin(theta_1))^2 + a1^2*mm2*cos(theta_1)^2 + l1^2*ml1*cos(theta_1)^2 + a1^2*mm2*sin(theta_1)^2 + l1^2*ml1*sin(theta_1)^2=
% = Il1 + Il2 + Im2 + Im1*kr1^2 +l1^2*ml1+a1^2*mm2+ml2*(l2^2*cos(theta_1 + theta_2)^2 + a1^2*cos(theta_1)^2+2*l2*cos(theta_1 + theta_2)*a1*cos(theta_1))+ml2*(l2^2*sin(theta_1 + theta_2)^2 + a1^2*sin(theta_1)^2+2*l2*sin(theta_1 + theta_2)*a1*sin(theta_1))=
% = Il1 + Il2 + Im2 + Im1*kr1^2 +l1^2*ml1+a1^2*mm2 + ml2*l2^2+ml2*a1^2+2*l2*ml2*a1*cos(theta_2) 
% 
% b12 =
%  Il2 + Im2*kr2 + l2*ml2*cos(theta_1 + theta_2)*(l2*cos(theta_1 + theta_2) + a1*cos(theta_1)) + l2*ml2*sin(theta_1 + theta_2)*(l2*sin(theta_1 + theta_2) + a1*sin(theta_1))=
% = Il2 + Im2*kr2 + l2^2*ml2*cos(theta_1 + theta_2)^2+ l2*ml2*cos(theta_1 + theta_2)*a1*cos(theta_1))
% + l2^2*ml2*sin(theta_1 + theta_2)^2+ l2*ml2*sin(theta_1 + theta_2)*a1*sin(theta_1)=
% = Il2 + Im2*kr2 + l2^2*ml2+ l2*ml2*cos(theta_1 + theta_2)*a1*cos(theta_1))
% + l2*ml2*sin(theta_1 + theta_2)*a1*sin(theta_1)=
% = Il2 + Im2*kr2 + l2^2*ml2+ l2*ml2*a1*cos(theta_2)
% 
% 
% b22 =
%  Im2*kr2^2 + ml2*l2^2*cos(theta_1 + theta_2)^2 + ml2*l2^2*sin(theta_1 + theta_2)^2 + Il2=
% = Im2*kr2^2 + ml2*l2^2 + Il2