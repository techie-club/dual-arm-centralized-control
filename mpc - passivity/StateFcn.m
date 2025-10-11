function xd = StateFcn(x, u)
    a1 = 1; a2 = 1;         % arm length [m]
    l1 = 0.5; l2 = 0.5;     % distance from center of mass [m]
    ml1 = 50; ml2 = 50;     % arm mass [kg]
    Il1 = 10; Il2 = 10;     % link inertia [kg m^2]
    kr1 = 100; kr2 = 100;   % motor reduction ratio
    mm1 = 5; mm2 = 5;       % motor mass [kg]
    Im1 = 0.01; Im2 = 0.01; % rotor inertia [kg m^2]
    g = 9.81;               % gravitational acceleration [m/s^2]
    
    % STATE VARIABLES
    teta1 = x(1); teta2 = x(2); teta1d = x(3); teta2d = x(4);
    c1 = cos(teta1); s2 = sin(teta2); c2 = cos(teta2); c12 = cos(teta1 + teta2);

    % INERTIA MATRIX
    b11 = Il1 + ml1 * l1^2 + kr1^2 * Im1 + Il2 + ...
          ml2 * (a1^2 + l2^2 + 2 * a1 * l2 *c2) + Im2 + mm2 * a1^2;
    b12 = Il2 + ml2 * (l2^2 + a1 * l2 * c2) + kr2 * Im2;
    b21 = b12;
    b22 = Il2 + ml2 * l2^2 + kr2^2 * Im2;
    B = [b11 b12; 
        b21 b22];

    % CORIOLIS AND CENTRIFUGAL MATRIX
    h = -ml2 * a1 * l2 * s2;
    C = [h*teta2d h*(teta1d+teta2d); 
        -h*teta1d 0];

    % GRAVITY TORQUES VECTOR
    g1 = (ml1 * l1 + mm2 * a1 + ml2 * a1) * g * c1 + ml2 * l2 * g * c12;
    g2 = ml2 * l2 * g * c12;
    G = [g1; 
         g2];

    % VELOCITY VECTOR
    qd = [teta1d; teta2d];

    % DYNAMIC EQUATION
    qdd = B \ (u -G -C * qd);

    % STATE-SPACE FORM
    xd = [qd; qdd];
end