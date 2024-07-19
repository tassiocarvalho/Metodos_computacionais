% Definir a função a ser integrada
f = @(x) cos(x);

% Definir os limites de integração e o número de subintervalos
a = 0; % limite inferior
b = pi/2; % limite superior
n = 6; % número de subintervalos (deve ser par)

% Verificar se n é par
if mod(n, 2) ~= 0
    error('O número de subintervalos n deve ser par');
end

% Calcular o tamanho do passo
h = (b - a) / n;

% Inicializar a soma
integral_simpson_13 = f(a) + f(b);

% Calcular a integral usando a regra de Simpson 1/3 composta
for i = 1:n-1
    x_i = a + i * h;
    if mod(i, 2) == 0
        integral_simpson_13 = integral_simpson_13 + 2 * f(x_i);
    else
        integral_simpson_13 = integral_simpson_13 + 4 * f(x_i);
    end
    fprintf('Intervalo %d: x_i = %.5f, f(x_i) = %.5f\n', i, x_i, f(x_i));
end

% Multiplicar pelo fator h/3
integral_simpson_13 = (h / 3) * integral_simpson_13;

% Calcular a integral exata para comparar
integral_exata = sin(b) - sin(a);

% Calcular o erro relativo percentual verdadeiro
et_simpson_13 = abs((integral_exata - integral_simpson_13) / integral_exata) * 100;

% Exibir resultados
fprintf('Integral usando a regra de Simpson 1/3 composta: %.5f\n', integral_simpson_13);
fprintf('Integral exata: %.5f\n', integral_exata);
fprintf('Erro relativo percentual: %.5f%%\n', et_simpson_13);
