function newton_raphson()
    % Parâmetros do foguete
    u = 1800; % velocidade de expulsão do combustível (m/s)
    m = 160000; % massa inicial do foguete (kg)
    q = 2600; % taxa de consumo de combustível (kg/s)
    g = 9.81; % aceleração da gravidade (m/s^2)
    v_desejada = 750; % velocidade desejada (m/s)

    % Estimativa inicial para o tempo
    xr = 15; % tempo inicial estimado (s)

    % Critério de parada e controle
    tolerancia = 0.01; % tolerância de 1%
    max_iter = 100; % número máximo de iterações
    iter = 0;
    erro = Inf;

    % Inicializações para armazenar os resultados de cada iteração
    iters = [];
    roots = [];
    f_values = [];
    errors = [];
    true_errors = [];

    % Laço principal do método de Newton-Raphson
    while erro > tolerancia && iter < max_iter
        f_xr = velocidade_subida(xr, u, m, q, g) - v_desejada;
        df_xr = derivada_velocidade(xr, u, m, q, g);

        % Próximo valor estimado para xr
        xr_old = xr;
        xr = xr - f_xr / df_xr;

        % Calcula o erro aproximado
        erro = abs((xr - xr_old) / xr) * 100;

        % Armazena os dados da iteração
        iters(end + 1) = iter + 1;
        roots(end + 1) = xr;
        f_values(end + 1) = f_xr;
        errors(end + 1) = erro;

        % Prepara próxima iteração
        iter = iter + 1;
    end

    % Cálculo do erro verdadeiro
    final_root = roots(end);  % A última estimativa de tempo encontrada
    for j = 1:length(roots)
        true_errors(j) = abs((final_root - roots(j)) / final_root) * 100;
    end

    % Cria a tabela com os resultados, incluindo o erro verdadeiro
    T = table(iters', roots', f_values', errors', ...
        'VariableNames', {'Iteração', 'xr - Raiz Aproximada', 'f(xr)', 'Erro Aproximado (%)'});
    disp(T);

    % Mostra a raiz final
    fprintf('\nA raiz encontrada é t = %.4f s\n', final_root);
end

function v = velocidade_subida(t, u, m, q, g)
    % Calcula a velocidade de subida do foguete
    v = u * log(m / (m - q * t)) - g * t;
end

function dv = derivada_velocidade(t, u, m, q, g)
    % Calcula a derivada da velocidade de subida do foguete
    dv = u * q / (m - q * t) - g;
end
