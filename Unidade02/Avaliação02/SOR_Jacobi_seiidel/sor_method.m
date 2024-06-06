function sor_method()
    % Definindo a matriz A e o vetor b
    A = [-17/105, 1/30, 0, 1/10; 1/30, -253/840, 1/8, 1/7; 0, 1/8, -23/120, 1/15; 1/10, 1/7, 1/15, -107/210];
    b = [-20/35; 0; 0; -28];

    % Parâmetros iniciais
    n = length(b); % Determina o número de variáveis
    x = zeros(n, 1); % Vetor inicial de zeros
    omega = 0.19; % Fator de relaxamento
    max_iter = 1000; % Máximo de iterações permitidas
    tol = 0.0001; % Tolerância para o erro relativo
    div_tol = 1e-6; % Tolerância para identificar estagnação
    stagnation_iter = 10; % Janela de iterações para checar estagnação

    previous_errors = ones(stagnation_iter, 1) * inf; % Armazena erros anteriores para detecção de estagnação

    for k = 1:max_iter
        x_old = x;
        for i = 1:n
            sum = 0;
            for j = 1:n
                if j ~= i
                    sum = sum + A(i, j) * x(j);
                end
            end
            x(i) = (1 - omega) * x(i) + omega * (b(i) - sum) / A(i, i);
        end

        % Calcular erro relativo
        rel_error = norm(x - x_old) / norm(x);

        % Exibir resultados de cada iteração
        fprintf('Iteração: %d, ', k);
        for ii = 1:n
            fprintf('x%d: %06.4f, ', ii, x(ii));
        end
        fprintf('Erro relativo: %06.4f\n', rel_error);

        % Checagem de divergência
        if rel_error > previous_errors(end)
            fprintf('Divergência detectada após %d iterações.\n', k);
            break;
        end

        % Atualizar histórico de erros para detecção de estagnação
        previous_errors = [previous_errors(2:end); rel_error];

        % Checar estagnação
        if max(previous_errors) - min(previous_errors) < div_tol
            fprintf('Estagnação detectada após %d iterações.\n', k);
            break;
        end

        % Checar convergência
        if rel_error < tol
            fprintf('Convergência alcançada após %d iterações.\n', k);
            break;
        end
    end

    if k == max_iter
        fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
    end
end
