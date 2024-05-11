function plot_convergencia_newton()
    % Parâmetros iniciais
    P = 35000;  % Valor do veículo
    A = 8500;   % Pagamento anual
    n = 7;      % Número de anos
    tol = 0.00005;  % Critério de parada (tolerância)
    x0 = 0.01;  % Palpite inicial para a taxa de juros

    % Função e derivada
    f = @(i) P * i * (1 + i)^n / ((1 + i)^n - 1) - A;
    df = @(i) P * ((1 + i)^n * (1 + n * i) - n * i * (1 + i)^(n - 1)) / ((1 + i)^(2 * n) - 2 * (1 + i)^n + 1);

    % Inicializações
    roots = [];
    errors = [];

    % Método de Newton-Raphson
    x = x0;
    iter = 0;
    while true
        iter = iter + 1;
        fx = f(x);
        dfx = df(x);
        xnew = x - fx / dfx;  % Próxima aproximação

        % Armazena os dados da iteração
        roots(end+1) = x;
        if iter > 1
            errors(end+1) = abs((xnew - x) / xnew) * 100;
        end

        % Condição de parada
        if abs(xnew - x) < tol
            roots(end+1) = xnew;  % Armazena a última raiz
            if iter > 1
                errors(end+1) = abs((xnew - roots(end-1)) / xnew) * 100;
            end
            break;
        end

        x = xnew;  % Atualiza x para a nova estimativa
    end

    % Plotando o gráfico de convergência
    figure;
    plot(1:length(roots), roots, '-o');
    title('Gráfico de Convergência da Taxa de Juros - Newton-Raphson');
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
