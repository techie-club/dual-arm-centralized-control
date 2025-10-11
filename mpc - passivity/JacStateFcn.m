function [A, Bu] = JacStateFcn(x, u)
    % function to compute the Jacobian of the state function
    % with respect to states and inputs
    persistent A_fun Bu_fun

    if isempty(A_fun)
        load('Jacobiano.mat', 'A_fun', 'Bu_fun');
    end
    
    A = A_fun(x, u);
    Bu = Bu_fun(x, u);
end