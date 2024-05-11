function plot_velocidade_subida()
    % Parâmetros do foguete
    u = 1800; % velocidade de expulsão do combustível (m/s)
    m = 160000; % massa inicial do foguete (kg)
    q = 2600; % taxa de consumo de combustível (kg/s)
    g = 9.81; % aceleração da gravidade (m/s^2)
    v_desejada = 750; % velocidade desejada (m/s)

    % Função para calcular a velocidade de subida do foguete
    velocidade_subida = @(t) u * log(m / (m - q * t)) - g * t;

    % Valores de t para plotagem
    t_values = linspace(10, 50, 400);
    v_values = arrayfun(velocidade_subida, t_values) - v_desejada;

    % Criando o gráfico
    figure;
    plot(t_values, v_values);
    title('Gráfico da Velocidade de Subida do Foguete');
    xlabel('Tempo, t (s)');
    ylabel('v(t) - v_{desejada} (m/s)');
    grid on;
    hold on;
    % Linha y = 0 para referência
    plot(t_values, zeros(size(t_values)), '--k');
    hold off;
end
