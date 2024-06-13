% Definição dos pontos
x = [0, 0.5, 1.0];
y = [1.3, 2.5, 0.9];

% Número de pontos
n = length(x);

% Cálculo dos polinômios de Lagrange
syms X;
L = sym(zeros(1, n));

for i = 1:n
    L(i) = 1;
    for j = 1:n
        if i ~= j
            L(i) = L(i) * (X - x(j)) / (x(i) - x(j));
        end
    end
end

% Construção do polinômio interpolador
P2 = 0;
for i = 1:n
    P2 = P2 + L(i) * y(i);
end

% Simplificação do polinômio
P2 = simplify(P2);

% Estimação de f(0.8)
valor_estimado = double(subs(P2, 0.8));

% Plotagem dos polinômios de Lagrange e do polinômio interpolador
fplot(P2, [0, 1], 'LineWidth', 2);
hold on;
for i = 1:n
    fplot(L(i), [0, 1]);
end
scatter(x, y, 'filled');
legend(['P2(x)', arrayfun(@(i) ['L', num2str(i), '(x)'], 1:n, 'UniformOutput', false)]);
title('Polinômios de Lagrange e Polinômio Interpolador P2(x)');
hold off;

% Exibição do valor estimado
fprintf('O valor estimado de f(0.8) é %.4f\n', valor_estimado);
