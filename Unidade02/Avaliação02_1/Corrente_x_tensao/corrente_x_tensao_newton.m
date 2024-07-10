% Leia o arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\MATLAB\Metodos_computacionais\Unidade02\Avaliação02_1\corrente_x_tensao.xlsx';
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia a corrente e a tensão
current = data{:, 1};
voltage = data{:, 2};

% Verifique e converta os dados de corrente e tensão para double, se necessário
if iscell(current)
    current = cellfun(@str2double, current);
end

if iscell(voltage)
    voltage = cellfun(@str2double, voltage);
end

% Número de pontos
n = length(current);

% Inicialização da matriz de diferenças divididas
div_diff = zeros(n, n);
div_diff(:, 1) = voltage;

% Calcula as diferenças divididas
for j = 2:n
    for i = 1:n-j+1
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (current(i+j-1) - current(i));
    end
end

% Coeficientes do polinômio de Newton
coefficients = div_diff(1, :);

% Cria o polinômio de Newton
newton_poly = @(x) coefficients(1) + sum(arrayfun(@(k) prod(x - current(1:k-1)) * coefficients(k), 2:n));

% Gera pontos para o gráfico
x_vals = linspace(min(current), max(current), 1000);
y_vals = arrayfun(newton_poly, x_vals);

% Plota os dados e a interpolação
figure;
plot(current, voltage, 'o', 'DisplayName', 'Dados Originais');
hold on;
plot(x_vals, y_vals, 'r-', 'DisplayName', 'Interpolação Polinomial de Newton');
xlabel('Corrente');
ylabel('Tensão');
title('Interpolação Polinomial de Newton para Corrente vs Tensão');
legend;
grid on;
hold off;
