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

% Converte o tempo para formato numérico para cálculos
time_num = datenum(time);

% Função de interpolação de Lagrange
lagrange_interp = @(x) arrayfun(@(xi) sum(current .* prod((xi - time_num.') ./ (time_num.' - time_num + diag(ones(1,n))), 2)), x);

% Gera pontos para o gráfico
x_vals_num = linspace(min(time_num), max(time_num), 1000);
y_vals = lagrange_interp(x_vals_num);

% Converte os pontos de volta para formato datetime para exibição
x_vals = datetime(x_vals_num, 'ConvertFrom', 'datenum');

% Plota os dados e a interpolação
figure;
plot(time, current, '-', 'DisplayName', 'Dados Originais');
hold on;
plot(x_vals, y_vals, '-', 'DisplayName', 'Interpolação Polinomial de Lagrange');
xlabel('Tempo');
ylabel('Corrente');
title('Interpolação Polinomial de Lagrange para Corrente vs Tempo');
legend;
grid on;
