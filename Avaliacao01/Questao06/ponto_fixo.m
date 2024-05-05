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
    
    % Imprime cabeçalho da tabela
    fprintf('Iteração\tRaiz Aproximada\tf(y)\t\tErro Aproximado\n');
    
    % Iterações do método do ponto fixo
    while erro > tol && iter < max_iter
        B = 3 + y;
        Ac = 3 * y + y^2 / 2;
        f_y = 1 - Q^2 * B / (g * Ac^3); % Calcula f(y)
        y_new = y - lambda * f_y; % Método do ponto fixo
        
        % Atualiza o erro
        erro = abs((y_new - y) / y_new) * 100;
        
        % Imprime a linha da tabela
        fprintf('%d\t\t\t%0.4f\t\t\t%0.4f\t\t%0.4f%%\n', ...
                iter + 1, y_new, f_y, erro);
        
        % Atualiza y
        y = y_new;
        iter = iter + 1; % Incrementa o contador de iterações
    end
    
    % Mostra a raiz final
    fprintf('\nA profundidade crítica encontrada é y = %0.4f m\n', y);
end
