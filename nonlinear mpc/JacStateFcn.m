function [A, Bu] = JacStateFcn(x, u)
    % function to load and evaluate the state Jacobian
    persistent A_fun Bu_fun

    if isempty(A_fun)
        load('Jacobian.mat', 'A_fun', 'Bu_fun');
    end
    
    A = A_fun(x, u);
    Bu = Bu_fun(x, u);
end