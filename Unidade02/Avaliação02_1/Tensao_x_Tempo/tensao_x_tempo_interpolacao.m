% Leia o arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\MATLAB\Metodos_computacionais\Unidade02\Avaliação02_1\tensao_x_tempo.xlsx';
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia o tempo e a tensão
time = data{:, 1};
voltage = data{:, 2};

% Verifique e converta os dados de tensão para double, se necessário
if iscell(voltage)
    voltage = cellfun(@str2double, voltage);
end

% Converta o tempo para formato datetime
time = datetime(time, 'InputFormat', 'MM.dd.yyyy HH:mm:ss');

% Verifique se há valores ausentes ou não numéricos separadamente
valid_time_indices = ~isnat(time); % Verifica se há valores NaT (Not-a-Time)
valid_voltage_indices = ~isnan(voltage); % Verifica se há valores NaN

% Filtre os dados inválidos
valid_indices = valid_time_indices & valid_voltage_indices;
time = time(valid_indices);
voltage = voltage(valid_indices);

% Número de pontos
n = length(time);

% Inicialização da matriz de diferenças divididas
div_diff = zeros(n, n);
div_diff(:, 1) = voltage;

% Converte o tempo para formato numérico para cálculos
time_num = datenum(time);

% Calcula as diferenças divididas
for j = 2:n
    for i = 1:n-j+1
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (time_num(i+j-1) - time_num(i));
    end
end

% Coeficientes do polinômio de Newton
coefficients = div_diff(1, :);

% Cria o polinômio de Newton
newton_poly = @(x) coefficients(1) + sum(arrayfun(@(k) prod(x - time_num(1:k-1)) * coefficients(k), 2:n));

% Gera pontos para o gráfico
x_vals_num = linspace(min(time_num), max(time_num), 1000);
y_vals = arrayfun(newton_poly, x_vals_num);

% Converte os pontos de volta para formato datetime para exibição
x_vals = datetime(x_vals_num, 'ConvertFrom', 'datenum');

% Plota os dados e a interpolação
figure;
plot(time, voltage, '-', 'DisplayName', 'Dados Originais');
hold on;
plot(x_vals, y_vals, '-', 'DisplayName', 'Interpolação Polinomial de Newton');
xlabel('Tempo');
ylabel('Tensão');
title('Interpolação Polinomial de Newton para Tensão vs Tempo');
legend;
grid on;
