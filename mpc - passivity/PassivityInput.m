function u = PassivityInput(x, tau)

    % position reference
    qref = [pi/2 pi/2];

    % STATE VARIABLES
    teta1 = x(1); teta2 = x(2); c1 = cos(teta1); c12 = cos(teta1 + teta2);

    % Proportional controller
    Kp = 16750 * eye(2, 2);
    
    a1 = 1; a2 = 1;         % arm length [m]
    l1 = 0.5; l2 = 0.5;     % distance from center of mass [m]
    ml1 = 50; ml2 = 50;     % arm mass [kg]
    Il1 = 10; Il2 = 10;     % arm inertia [kg m^2]
    kr1 = 100; kr2 = 100;   % motor gear ratio
    mm1 = 5; mm2 = 5;       % motor mass [kg]
    Im1 = 0.01; Im2 = 0.01; % rotor inertia [kg m^2]
    g = 9.81;               % gravitational acceleration [m/s^2]
    
    % GRAVITY TORQUE VECTOR
    g1 = (ml1 * l1 + mm2 * a1 + ml2 * a1) * g * c1 + ml2 * l2 * g * c12;
    g2 = ml2 * l2 * g * c12;
    G = [g1; 
        g2];
    
    q_tilde = [x(1)-qref(1); x(2)-qref(2)];
   
    u = tau - G + Kp * q_tilde;
end