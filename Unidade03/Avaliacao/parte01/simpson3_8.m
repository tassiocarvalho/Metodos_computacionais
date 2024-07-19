% Definir a função a ser integrada
f = @(x) cos(x);

% Definir os limites de integração
a = 0; % limite inferior
b = pi/2; % limite superior

% Calcular o tamanho do passo
h = (b - a) / 3;

% Calcular os pontos intermediários
x0 = a;
x1 = a + h;
x2 = a + 2*h;
x3 = b;

% Aplicar a regra de Simpson 3/8
integral_simpson_38 = (3*h / 8) * (f(x0) + 3*f(x1) + 3*f(x2) + f(x3));

% Calcular a integral exata para comparar
integral_exata = sin(b) - sin(a);

% Calcular o erro relativo percentual verdadeiro
et_simpson_38 = abs((integral_exata - integral_simpson_38) / integral_exata) * 100;

% Exibir resultados
fprintf('Integral usando a regra de Simpson 3/8: %.5f\n', integral_simpson_38);
fprintf('Integral exata: %.5f\n', integral_exata);
fprintf('Erro relativo percentual: %.5f%%\n', et_simpson_38);
