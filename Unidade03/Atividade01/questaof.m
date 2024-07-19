% Algoritmo para calcular a integral e o erro usando a regra de Simpson 3/8

% Definição da função
f = @(x) 1 - exp(-x);

% Limites de integração
a = 0;
b = 4;

% Número de subintervalos (para aplicação única da regra de Simpson 3/8, n = 3)
n = 3;

% Passo de integração
h = (b - a) / n;

% Pontos de integração
x0 = a;
x1 = a + h;
x2 = a + 2*h;
x3 = b;

% Valores da função nos pontos de integração
f0 = f(x0);
f1 = f(x1);
f2 = f(x2);
f3 = f(x3);

% Aproximação da integral pela regra de Simpson 3/8
integral_approx = (3*h / 8) * (f0 + 3*f1 + 3*f2 + f3);

% Cálculo do erro
% Derivada quarta da função f(x) = 1 - exp(-x) é f^(4)(x) = -exp(-x)
% Valor máximo da quarta derivada no intervalo [a, b]
f4_max = -exp(-0);

% Erro da regra de Simpson 3/8
erro = ((b - a) * h^5 / 80) * abs(f4_max);

% Exibir os resultados
fprintf('Aproximação da integral pela regra de Simpson 3/8: %.4f\n', integral_approx);
fprintf('Erro estimado: %.4f\n', erro);
