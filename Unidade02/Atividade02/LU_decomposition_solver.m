function LU_decomposition_solver()
    % Definindo a matriz A e os vetores b e b2
    A = [2 1 -3; -1 3 2; 3 1 -3];
    b = [2; 0; 1];
    b2 = [3; 1; 2];

    % Exibindo a matriz A e os vetores b e b2
    disp('Matriz A:');
    disp(A);
    disp('Vetor b:');
    disp(b);
    disp('Vetor b2:');
    disp(b2);

    % Decomposição LU
    disp('Iniciando a decomposição LU...');
    [L, U] = lu_decomposition(A);

    % Exibindo as matrizes L e U
    disp('Matriz L após decomposição:');
    disp(L);
    disp('Matriz U após decomposição:');
    disp(U);

    % Resolvendo Ly = b2
    disp('Resolvendo Ly = b2...');
    y = forward_substitution(L, b2);
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
    disp('Matriz L inicial:');
    disp(L);
    disp('Matriz U inicial:');
    disp(U);

    % Decomposição LU
    for j = 1:n-1
        pivot = U(j,j);
        disp(['Processando coluna ', num2str(j), ' com pivô ', num2str(pivot)]);
        for i = j+1:n
            factor = U(i,j) / pivot;
            U(i,:) = U(i,:) - factor * U(j,:);
            L(i,j) = factor;
            disp(['Atualizando L e U na linha ', num2str(i)]);
            disp('Matriz L:');
            disp(L);
            disp('Matriz U:');
            disp(U);
        end
    end
end

function y = forward_substitution(L, b)
    % Resolução de sistemas triangulares inferiores Ly = b
    n = length(b);
    y = zeros(n, 1);
    for i = 1:n
        y(i) = (b(i) - L(i, 1:i-1) * y(1:i-1)) / L(i,i);
        disp(['Calculando y(', num2str(i), '): ', num2str(y(i))]);
    end
end

function x = backward_substitution(U, y)
    % Resolução de sistemas triangulares superiores Ux = y
    n = length(y);
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i,i);
        disp(['Calculando x(', num2str(i), '): ', num2str(x(i))]);
    end
end

