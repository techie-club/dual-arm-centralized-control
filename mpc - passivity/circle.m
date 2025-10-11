function cdiseq = Cerchio(X, ~, ~, data, ~)
    % Vincolo non lineare per modellare la presenza dell'ostacolo: 
    % -(a1 * cos(q1) + a2 * cos(q1 + q2) - cx)^2
    % -(a1 * sin(q1) + a2 * sin(q1 + q2) - cy)^2 <= -rc^2
    
    a1 = 1; a2 = 1; global cx; global cy; global rc;

    p = data.PredictionHorizon;
    X1 = X(2 : p + 1, 1);
    X2 = X(2 : p + 1, 2);

    cdiseq = -(a1 * cos(X1) + a2 * cos(X1 + X2) - cx).^2 - ...
             (a1 * sin(X1) + a2 * sin(X1 + X2) - cy).^2 + rc^2;
end