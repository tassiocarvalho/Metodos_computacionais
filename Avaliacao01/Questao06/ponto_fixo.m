function ponto_fixo()
    % Constantes
    g = 9.81; % m/s^2
    Q = 20;   % m^3/s
    lambda = 0.05; % fator de relaxamento
    tol = 0.01; % tolerância de 1%
    
    % Inicialização
    y = 1.2; % chute inicial
    erro = Inf;
    iter = 0;
    max_iter = 20; % limite de iterações

    % Armazena os resultados das iterações
    iters = [];
    estimativas = [];
    f_values = [];
    aprox_errors = [];
    true_errors = [];
    
    % Método do ponto fixo
    while erro > tol && iter < max_iter
        B = 3 + y;
        Ac = 3 * y + y^2 / 2;
        f_y = 1 - Q^2 * B / (g * Ac^3); % Calcula f(y)
        y_new = y - lambda * f_y; % Método do ponto fixo

        % Calcula o erro aproximado
        erro = abs((y_new - y) / y_new) * 100;

        % Armazena os dados de cada iteração
        iters(end + 1) = iter + 1;
        estimativas(end + 1) = y_new;
        f_values(end + 1) = f_y;
        aprox_errors(end + 1) = erro;

        % Atualiza y
        y = y_new;
        iter = iter + 1; % Incrementa o contador de iterações
    end

    % Calcula o erro verdadeiro após encontrar a raiz final
    final_root = estimativas(end);  % A última estimativa
    for j = 1:length(estimativas)
        true_errors(j) = abs((final_root - estimativas(j)) / final_root) * 100;
    end

    % Cria a tabela com os resultados
    fprintf('\n%-10s %-15s %-15s %-20s %-20s\n', ...
            'Iteração', 'Raiz Aproximada', 'f(y)', 'Erro Aproximado (%)', 'Erro Verdadeiro (%)');
    for k = 1:length(iters)
        fprintf('%-10d %-15.4f %-15.4f %-20.4f %-20.4f\n', ...
                iters(k), estimativas(k), f_values(k), aprox_errors(k), true_errors(k));
    end

    % Mostra a raiz final
    fprintf('\nA profundidade crítica encontrada é y = %0.4f m\n', final_root);
end
