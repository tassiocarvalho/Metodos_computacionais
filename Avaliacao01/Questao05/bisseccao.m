function bisseccao()
    % Parâmetros do foguete
    u = 1800; % velocidade de expulsão do combustível (m/s)
    m = 160000; % massa inicial do foguete (kg)
    q = 2600; % taxa de consumo de combustível (kg/s)
    g = 9.81; % aceleração da gravidade (m/s^2)
    v_desejada = 750; % velocidade desejada (m/s)

    % Limites iniciais para o tempo
    a = 10; % limite inferior (s)
    b = 50; % limite superior (s)

    % Critério de parada
    tolerancia = 0.01; % tolerância de 1%
    max_iter = 100; % número máximo de iterações

    % Inicializações
    iter = 0;
    erro = 100;

    % Imprime cabeçalho da tabela com largura fixa
    fprintf('%-12s %-18s %-18s %-18s %-18s %-18s\n', ...
            'Iteração', 'Limite Inferior', 'Limite Superior', 'Raiz Aproximada', 'f(xr)', 'Erro Aproximado (%)');

    % Laço principal do método da bisseção
    while erro > tolerancia && iter < max_iter
        xr = (a + b) / 2; % estimativa da raiz
        f_xr = velocidade_subida(xr, u, m, q, g) - v_desejada;
        f_a = velocidade_subida(a, u, m, q, g) - v_desejada;

        % Atualiza os limites
        if f_xr * f_a < 0
            b = xr;
        else
            a = xr;
        end

        % Calcula o novo erro aproximado
        if iter > 0
            erro = abs((xr - xr_old) / xr) * 100;
        end

        % Imprime a linha da tabela com formatação de largura fixa
        fprintf('%-12d %-18.4f %-18.4f %-18.4f %-18.4f %-18.4f\n', ...
                iter + 1, a, b, xr, f_xr, erro);

        % Prepara próxima iteração
        xr_old = xr;
        iter = iter + 1;
    end

    % Mostra a raiz final
    fprintf('\nA raiz encontrada é t = %.4f s\n', xr);
end

function v = velocidade_subida(t, u, m, q, g)
    % Calcula a velocidade de subida do foguete
    v = u * log(m / (m - q * t)) - g * t;
end
