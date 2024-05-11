function plot_bisseccao_esfera()
    % Constantes
    r = 1; % raio da esfera em metros
    ps = 200; % densidade da esfera em kg/m^3
    pw = 1000; % densidade da água em kg/m^3
    pi = 3.141592653589793;

    % Volume submerso da esfera
    volume_submerso = @(h) (4/3) * pi * r^3 - (pi * h^2 / 3) * (3 * r - h);
    
    % Volume total da esfera
    volume_total = (4 / 3) * pi * r^3;
    
    % Função g(h) que deve ser zero no ponto de equilíbrio
    g = @(h) ps * volume_total / pw - volume_submerso(h);

    % Valores de h para plotagem
    h_values = linspace(0, 2 * r, 400);
    g_values = arrayfun(g, h_values);

    % Criando o gráfico
    figure;
    plot(h_values, g_values);
    title('Gráfico da função g(h)');
    xlabel('Altura submersa h (m)');
    ylabel('g(h)');
    grid on;
    hold on;
    % Linha y = 0 para referência
    plot(h_values, zeros(size(h_values)), '--k');
    hold off;
end
