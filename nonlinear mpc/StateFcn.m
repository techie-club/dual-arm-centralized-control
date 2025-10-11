function xd = StateFcn(x, u)
    a1 = 1; a2 = 1;         % lunghezza del braccio [m]
    l1 = 0.5; l2 = 0.5;     % distanza dal centro di massa [m]
    ml1 = 50; ml2 = 50;     % massa del braccio [kg]
    Il1 = 10; Il2 = 10;     % momento d'inerzia del braccio [kg m^2]
    kr1 = 100; kr2 = 100;   % rapporto di riduzione del motore
    mm1 = 5; mm2 = 5;       % massa del motore [kg]
    Im1 = 0.01; Im2 = 0.01; % momento d'inerzia del rotore [kg m^2]
    g = 9.81;               % accelerazione di gravità [m/s^2]
    
    % VARIABILI DI STATO
    teta1 = x(1); teta2 = x(2); teta1d = x(3); teta2d = x(4);
    c1 = cos(teta1); s2 = sin(teta2); c2 = cos(teta2); c12 = cos(teta1 + teta2);

    % MATRICE D'INERZIA
    b11 = Il1 + ml1 * l1^2 + kr1^2 * Im1 + Il2 + ...
          ml2 * (a1^2 + l2^2 + 2 * a1 * l2 *c2) + Im2 + mm2 * a1^2;
    b12 = Il2 + ml2 * (l2^2 + a1 * l2 * c2) + kr2 * Im2;
    b21 = b12;
    b22 = Il2 + ml2 * l2^2 + kr2^2 * Im2;
    B = [b11 b12; 
        b21 b22];

    % MATRICE DI CORIOLIS E CENTRIFUGA
    h = -ml2 * a1 * l2 * s2;
    C = [h*teta2d h*(teta1d+teta2d); 
        -h*teta1d 0];

    % VETTORE DELLE COPPIE DI GRAVITA'
    g1 = (ml1 * l1 + mm2 * a1 + ml2 * a1) * g * c1 + ml2 * l2 * g * c12;
    g2 = ml2 * l2 * g * c12;
    G = [g1; 
         g2];

    % VETTORE DELLE VELOCITA'
    qd = [teta1d; teta2d];

    % EQUAZIONE DINAMICA
    qdd = B \ (u -G -C * qd);

    % SISTEMA IN FORMA DI STATI
    xd = [qd; qdd];
end