% Definir a função a ser integrada
f = @(x) cos(x);

% Definir os limites de integração e o número de subintervalos
a = 0; % limite inferior
b = pi/2; % limite superior
n = 6; % número de subintervalos

% Calcular o tamanho do passo
h = (b - a) / n;

% Inicializar a soma
integral_trap_comp = 0;

% Calcular a integral usando a regra do trapézio composta
for i = 1:n
    x_i = a + (i - 1) * h;
    x_ip1 = a + i * h;
    integral_trap_comp = integral_trap_comp + (f(x_i) + f(x_ip1));
    fprintf('Intervalo %d: x_i = %.5f, x_ip1 = %.5f, f(x_i) = %.5f, f(x_ip1) = %.5f\n', i, x_i, x_ip1, f(x_i), f(x_ip1));
end

% Multiplicar pela metade do tamanho do passo
integral_trap_comp = (h / 2) * integral_trap_comp;

% Calcular a integral exata para comparar
integral_exata = sin(b) - sin(a);

% Calcular o erro relativo percentual verdadeiro
et_trap_comp = abs((integral_exata - integral_trap_comp) / integral_exata) * 100;

% Exibir resultados
fprintf('Integral usando a regra do trapézio composta: %.5f\n', integral_trap_comp);
fprintf('Integral exata: %.5f\n', integral_exata);
fprintf('Erro relativo percentual: %.5f%%\n', et_trap_comp);
