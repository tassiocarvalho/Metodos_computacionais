function gauss_jordan_solver()
    % Definindo a matriz A e o vetor b
    A = [-0.04 0.04 0.12; 0.56 -1.56 0.32; -0.24 1.24 -0.28];
    b = [3; 1; 0];

    % Chamando a função gauss_jordan
    [x, A_inv] = gauss_jordan(A, b);

    % Exibindo a solução
    disp('Solução do sistema:');
    disp(x);

    % Exibindo a matriz inversa
    disp('Matriz inversa de A:');
    disp(A_inv);
end

function [x, A_inv] = gauss_jordan(A, b)
    % Verifica se a matriz A é quadrada
    [n, m] = size(A);
    if n ~= m
        error('A matriz deve ser quadrada.');
    end

    % Cria a matriz aumentada [A | I | b]
    Ab = [A, eye(n), b];

    % Processo de Gauss-Jordan
    for k = 1:n
        % Pivoteamento parcial para evitar divisão por zero
        [~, idxMax] = max(abs(Ab(k:n, k)));
        idxMax = idxMax + k - 1;
        if idxMax ~= k
            % Troca as linhas
            temp = Ab(k, :);
            Ab(k, :) = Ab(idxMax, :);
            Ab(idxMax, :) = temp;
            disp(['Troca de linha ', num2str(k), ' com linha ', num2str(idxMax), ':']);
            disp(Ab);
        end

        % Normaliza a linha pivô
        Ab(k, :) = Ab(k, :) / Ab(k, k);
        disp(['Normalizando linha ', num2str(k), ':']);
        disp(Ab);

        % Elimina os elementos acima e abaixo do pivô
        for i = 1:n
            if i ~= k
                fator = Ab(i, k);
                Ab(i, :) = Ab(i, :) - fator * Ab(k, :);
                disp(['Eliminando elemento da linha ', num2str(i), ', coluna ', num2str(k), ':']);
                disp(Ab);
            end
        end
    end

    % A solução do sistema está na última coluna de Ab
    x = Ab(:, end);

    % A matriz inversa está nas colunas n+1 a 2n de Ab
    A_inv = Ab(:, n+1:2*n);
end