% Leia o arquivo Excel
file_path = 'C:\Users\tassi\OneDrive\Área de Trabalho\Documentos\Metodos_computacionais\Unidade02\Avaliação02_1\potencia_x_kwh.xlsx';
data = readtable(file_path, 'Range', 'A3:B1000', 'VariableNamingRule', 'preserve'); % Ajuste o range conforme necessário

% Extraia a geração total e a potência
geracao_total = data{:, 2}; % Eixo x - Geração total (kWh)
potenciaW = data{:, 1}; % Eixo y - Potência (W)

% Verifique e converta os dados de potência e geração total para double, se necessário
if iscell(potenciaW)
    potenciaW = cellfun(@str2double, potenciaW);
end
if iscell(geracao_total)
    geracao_total = cellfun(@str2double, geracao_total);
end

% Verifique se há valores ausentes ou não numéricos separadamente
valid_geracao_indices = ~isnan(geracao_total); % Verifica se há valores NaN
valid_potencia_indices = ~isnan(potenciaW); % Verifica se há valores NaN

% Filtre os dados inválidos
valid_indices = valid_geracao_indices & valid_potencia_indices;
geracao_total = geracao_total(valid_indices);
potenciaW = potenciaW(valid_indices);

% Número de pontos
n = length(geracao_total);

% Inicialização da matriz de diferenças divididas
div_diff = zeros(n, n);
div_diff(:, 1) = potenciaW;

% Calcula as diferenças divididas
for j = 2:n
    for i = 1:n-j+1
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (geracao_total(i+j-1) - geracao_total(i));
    end
end

% Coeficientes do polinômio de Newton
coefficients = div_diff(1, :);

% Cria o polinômio de Newton
newton_poly = @(x) coefficients(1) + sum(arrayfun(@(k) prod(x - geracao_total(1:k-1)) * coefficients(k), 2:n));

% Gera pontos para o gráfico
x_vals = linspace(min(geracao_total), max(geracao_total), 1000);
y_vals = arrayfun(newton_poly, x_vals);

% Plota os dados e a interpolação
figure;
plot(geracao_total, potenciaW, '-', 'DisplayName', 'Dados Originais');
hold on;
%plot(x_vals, y_vals, 'r-', 'LineWidth', 2, 'DisplayName', 'Dados');
xlabel('Geração Total (kWh)');
ylabel('Potência (W)');
title('Interpolação Polinomial de Newton para Potência vs Geração Total');
legend('show');
grid on;
hold off;
