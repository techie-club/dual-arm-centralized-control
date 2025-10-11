function y = PassivityOutput(x, ~)

    % utilizzate per calcolare il vincolo di passività
    qdref = [0 0]';
    y = x(3:4) - qdref;

end