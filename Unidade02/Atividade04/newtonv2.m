% Dados da tabela
x = [0, 0.5, 1.0];
f = [1.0, 2.12, 3.55];

% 1. Polinômio interpolador de Newton
n = length(x);
a = f; % Os coeficientes de Newton começam com os valores de f(x)
for j = 2:n
    for i = n:-1:j
        a(i) = (a(i) - a(i-1)) / (x(i) - x(i-j+1));
    end
end

% Função polinomial usando os coeficientes de Newton
P2 = @(xval) a(1) + a(2)*(xval - x(1)) + a(3)*(xval - x(1))*(xval - x(2));

% 2. Avaliar f(0.7)
f_0_7 = P2(0.7);
disp(['f(0.7) = ', num2str(f_0_7)]);

% 3. Traçar o gráfico do polinômio
x_vals = linspace(0, 1, 100);
y_vals = arrayfun(P2, x_vals);

figure;
plot(x_vals, y_vals, '-r', x, f, 'bo');
title('Polinômio Interpolador de Newton');
xlabel('x');
ylabel('f(x)');
legend('P_2(x)', 'Dados Originais', 'Location', 'NorthWest');

% 4. Implementar o algoritmo de Newton (já feito acima com a formulação dos coeficientes a)

% 6. Polinômio usando a matriz de Vandermonde
V = [x.^0; x.^1; x.^2]';
coef = V\f';
disp('Coeficientes do polinômio (Vandermonde):');
disp(coef);

% Função polinomial usando os coeficientes de Vandermonde
P_vandermonde = @(xval) coef(1) + coef(2)*xval + coef(3)*xval.^2;

% Traçar o gráfico do polinômio de Vandermonde
y_vals_vandermonde = arrayfun(P_vandermonde, x_vals);

figure;
plot(x_vals, y_vals, '-r', x_vals, y_vals_vandermonde, '--b', x, f, 'bo');
title('Comparação dos Polinômios Interpoladores');
xlabel('x');
ylabel('f(x)');
legend('P_2(x) - Newton', 'P(x) - Vandermonde', 'Dados Originais', 'Location', 'NorthWest');

