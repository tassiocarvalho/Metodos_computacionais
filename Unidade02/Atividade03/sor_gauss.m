% Definindo o sistema de equações
A = [-3 12; 10 -2];
b = [9; 8];

% Parâmetros iniciais
n = length(b);
x = zeros(n, 1); % Vetor inicial [0; 0]
omega = 1.25; % Valor de omega
max_iter = 100;
tol = 0.1; % Critério de parada (erro relativo 10%)

% Iterando com o valor fixo de omega
for k = 1:max_iter
    x_old = x;
    for i = 1:n
        sum = 0;
        for j = 1:n
            if j ~= i
                sum = sum + A(i, j) * x(j);
            end
        end
        x(i) = (1 - omega) * x(i) + omega * (b(i) - sum) / A(i, i);
    end
    
    % Calcular erro relativo
    rel_error = norm(x - x_old) / norm(x);
    
    % Exibir resultados para cada iteração
    fprintf('Iteração: %d, x1: %.6f, x2: %.6f, Erro relativo: %.6f\n', k, x(1), x(2), rel_error);
    
    % Verificar se o erro relativo é menor que a tolerância
    if rel_error < tol
        fprintf('Convergência alcançada após %d iterações.\n', k);
        break;
    end
end

if k == max_iter
    fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
end
