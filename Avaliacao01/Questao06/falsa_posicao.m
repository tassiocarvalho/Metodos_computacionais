function falsa_posicao()
    % Constantes
    g = 9.81; % m/s^2
    Q = 20;   % m^3/s
    tol = 0.01; % tolerância de 1%
    
    % Inicialização
    a = 1.0; % limite inferior
    b = 1.8; % limite superior
    fa = f(a); % f(a)
    fb = f(b); % f(b)
    erro = Inf;
    iter = 0;
    max_iter = 20; % máximo de iterações
    
    % Verifica se há mudança de sinal
    if fa * fb > 0
        fprintf('Não há raiz no intervalo dado.\n');
        return;
    end
    
    % Imprime cabeçalho da tabela com espaçamento adequado
    fprintf('\n%-10s %-15s %-15s %-15s %-15s %-15s\n', ...
        'Iteração', 'Limite Inferior', 'Limite Superior', 'Raiz Aproximada', 'f(y)', 'Erro Aproximado (%)');
    
    % Método da falsa posição
    while erro > tol && iter < max_iter
        % Calcula c
        c = b - fb * (b - a) / (fb - fa);
        fc = f(c);
        
        % Atualiza os intervalos
        if fa * fc < 0
            b = c;
            fb = fc;
        else
            a = c;
            fa = fc;
        end
        
        % Calcula erro
        erro = abs(fc);
        
        % Imprime os resultados de cada iteração com espaçamento adequado
        fprintf('%-10d %-15.4f %-15.4f %-15.4f %-15.4f %-15.4f\n', ...
                iter + 1, a, b, c, fc, erro);
        
        iter = iter + 1; % Incrementa o contador de iterações
    end
    
    % Mostra a raiz final
    fprintf('\nA profundidade crítica encontrada é y = %0.4f m\n', c);
end

function val = f(y)
    % Constantes locais
    g = 9.81; % m/s^2
    Q = 20;   % m^3/s
    % Valores de B e Ac
    B = 3 + y;
    Ac = 3 * y + y^2 / 2;
    % Função f(y)
    val = 1 - Q^2 * B / (g * Ac^3);
end
