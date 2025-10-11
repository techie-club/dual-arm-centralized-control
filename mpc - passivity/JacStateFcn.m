function [A, Bu] = JacStateFcn(x, u)
    % funzione per caricare e modellare gli jacobiani degli stati
    persistent A_fun Bu_fun

    if isempty(A_fun)
        load('Jacobiano.mat', 'A_fun', 'Bu_fun');
    end
    
    A = A_fun(x, u);
    Bu = Bu_fun(x, u);
end