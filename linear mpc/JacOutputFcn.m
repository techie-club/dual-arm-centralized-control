function C = JacOutputFcn(~, ~)
    % function to compute the output Jacobian
    ny = 4; nx = 4; C = eye(ny, nx);
end