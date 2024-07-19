% Definir a função a ser integrada
f = @(x) 1 - exp(-x);

% Limites de integração
a = 0;
b = 4;

% Calcular a aproximação usando a Regra do Trapézio
h = b - a;
I_trapezio = (h / 2) * (f(a) + f(b));

% Calcular o erro estimado
% Segunda derivada de f
f_prime_prime = @(x) exp(-x);
% Valor máximo da segunda derivada no intervalo [a, b]
f_prime_prime_max = max(f_prime_prime(linspace(a, b, 1000))); % amostragem fina para achar o máximo

% Cálculo do erro
erro_trapezio = ((b - a)^3 / 12) * f_prime_prime_max;

% Mostrar os resultados
fprintf('Aproximação da integral usando a Regra do Trapézio: %f\n', I_trapezio);
fprintf('Erro estimado: %f\n', erro_trapezio);
