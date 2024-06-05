function LU_decomposition_solver()
    % Definindo a matriz A e o vetor b
    A = [1/10, 1/7, 1/15; -17/105, 1/30, 0; 1/30, -253/840, 1/8];
    b = [-28; -20/35; 0];

    % Exibindo a matriz A e o vetor b
    disp('Matriz A:');
    disp(A);
    disp('Vetor b:');
    disp(b);

    % Decomposição LU
    disp('Iniciando a decomposição LU...');
    [L, U] = lu_decomposition(A);

    % Exibindo as matrizes L e U
    disp('Matriz L após decomposição:');
    disp(L);
    disp('Matriz U após decomposição:');
    disp(U);

    % Resolvendo Ly = b
    disp('Resolvendo Ly = b...');
    y = forward_substitution(L, b);
    disp('Vetor intermediário y:');
    disp(y);

    % Resolvendo Ux = y
    disp('Resolvendo Ux = y...');
    x = backward_substitution(U, y);
    disp('Solução do sistema x:');
    disp(x);
end

function [L, U] = lu_decomposition(A)
    % Verifica se a matriz A é quadrada
    [n, m] = size(A);
    if n ~= m
        error('A matriz deve ser quadrada.');
    end

    % Inicializa L e U
    L = eye(n);
    U = A;

    % Decomposição LU
    for j = 1:n-1
        if U(j,j) == 0
            error('Pivô zero encontrado, precisa de pivoteamento ou ajuste.');
        end
        for i = j+1:n
            L(i,j) = U(i,j) / U(j,j);
            U(i,j:n) = U(i,j:n) - L(i,j) * U(j,j:n);
        end
    end
end

function y = forward_substitution(L, b)
    % Resolução de sistemas triangulares inferiores Ly = b
    n = length(b);
    y = zeros(n, 1);
    y(1) = b(1) / L(1,1);
    for i = 2:n
        y(i) = (b(i) - L(i, 1:i-1) * y(1:i-1)) / L(i,i);
    end
end

function x = backward_substitution(U, y)
    % Resolução de sistemas triangulares superiores Ux = y
    n = length(y);
    x = zeros(n, 1);
    x(n) = y(n) / U(n,n);
    for i = n-1:-1:1
        x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i,i);
    end
end
