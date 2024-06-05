% Sistema de Equações
A = [1 0.5 -0.1; 0.2 1 -0.2; -0.1 -0.2 1];
b = [0.2; -2; 1];

% Critério de Sassenfeld
n = size(A,1);
B = zeros(n,1);
for i = 1:n
    sum1 = 0;
    sum2 = 0;
    for j = 1:i-1
        sum1 = sum1 + abs(A(i,j)) * B(j);
    end
    for j = i+1:n
        sum2 = sum2 + abs(A(i,j));
    end
    B(i) = (sum1 + sum2) / abs(A(i,i));
end

if max(B) >= 1
    error('O critério de Sassenfeld não é satisfeito. O método de Gauss-Seidel pode não convergir.');
else
    disp('O critério de Sassenfeld é satisfeito. O método de Gauss-Seidel deve convergir.');
end

% Inicialização
x0 = [0; 0; 0]; % vetor inicial
x = x0;
tol = 0.05; % tolerância
max_iter = 100; % número máximo de iterações
iter = 0;

fprintf('Iteração\t x1\t\t x2\t\t x3\t\t Erro Relativo\n');
fprintf('-------------------------------------------------------\n');

% Método de Gauss-Seidel
for k = 1:max_iter
    x_old = x;
    for i = 1:n
        sum = 0;
        for j = 1:n
            if j ~= i
                sum = sum + A(i,j) * x(j);
            end
        end
        x(i) = (b(i) - sum) / A(i,i);
    end

    % Calcular erro relativo
    rel_error = norm(x - x_old) / norm(x);

    % Exibir resultados
    fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\n', k, x(1), x(2), x(3), rel_error);

    % Verificar se o erro relativo é menor que a tolerância
    if rel_error < tol
        fprintf('Convergência alcançada após %d iterações.\n', k);
        break;
    end

    iter = k;
end

if iter == max_iter
    fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
end
