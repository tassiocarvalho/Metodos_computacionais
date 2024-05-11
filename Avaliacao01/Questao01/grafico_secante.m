function plot_convergencia_secante()
    % Parâmetros iniciais
    P = 35000;    % Valor do veículo
    A = 8500;     % Pagamento anual
    n = 7;        % Número de anos
    tol = 0.00005; % Critério de parada (tolerância)
    x0 = 0.01;    % Primeiro palpite inicial para a taxa de juros
    x1 = 0.3;     % Segundo palpite inicial para a taxa de juros

    % Definindo a função
    f = @(i) P * i * (1 + i)^n / ((1 + i)^n - 1) - A;

    % Inicializações para armazenar os resultados de cada iteração
    iters = [];
    roots = [];
    f_values = [];
    errors = [];

    % Método da secante
    iter = 0;
    while true
        iter = iter + 1;
        fx0 = f(x0);
        fx1 = f(x1);
        x2 = x1 - fx1 * (x1 - x0) / (fx1 - fx0);  % Próxima aproximação

        % Armazena os dados da iteração
        iters(end+1) = iter;
        roots(end+1) = x2;
        f_values(end+1) = f(x2);
        if iter > 1
            errors(end+1) = abs((x2 - x1) / x2) * 100;
        else
            errors(end+1) = 100;  % Não há erro aproximado na primeira iteração
        end

        % Verifica a condição de parada
        if abs(x2 - x1) < tol
            break;
        end

        % Atualiza para a próxima iteração
        x0 = x1;  % Move x1 para x0
        x1 = x2;  % Nova estimativa torna-se x1
    end

    % Plotando o gráfico de convergência
    figure;
    plot(1:length(roots), roots, '-o');
    title('Gráfico de Convergência da Taxa de Juros - Método da Secante');
    xlabel('Iteração');
    ylabel('Estimativa da Taxa de Juros');
    grid on;

    % Plotando o gráfico de erro aproximado
    figure;
    plot(2:length(errors)+1, errors, '-o'); % O primeiro erro é calculado na segunda iteração
    title('Erro Aproximado a Cada Iteração');
    xlabel('Iteração');
    ylabel('Erro Aproximado (%)');
    grid on;
end
