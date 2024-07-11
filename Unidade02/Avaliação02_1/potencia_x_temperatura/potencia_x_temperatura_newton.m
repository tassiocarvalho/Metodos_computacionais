% Caminho do arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\Metodos_computacionais\Unidade02\Avaliação02_1\potencia_x_temperatura.xlsx';

% Verifique se o arquivo existe
if exist(file_path, 'file') ~= 2
    error('Arquivo não encontrado: %s', file_path);
end

% Leia o arquivo Excel
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia a potência e a temperatura
temperature = data{:, 1};
power = data{:, 2};

% Verifique e converta os dados de potência e temperatura para double, se necessário
if iscell(power)
    power = cellfun(@str2double, power);
end
if iscell(temperature)
    temperature = cellfun(@str2double, temperature);
end

% Número de pontos
n = length(temperature);

% Inicialização da matriz de diferenças divididas
div_diff = zeros(n, n);
div_diff(:, 1) = power;

% Calcula as diferenças divididas
for j = 2:n
    for i = 1:n-j+1
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (temperature(i+j-1) - temperature(i));
    end
end

% Coeficientes do polinômio de Newton
coefficients = div_diff(1, :);

% Cria o polinômio de Newton
newton_poly = @(x) coefficients(1) + sum(arrayfun(@(k) prod(x - temperature(1:k-1)) * coefficients(k), 2:n));

% Gera pontos para o gráfico
x_vals = linspace(min(temperature), max(temperature), 1000);
y_vals = arrayfun(newton_poly, x_vals);

% Plota os dados e a interpolação
figure;
plot(temperature, power, 'o', 'DisplayName', 'Dados Originais');
hold on;
plot(x_vals, y_vals, 'r-', 'LineWidth', 2, 'DisplayName', 'Interpolação Polinomial de Newton');
xlabel('Temperatura');
ylabel('Potência');
title('Interpolação Polinomial de Newton para Potência vs Temperatura');
legend('show');
grid on;
hold off;
