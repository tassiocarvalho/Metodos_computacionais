function plot_convergencia_falsa_posicao()
    % Parâmetros iniciais
    P = 35000;  % Valor do veículo
    A = 8500;   % Pagamento anual
    n = 7;      % Número de anos
    tol = 0.00005;  % Critério de parada (tolerância)
    a = 0.01;   % Limite inferior inicial para taxa de juros
    b = 0.3;    % Limite superior inicial para taxa de juros

    % Função para o cálculo do pagamento anual A
    f = @(i) P * i * (1 + i)^n / ((1 + i)^n - 1) - A;

    % Inicializações para armazenar os resultados de cada iteração
    roots = [];
    errors = [];

    % Método da falsa posição
    iter = 0;  % Contador de iterações
    while (b - a) > tol
        c = b - (f(b) * (b - a)) / (f(b) - f(a));  % Cálculo de c pelo método da falsa posição
        fc = f(c);

        % Armazena os dados da iteração
        roots(end+1) = c;
        if iter > 0
            errors(end+1) = abs((c - roots(end-1)) / c) * 100;
        else
            errors(end+1) = 100;  % Não há erro na primeira iteração
        end

        % Atualiza os limites
        if f(a) * fc < 0
            b = c;
        else
            a = c;
        end

        iter = iter + 1; % Incrementa o contador de iterações
    end

    % Plotando o gráfico de convergência
    figure;
    plot(1:length(roots), roots, '-o');
    title('Gráfico de Convergência da Taxa de Juros');
    xlabel('Iteração');
    ylabel('Estimativa da Taxa de Juros');
    grid on;

    % Plotando o gráfico de erro aproximado
    figure;
    semilogy(2:length(errors)+1, errors, '-o'); % semilogy para escala logarítmica no eixo y
    title('Erro Aproximado a Cada Iteração');
    xlabel('Iteração');
    ylabel('Erro Aproximado (%)');
    grid on;
end
