% Sistema de Equações
A = [-17/105, 1/30, 0; 1/30, -253/840, 1/8; 1/10, 1/7, 1/15];
b = [ -20/35; 0; -28];

% Inicialização
x0 = [0; 0; 0]; % vetor inicial
x = x0;
tol = 0.001; % tolerância
max_iter = 1000; % número máximo de iterações
n = length(b);
iter = 0;

fprintf('Iteração\t x1\t\t x2\t\t x3\t\t Erro Relativo\n');
fprintf('-------------------------------------------------------\n');

% Método de Jacobi
for k = 1:max_iter
    x_new = zeros(n,1);
    for i = 1:n
        sum = 0;
        for j = 1:n
            if j ~= i
                sum = sum + A(i,j) * x(j);
            end
        end
        x_new(i) = (b(i) - sum) / A(i,i);
    end

    % Calcular erro relativo
    rel_error = norm(x_new - x) / norm(x_new);

    % Exibir resultados
    fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\n', k, x_new(1), x_new(2), x_new(3), rel_error);

    % Verificar se o erro relativo é menor que a tolerância
    if rel_error < tol
        fprintf('Convergência alcançada após %d iterações.\n', k);
        break;
    end

    x = x_new;
    iter = k;
end

if iter == max_iter
    fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
end
