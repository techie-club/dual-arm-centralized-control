function C = JacOutputFcn(~, ~)
    % funzione per modellare lo jacobiano delle uscite del sistema
    ny = 4; nx = 4; C = eye(ny, nx);
end