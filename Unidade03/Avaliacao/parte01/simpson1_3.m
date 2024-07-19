% Definir a função a ser integrada
f = @(x) cos(x);

% Definir os limites de integração
a = 0; % limite inferior
b = pi/2; % limite superior

% Calcular o tamanho do passo
h = (b - a) / 2;

% Calcular os pontos intermediários
x0 = a;
x1 = (a + b) / 2;
x2 = b;

% Aplicar a regra de Simpson 1/3 simples
integral_simpson_13_simple = (h / 3) * (f(x0) + 4 * f(x1) + f(x2));

% Calcular a integral exata para comparar
integral_exata = sin(b) - sin(a);

% Calcular o erro relativo percentual verdadeiro
et_simpson_13_simple = abs((integral_exata - integral_simpson_13_simple) / integral_exata) * 100;

% Exibir resultados
fprintf('Integral usando a regra de Simpson 1/3 simples: %.5f\n', integral_simpson_13_simple);
fprintf('Integral exata: %.5f\n', integral_exata);
fprintf('Erro relativo percentual: %.5f%%\n', et_simpson_13_simple);
