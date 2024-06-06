function sor_method()
    % Definindo a matriz A e o vetor b
    A = [1/10, 1/7, 1/15; -17/105, 1/30, 0; 1/30, -253/840, 1/8];
    b = [-28; -20/35; 0];

    % Parâmetros iniciais
    n = length(b);
    x = zeros(n, 1); % Vetor inicial
    omega = 0.19; % Valor de omega
    max_iter = 100;
    tol = 0.01; % Critério de parada (erro relativo 10%)
    div_tol = 1e-6; % Tolerância para verificar não convergência
    stagnation_iter = 10; % Número de iterações para verificar estagnação

    % Iterando com o valor fixo de omega
    previous_errors = ones(stagnation_iter, 1) * inf; % Inicializando erros anteriores para verificar estagnação

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

        % Exibir resultados para cada iteração
        fprintf('Iteração: %d, x1: %06.4f, x2: %06.4f, x3: %06.4f, Erro relativo: %06.4f\n', k, x(1), x(2), x(3), rel_error);

        % Verificar divergência
        if rel_error > previous_errors(end)
            fprintf('Divergência detectada após %d iterações.\n', k);
            break;
        end

        % Atualizar erros anteriores
        previous_errors = [previous_errors(2:end); rel_error];

        % Verificar estagnação
        if max(previous_errors) - min(previous_errors) < div_tol
            fprintf('Estagnação detectada após %d iterações.\n', k);
            break;
        end

        % Verificar se o erro relativo é menor que a tolerância
        if rel_error < tol
            fprintf('Convergência alcançada após %d iterações.\n', k);
            break;
        end
    end

    if k == max_iter
        fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
    end
end
