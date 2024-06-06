function x = eliminacao_gauss()

    % Definindo a matriz A e o vetor b
    A = [-17/105, 1/30, 0, 1/10; 1/30, -253/840, 1/8, 1/7; 0, 1/8, -23/120, 1/15; 1/10, 1/7, 1/15, -107/210];
    b = [-20/35; 0; 0; -28];


    % Verifica se a matriz A é quadrada
    [n, m] = size(A);
    if n ~= m
        error('A matriz deve ser quadrada.');
    end

    % Extende a matriz A com o vetor b
    Ab = [A, b];
    disp('Matriz extendida A|b inicial:');
    disp(Ab);

    % Processo de Eliminação de Gauss
    for k = 1:n-1
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

        if Ab(k, k) == 0
            error('Divisão por zero detectada após tentativa de pivoteamento.');
        end

        for i = k+1:n
            fator = Ab(i, k) / Ab(k, k);
            Ab(i, k:n+1) = Ab(i, k:n+1) - fator * Ab(k, k:n+1);
            disp(['Eliminando elemento da linha ', num2str(i), ', coluna ', num2str(k), ':']);
            disp(Ab);
        end
    end

    % Substituição para trás para resolver o sistema
    x = zeros(n, 1); % Inicializa o vetor de soluções
    for i = n:-1:1
        x(i) = (Ab(i, n+1) - Ab(i, i+1:n) * x(i+1:n)) / Ab(i, i);
        disp(['Calculando x(', num2str(i), '): ', num2str(x(i))]);
    end
end


