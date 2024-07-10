% Leia o arquivo Excel a partir da terceira linha
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\MATLAB\Metodos_computacionais\Unidade02\Avaliação02_1\corrente_x_tensao.xlsx';
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

% Verifique se há valores ausentes ou não numéricos separadamente
valid_voltage_indices = ~isnan(voltage); % Verifica se há valores NaN
valid_current_indices = ~isnan(current); % Verifica se há valores NaN

% Filtre os dados inválidos
valid_indices = valid_voltage_indices & valid_current_indices;
voltage = voltage(valid_indices);
current = current(valid_indices);

% Normalizar valores de tensão
x = (voltage - min(voltage)) / (max(voltage) - min(voltage));
y = current;

% Regressão Linear
p = polyfit(x, y, 2); % Grau 1 para ajuste linear
y_fit = polyval(p, x);

% Calcular o coeficiente de determinação (R2)
SS_tot = sum((y - mean(y)).^2);
SS_res = sum((y - y_fit).^2);
R2_linear = 1 - (SS_res / SS_tot);

% Plotar o ajuste linear
figure;
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'Dados originais');
hold on;
plot(x, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Ajuste Linear (R2 = %.4f)', R2_linear));
xlabel('Tensão (normalizada)');
ylabel('Corrente');
title('Ajuste Linear dos Dados');
legend('show');
grid on;
hold off;
