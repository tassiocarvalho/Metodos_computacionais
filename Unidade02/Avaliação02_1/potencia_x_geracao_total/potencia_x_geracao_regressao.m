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

% Normalizar valores de geração total
x = (geracao_total - min(geracao_total)) / (max(geracao_total) - min(geracao_total));
y = potenciaW;

% Número de pontos
n = length(x);

% Grau do polinômio
g = 10;

% Número de coeficientes a determinar
m = g + 1;

% Inicializar matriz A e vetor b
A = zeros(m, m);
b = zeros(m, 1);

% Formação do sistema de equações
for i = 1:m
    for j = 1:m
        if i == 1 && j == 1
            A(i, j) = n;
        else
            k1 = i - 1;
            k2 = j - 1;
            s = 0;
            for k = 1:n
                s = s + x(k)^(k1 + k2);
            end
            A(i, j) = s;
        end
    end
    s = 0;
    if i == 1
        for k = 1:n
            s = s + y(k);
        end
    else
        for k = 1:n
            s = s + y(k) * x(k)^(i-1);
        end
    end
    b(i) = s;
end

% Resolução do sistema linear usando eliminação de Gauss
for k = 1:m-1
    for i = k+1:m
        pv = A(i, k) / A(k, k);
        A(i, k) = 0;
        for j = k+1:m
            A(i, j) = A(i, j) - pv * A(k, j);
        end
        b(i) = b(i) - pv * b(k);
    end
end

% Solução do sistema
coef = zeros(m, 1);
coef(m) = b(m) / A(m, m);
for k = m-1:-1:1
    s = 0;
    for j = k+1:m
        s = s + A(k, j) * coef(j);
    end
    coef(k) = (b(k) - s) / A(k, k);
end

% Formação do polinômio de regressão
y_fit = zeros(size(x));
for i = 1:m
    y_fit = y_fit + coef(i) * x.^(i-1);
end

% Calcular o coeficiente de determinação (R2)
SS_tot = sum((y - mean(y)).^2);
SS_res = sum((y - y_fit).^2);
R2 = 1 - (SS_res / SS_tot);

% Exibir os coeficientes
fprintf('Coeficientes do polinômio de ordem %d:\n', g);
for i = 1:m
    fprintf('a%d = %.4f\n', i-1, coef(i));
end
fprintf('R2 = %.4f\n\n', R2);

% Plotar o polinômio ajustado
figure;
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'Dados originais');
hold on;
plot(x, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Polinômio de ordem %d (R2 = %.4f)', g, R2));
xlabel('Geração Total (normalizada)');
ylabel('Potência (W)');
title('Ajuste Polinomial dos Dados');
legend('show');
grid on;
hold off;
