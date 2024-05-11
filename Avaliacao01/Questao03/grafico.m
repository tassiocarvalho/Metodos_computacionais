function plot_newton_raphson()
    % Constantes
    e0 = 8.9e-12;
    q = 2e-5;
    Q = 2e-5;
    a = 0.85;
    F = 1.25;
    pi = 3.141592653589793;

    % Função g(x)
    g = @(x) (1 / (4 * pi * e0)) * (q * Q * x) / ((x^2 + a^2)^(3/2)) - F;

    % Valores de x para plotagem
    x_values = linspace(-2, 2, 400);
    g_values = arrayfun(g, x_values);

    % Criando o gráfico
    figure;
    plot(x_values, g_values);
    title('Gráfico da função g(x)');
    xlabel('x');
    ylabel('g(x)');
    grid on;
    hold on;
    % Linha y = 0 para referência
    plot(x_values, zeros(size(x_values)), '--k');
    hold off;
end
