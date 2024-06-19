% entrada
xi = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
yi = [1.3, 3.5, 4.2, 5.0, 7.0, 8.8, 10.1, 12.5, 13.0, 15.6];

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
