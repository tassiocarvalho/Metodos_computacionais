% Leia o arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\MATLAB\Metodos_computacionais\Unidade02\Avaliação02_1\corrente_x_tempo.xlsx';
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia o tempo e a corrente
time = data{:, 1};
current = data{:, 2};

% Verifique e converta os dados de corrente para double, se necessário
if iscell(current)
    current = cellfun(@str2double, current);
end

% Converta o tempo para formato datetime
time = datetime(time, 'InputFormat', 'MM.dd.yyyy HH:mm:ss');

% Número de pontos
n = length(time);

% Inicialização da matriz de diferenças divididas
div_diff = zeros(n, n);
div_diff(:, 1) = current;

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
plot(time, current, '-', 'DisplayName', 'Dados Originais');
hold on;
plot(x_vals, y_vals, '-', 'DisplayName', 'Interpolação Polinomial de Newton');
xlabel('Tempo');
ylabel('Corrente');
title('Interpolação Polinomial de Newton para Corrente vs Tempo');
legend;
grid on;
