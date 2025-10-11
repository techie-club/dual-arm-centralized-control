
% Function to generate the state Jacobians of the system

syms teta1 teta2 teta1d teta2d tau1 tau2 real
Xsym = [teta1; teta2; teta1d; teta2d];
Usym = [tau1; tau2];

c1 = cos(teta1); s2 = sin(teta2); c2 = cos(teta2); c12 = cos(teta1+teta2);

% Inertia matrix
b11 = Il1 + ml1 * l1^2 + kr1^2 * Im1 + Il2 + ...
      ml2 * (a1^2 + l2^2 + 2 * a1 * l2 *c2) + Im2 + mm2 * a1^2;
b12 = Il2 + ml2 * (l2^2 + a1 * l2 * c2) + kr2 * Im2;
b21 = b12;
b22 = Il2 + ml2 * l2^2 + kr2^2 * Im2;
B = [b11 b12; 
    b21 b22];

% Coriolis matrix
h = -ml2 * a1 * l2 * s2;
C = [h*teta2d h*(teta1d+teta2d); 
    -h*teta1d 0];

% Gravity torque vector
g1 = (ml1 * l1 + mm2 * a1 + ml2 * a1) * g * c1 + ml2 * l2 * g * c12;
g2 = ml2 * l2 * g * c12;
G = [g1; 
     g2];

% System equations
teta_dd = B \ (-C * [teta1d; teta2d] - G + Usym);
f = [teta1d; teta2d; teta_dd];

% Partial derivatives
Asym = jacobian(f, Xsym);
BUsym = jacobian(f, Usym);

% Create numeric functions
A_fun = matlabFunction(Asym, 'Vars', {Xsym, Usym});
Bu_fun = matlabFunction(BUsym, 'Vars', {Xsym, Usym});

save('Jacobian.mat', 'A_fun', 'Bu_fun');