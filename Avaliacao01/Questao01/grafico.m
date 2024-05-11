function plot_taxa_juros()
    % Parâmetros iniciais
    P = 35000;  % Valor do veículo
    A = 8500;   % Pagamento anual
    n = 7;      % Número de anos

    % Função para o cálculo do pagamento anual A
    f = @(i) P * i * (1 + i)^n / ((1 + i)^n - 1) - A;

    % Valores de i (taxa de juros) para plotagem
    i_values = linspace(0.01, 0.3, 400);
    f_values = arrayfun(f, i_values);

    % Criando o gráfico
    figure;
    plot(i_values, f_values);
    title('Gráfico da função f(i) para o cálculo do pagamento anual');
    xlabel('Taxa de juros i');
    ylabel('f(i)');
    grid on;
    hold on;
    % Linha y = 0 para referência
    plot(i_values, zeros(size(i_values)), '--k');
    hold off;
end
