function x = eliminacao_gauss_no_pivo()

    % Definindo a matriz A e o vetor b
    A = [1/10, 1/7, 1/15; -17/105, 1/30, 0; 1/30, -253/840, 1/8];
    b = [-28; -20/35; 0];
    % Verifica se a matriz A é quadrada
    [n, m] = size(A);
    if n ~= m
        % Gera um erro se a matriz não for quadrada
        error('A matriz deve ser quadrada.');
    end

    % Extende a matriz A com o vetor b para formar a matriz aumentada Ab
    Ab = [A, b];

    % Inicia o processo de Eliminação de Gauss
    for k = 1:n-1
        % Verifica se o elemento pivô é zero
        if Ab(k, k) == 0
            % Gera um erro se o pivô for zero, já que não é possível dividir por zero
            error('Divisão por zero detectada. Considere usar pivoteamento.');
        end

        % Loop para percorrer as linhas abaixo da linha do pivô atual
        for i = k+1:n
            % Calcula o fator de multiplicação para eliminar o elemento abaixo do pivô
            fator = Ab(i, k) / Ab(k, k);
            % Realiza a operação elementar de linha para zerar o elemento abaixo do pivô
            Ab(i, k:n+1) = Ab(i, k:n+1) - fator * Ab(k, k:n+1);
            % Mostra a matriz aumentada após cada operação de eliminação
            disp(['Eliminando elemento da linha ', num2str(i), ', coluna ', num2str(k), ':']);
            disp(Ab);
        end
    end

    % Inicia a substituição para trás para resolver o sistema
    x = zeros(n, 1); % Inicializa o vetor de soluções com zeros
    for i = n:-1:1
        % Calcula o valor de x(i) usando a substituição para trás
        x(i) = (Ab(i, n+1) - Ab(i, i+1:n) * x(i+1:n)) / Ab(i, i);
    end
end
