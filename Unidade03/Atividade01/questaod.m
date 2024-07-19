% Algoritmo para calcular a integral e o erro usando a regra de Simpson 1/3

% Definição da função
f = @(x) 1 - exp(-x);

% Limites de integração
a = 0;
b = 4;

% Número de subintervalos (para aplicação única, n = 2)
n = 2;

% Passo de integração
h = (b - a) / n;

% Pontos de integração
x0 = a;
x1 = a + h;
x2 = b;

% Valores da função nos pontos de integração
f0 = f(x0);
f1 = f(x1);
f2 = f(x2);

% Aproximação da integral pela regra de Simpson 1/3
integral_approx = (h / 3) * (f0 + 4*f1 + f2);

% Cálculo do erro
% Derivada quarta da função f(x) = 1 - exp(-x) é f^(4)(x) = -exp(-x)
% Valor máximo da quarta derivada no intervalo [a, b]
f4_max = -exp(-0);

% Erro da regra de Simpson 1/3
erro = ((b - a)^5 / (180 * n^4)) * abs(f4_max);

% Exibir os resultados
fprintf('Aproximação da integral pela regra de Simpson 1/3: %.4f\n', integral_approx);
fprintf('Erro estimado: %.4f\n', erro);
