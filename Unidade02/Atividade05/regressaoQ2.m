% entrada
xi = [10, 20, 30, 40, 50, 60, 70, 80];
yi = [25, 70, 380, 550, 610, 1220, 830, 1450];

% Número de pontos de dados
n = length(xi);

% Calculando as somas dos coeficientes
Sx = sum(xi);
Sy = sum(yi);
Sx2 = sum(xi.^2);
Sxy = sum(xi .* yi);

% Calculando o coeficiente de ajuste liniear
a1 = (n * Sxy - Sx * Sy) / (n * Sx2 - Sx^2);
a2 = mean(yi) - a1 * mean(xi);

% Calculate the fitted values
y_fit = a1 * xi + a2;

% Calculate the total standard deviation (St)
y_mean = mean(yi);
St = sum((yi - y_mean).^2);

% Calcule a soma residual dos quadrados (Sr)
Sr = sum((yi - y_fit).^2);

% Calculado erro padrão
Syx = sqrt(Sr / (n - 2));

% Calculando o coeficiente (r^2)
r2 = (St - Sr) / St;

% Saida dos resultados
fprintf('Inclinação a(1): %.4f\n', a1);
fprintf('Interserção a(2): %.4f\n', a2);
fprintf('Desvio Padrão Total (St): %.4f\n', sqrt(St / (n - 1)));
fprintf('Erro Padrão da Estimativa (Syx): %.4f\n', Syx);
fprintf('Coeficiente de Determinação(r^2): %.4f\n', r2);

% Plotando os pontos
figure;
scatter(xi, yi, 'filled');
hold on;
plot(xi, y_fit, '-r');
xlabel('x');
ylabel('y');
title('Ajuste de regressão linear');
legend('Pontos de dados', 'Linha ajustada');
grid on;
hold off;
