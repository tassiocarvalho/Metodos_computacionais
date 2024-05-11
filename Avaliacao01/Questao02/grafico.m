function plot_bisseccao()
    % Definição dos parâmetros
    Pu_max = 80000;
    ku = 0.05;
    Pu_min = 110000;
    Ps_max = 320000;
    P0 = 10000;
    ks = 0.09;

    % Função f(t)
    f = @(t) (Ps_max / (1 + ((Ps_max / P0) - 1) * exp(-ks * t))) - ...
             1.2 * (Pu_max * exp(-ku * t) + Pu_min);

    % Valores de t para plotagem
    t_values = linspace(0, 100, 400);
    f_values = arrayfun(f, t_values);

    % Criando o gráfico
    figure;
    plot(t_values, f_values);
    title('Gráfico da função f(t)');
    xlabel('Tempo, t');
    ylabel('f(t)');
    grid on;
    hold on;
    % Linha y = 0 para referência
    plot(t_values, zeros(size(t_values)), '--k');
    hold off;
end
