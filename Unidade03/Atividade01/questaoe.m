% Algoritmo para calcular a integral e o erro usando a regra de Simpson 1/3 composta

% Definição da função
f = @(x) 1 - exp(-x);

% Limites de integração
a = 0;
b = 4;

% Número de subintervalos (n = 4 para aplicação múltipla)
n = 4;

% Passo de integração
h = (b - a) / n;

% Pontos de integração
x0 = a;
x1 = a + h;
x2 = a + 2*h;
x3 = a + 3*h;
x4 = b;

% Valores da função nos pontos de integração
f0 = f(x0);
f1 = f(x1);
f2 = f(x2);
f3 = f(x3);
f4 = f(x4);

% Aproximação da integral pela regra de Simpson 1/3 composta
integral_approx = (h / 3) * (f0 + 4*f1 + 2*f2 + 4*f3 + f4);

% Cálculo do erro
% Derivada quarta da função f(x) = 1 - exp(-x) é f^(4)(x) = -exp(-x)
% Valor máximo da quarta derivada no intervalo [a, b]
f4_max = -exp(-0);

% Erro da regra de Simpson 1/3 composta
erro = ((b - a) * h^4 / 180) * abs(f4_max);

% Exibir os resultados
fprintf('Aproximação da integral pela regra de Simpson 1/3 composta: %.4f\n', integral_approx);
fprintf('Erro estimado: %.4f\n', erro);
