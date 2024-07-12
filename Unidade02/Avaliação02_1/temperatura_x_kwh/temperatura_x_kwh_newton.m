% Leia o arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\Metodos_computacionais\Unidade02\Avaliação02_1\temperatura_x_kwh.xlsx';
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia a temperatura e a geração total (kWh)
temperatura = data{:, 1}; % Eixo x - Temperatura
kWh = data{:, 2}; % Eixo y - Geração total (kWh)

% Verifique e converta os dados de temperatura e geração total para double, se necessário
if iscell(temperatura)
    temperatura = cellfun(@str2double, temperatura);
end
if iscell(kWh)
    kWh = cellfun(@str2double, kWh);
end

% Verifique se há valores ausentes ou não numéricos separadamente
valid_temperatura_indices = ~isnan(temperatura); % Verifica se há valores NaN
valid_kWh_indices = ~isnan(kWh); % Verifica se há valores NaN

% Filtre os dados inválidos
valid_indices = valid_temperatura_indices & valid_kWh_indices;
temperatura = temperatura(valid_indices);
kWh = kWh(valid_indices);

% Número de pontos
n = length(temperatura);

% Inicialização da matriz de diferenças divididas
div_diff = zeros(n, n);
div_diff(:, 1) = kWh;

% Calcula as diferenças divididas
for j = 2:n
    for i = 1:n-j+1
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (temperatura(i+j-1) - temperatura(i));
    end
end

% Coeficientes do polinômio de Newton
coefficients = div_diff(1, :);

% Cria o polinômio de Newton
newton_poly = @(x) coefficients(1) + sum(arrayfun(@(k) prod(x - temperatura(1:k-1)) * coefficients(k), 2:n));

% Gera pontos para o gráfico
x_vals = linspace(min(temperatura), max(temperatura), 1000);
y_vals = arrayfun(newton_poly, x_vals);

% Plota os dados e a interpolação
figure;
plot(temperatura, kWh, '-', 'DisplayName', 'Dados Originais');
hold on;
ylabel('Temperatura');
xlabel('Geração Total (kWh)');
title('Interpolação Polinomial de Newton para Geração Total vs Temperatura');
legend('show');
grid on;
hold off;
