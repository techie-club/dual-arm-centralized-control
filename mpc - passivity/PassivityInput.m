function u = PassivityInput(x, tau)

    % riferimento di posizione
    qref = [pi/2 pi/2];

    % VARIABILI DI STATO
    teta1 = x(1); teta2 = x(2); c1 = cos(teta1); c12 = cos(teta1 + teta2);

    % Regolatore proporzionale
    Kp = 16750 * eye(2, 2);
    
    a1 = 1; a2 = 1;         % lunghezza del braccio [m]
    l1 = 0.5; l2 = 0.5;     % distanza dal centro di massa [m]
    ml1 = 50; ml2 = 50;     % massa del braccio [kg]
    Il1 = 10; Il2 = 10;     % momento d'inerzia del braccio [kg m^2]
    kr1 = 100; kr2 = 100;   % rapporto di riduzione del motore
    mm1 = 5; mm2 = 5;       % massa del motore [kg]
    Im1 = 0.01; Im2 = 0.01; % momento d'inerzia del rotore [kg m^2]
    g = 9.81;               % accelerazione di gravità [m/s^2]
    
    % VETTORE DELLE COPPIE DI GRAVITA'
    g1 = (ml1 * l1 + mm2 * a1 + ml2 * a1) * g * c1 + ml2 * l2 * g * c12;
    g2 = ml2 * l2 * g * c12;
    G = [g1; 
         g2];
    
    q_tilde = [x(1)-qref(1); x(2)-qref(2)];
   
    u = tau - G + Kp * q_tilde;
end