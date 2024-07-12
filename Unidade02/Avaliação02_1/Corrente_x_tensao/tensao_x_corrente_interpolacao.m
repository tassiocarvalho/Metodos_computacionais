% Leia o arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\Metodos_computacionais\Unidade02\Avaliação02_1\corrente_x_tensao.xlsx';
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia a tensão e a corrente
voltage = data{:, 1};
current = data{:, 2};

% Verifique e converta os dados de corrente e tensão para double, se necessário
if iscell(current)
    current = cellfun(@str2double, current);
end
if iscell(voltage)
    voltage = cellfun(@str2double, voltage);
end

% Número de pontos
n = length(voltage);

% Função de interpolação de Lagrange
lagrange_interp = @(x) arrayfun(@(xi) sum(current .* prod((xi - voltage.') ./ (voltage.' - voltage + diag(ones(1,n))), 2)), x);

% Gera pontos para o gráfico
x_vals = linspace(min(voltage), max(voltage), 1000);
y_vals = lagrange_interp(x_vals);

% Plota os dados e a interpolação
figure;
plot(voltage, current, 'o', 'DisplayName', 'Dados Originais');
hold on;
ylabel('Tensão');
xlabel('Corrente');
title('Interpolação Polinomial de Lagrange para Corrente vs Tensão');
legend('show');
grid on;
hold off;
