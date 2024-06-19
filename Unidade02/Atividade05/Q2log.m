% Dados de entrada
xi = [10, 20, 30, 40, 50, 60, 70, 80];
yi = [25, 70, 380, 550, 610, 1220, 830, 1450];

% Transformando os dados
ln_xi = log(xi);
ln_yi = log(yi);

% Número de pontos de dados
n = length(ln_xi);

% Calculando as somas dos coeficientes
Sx = sum(ln_xi);
Sy = sum(ln_yi);
Sx2 = sum(ln_xi.^2);
Sxy = sum(ln_xi .* ln_yi);

% Calculando os coeficientes da regressão linear
beta = (n * Sxy - Sx * Sy) / (n * Sx2 - Sx^2);
alpha_ln = mean(ln_yi) - beta * mean(ln_xi);
alpha = exp(alpha_ln);

% Valores ajustados
ln_y_fit = alpha_ln + beta * ln_xi;
y_fit = alpha * xi.^beta;

% Calculando o desvio padrão total (St)
ln_y_mean = mean(ln_yi);
St = sum((ln_yi - ln_y_mean).^2);

% Calculando a soma residual dos quadrados (Sr)
Sr = sum((ln_yi - ln_y_fit).^2);

% Calculando o erro padrão
Syx = sqrt(Sr / (n - 2));

% Calculando o coeficiente de determinação (r^2)
r2 = (St - Sr) / St;

% Saída dos resultados
fprintf('Coeficiente α: %.4f\n', alpha);
fprintf('Expoente β: %.4f\n', beta);
fprintf('Desvio Padrão Total (St): %.4f\n', sqrt(St / (n - 1)));
fprintf('Erro Padrão da Estimativa (Syx): %.4f\n', Syx);
fprintf('Coeficiente de Determinação (r^2): %.4f\n', r2);

% Plotando os pontos e a linha ajustada
figure;
scatter(xi, yi, 'filled');
hold on;
plot(xi, y_fit, '-r');
xlabel('Velocidade (m/s)');
ylabel('Força (N)');
title('Ajuste de Regressão Linear: y = αx^{\beta}');
legend('Pontos de dados', 'Linha ajustada');
grid on;
hold off;
