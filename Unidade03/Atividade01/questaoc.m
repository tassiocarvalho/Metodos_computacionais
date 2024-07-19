% Definir a função a ser integrada
f = @(x) 1 - exp(-x);

% Limites de integração
a = 0;
b = 4;

% Número de subintervalos
n_values = [2, 4];

for n = n_values
    % Calcular a largura de cada subintervalo
    h = (b - a) / n;
    
    % Pontos de avaliação
    x = a:h:b;
    
    % Avaliar a função nos pontos
    f_values = f(x);
    
    % Calcular a aproximação usando a Regra do Trapézio composta
    I_trapezio = (h / 2) * (f_values(1) + 2 * sum(f_values(2:end-1)) + f_values(end));
    
    % Calcular o erro estimado
    % Segunda derivada de f
    f_prime_prime = @(x) exp(-x);
    % Valor máximo da segunda derivada no intervalo [a, b]
    f_prime_prime_max = max(f_prime_prime(linspace(a, b, 1000))); % amostragem fina para achar o máximo
    
    % Cálculo do erro
    erro_trapezio = ((b - a) * h^2 / 12) * f_prime_prime_max;
    
    % Mostrar os resultados
    fprintf('Para n = %d:\n', n);
    fprintf('Aproximação da integral usando a Regra do Trapézio: %f\n', I_trapezio);
    fprintf('Erro estimado: %f\n', erro_trapezio);
    fprintf('\n');
end
