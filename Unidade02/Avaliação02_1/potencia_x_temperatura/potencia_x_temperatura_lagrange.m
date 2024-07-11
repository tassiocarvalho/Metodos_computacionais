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

% Função de interpolação de Lagrange
lagrange_interp = @(x) arrayfun(@(xi) sum(power .* prod((xi - temperature.') ./ (temperature.' - temperature + diag(ones(1, n))), 2)), x);

% Gera pontos para o gráfico
x_vals = linspace(min(temperature), max(temperature), 1000);
y_vals = lagrange_interp(x_vals);

% Plota os dados e a interpolação
figure;
plot(temperature, power, 'o', 'DisplayName', 'Dados Originais');
hold on;
plot(x_vals, y_vals, 'r-', 'LineWidth', 2, 'DisplayName', 'Interpolação Polinomial de Lagrange');
xlabel('Temperatura');
ylabel('Potência');
title('Interpolação Polinomial de Lagrange para Potência vs Temperatura');
legend('show');
grid on;
hold off;
