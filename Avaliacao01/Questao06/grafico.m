function plot_falsa_posicao()
    % Constantes
    g = 9.81; % m/s^2
    Q = 20;   % m^3/s

    % Função f(y)
    f = @(y) 1 - Q^2 * (3 + y) / (g * (3 * y + y^2 / 2)^3);

    % Valores de y para plotagem
    y_values = linspace(1.0, 1.8, 400);
    f_values = arrayfun(f, y_values);

    % Criando o gráfico
    figure;
    plot(y_values, f_values);
    title('Gráfico da função f(y)');
    xlabel('Profundidade y (m)');
    ylabel('f(y)');
    grid on;
    hold on;
    % Linha y = 0 para referência
    plot(y_values, zeros(size(y_values)), '--k');
    hold off;
end
