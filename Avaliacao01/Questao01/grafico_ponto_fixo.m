function plot_convergencia_ponto_fixo()
    % Parâmetros iniciais
    P = 35000;    % Valor do veículo
    A = 8500;     % Pagamento anual
    n = 7;        % Número de anos
    tol = 0.00005; % Critério de parada
    i0 = 0.01;    % Palpite inicial para a taxa de juros

    % Definindo a função g(i)
    g = @(i) (A * (1 + i)^n - A) / (P * (1 + i)^n);

    % Inicializações para armazenar os resultados de cada iteração
    iters = [];
    roots = [];
    g_values = [];
    errors = [];

    % Método do ponto fixo
    iter = 0;
    i = i0;
    while true
        iter = iter + 1;
        inew = g(i);  % Calcula o novo valor de i usando g(i)

        % Armazena os dados da iteração
        iters(end+1) = iter;
        roots(end+1) = i;
        g_values(end+1) = inew;
        if iter > 1
            errors(end+1) = abs((inew - i) / inew) * 100;
        else
            errors(end+1) = 100;  % Não há erro aproximado na primeira iteração
        end
        
        % Verifica a condição de parada
        if abs(inew - i) < tol
            break;
        end
        
        i = inew;  % Atualiza i para a nova estimativa
    end

    % Plotando o gráfico de convergência
    figure;
    plot(1:length(roots), roots, '-o');
    title('Gráfico de Convergência da Taxa de Juros - Ponto Fixo');
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
