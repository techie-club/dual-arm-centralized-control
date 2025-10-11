function y = PassivityOutput(x, ~)
    % used to calculate the passivity constraint
    qdref = [0 0]';
    y = x(3:4) - qdref;
end