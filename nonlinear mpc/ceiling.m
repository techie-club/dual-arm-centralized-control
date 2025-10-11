function cdiseq = Soffitto(X, ~, ~, data, ~)
    % Non-linear inequality constraint function to avoid the ceiling
    % a1 * cos(q1) + a2 * cos(q1 + q2) <= lc

    global lc; a1 = 1; a2 = 1;

    p = data.PredictionHorizon;
    X1 = X(2 : p + 1, 1);
    X2 = X(2 : p + 1, 2);
    
    cdiseq = a1 * sin(X1) + a2 * sin(X1 + X2) - lc;
end