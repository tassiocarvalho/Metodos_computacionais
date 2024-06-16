% Dados da tabela
x = [0, 0.5, 1.0];
f = [1.3, 2.5, 0.9];

% 1. Polinômio interpolador de Lagrange
n = length(x);
L = cell(n, 1); % Usando células para armazenar os polinômios
P2 = @(z) 0;

for i = 1:n
    L{i} = 1;
    for j = 1:n
        if i ~= j
            L{i} = conv(L{i}, [1 -x(j)]) / (x(i) - x(j));
        end
    end
    P2 = @(z) P2(z) + f(i)*polyval(L{i}, z);
end

% 2. Estimar P_2(0.8)
f_0_8 = P2(0.8);
disp(['P_2(0.8) = ', num2str(f_0_8)]);

% 3. Traçar os polinômios de Lagrange e P_2(x)
x_vals = linspace(0, 1, 100);
figure;
hold on;
colors = ['r', 'g', 'b'];
for i = 1:n
    y_vals = polyval(L{i}, x_vals);
    plot(x_vals, y_vals, colors(i));
end

% P2
y_vals_P2 = arrayfun(P2, x_vals);
plot(x_vals, y_vals_P2, 'k--', 'LineWidth', 2);
plot(x, f, 'ko');
legend('L_1', 'L_2', 'L_3', 'P_2(x)', 'Dados Originais', 'Location', 'NorthWest');
title('Polinômios de Lagrange e Interpolador P_2(x)');
xlabel('x');
ylabel('P(x)');

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
plot(x_vals, y_vals_P2, '-k', x_vals, y_vals_vandermonde, '--b', x, f, 'bo');
title('Comparação dos Polinômios Interpoladores');
xlabel('x');
ylabel('f(x)');
legend('P_2(x) - Lagrange', 'P(x) - Vandermonde', 'Dados Originais', 'Location', 'NorthWest');

