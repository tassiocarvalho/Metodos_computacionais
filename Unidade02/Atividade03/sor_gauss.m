% Sistema de Equações
A = [-3 12; 10 -2];
b = [9; 8];

% Inicialização
x0 = [0; 0]; % vetor inicial
tol = 0.1; % tolerância (10%)
max_iter = 100; % número máximo de iterações
omega = 1.0; % fator de relaxamento inicial
best_omega = omega; % melhor fator de relaxamento
min_iter = max_iter;

fprintf('Iteração\t x1\t\t x2\t\t Erro Relativo\n');
fprintf('-------------------------------------------------------\n');

% Testar diferentes valores de omega
for w = 1.0:0.1:1.9
    x = x0;
    iter = 0;

    for k = 1:max_iter
        x_old = x;

        % Atualização de x1
        x(1) = (1 - w) * x_old(1) + w * ((9 + 12 * x(2)) / -3);

        % Atualização de x2
        x(2) = (1 - w) * x_old(2) + w * ((8 - 10 * x(1)) / -2);

        % Calcular erro relativo
        rel_error = norm(x - x_old) / norm(x);

        % Verificar se o erro relativo é menor que a tolerância
        if rel_error < tol
            iter = k;
            break;
        end

        iter = k;
    end

    if iter < min_iter
        min_iter = iter;
        best_omega = w;
    end
end

% Melhor omega encontrado
omega = best_omega;
x = x0;

fprintf('Melhor fator de relaxamento ω = %.1f\n', omega);
fprintf('Iteração\t x1\t\t x2\t\t Erro Relativo\n');
fprintf('-------------------------------------------------------\n');

% Implementação do método SOR com melhor omega
for k = 1:max_iter
    x_old = x;

    % Atualização de x1
    x(1) = (1 - omega) * x_old(1) + omega * ((9 + 12 * x(2)) / -3);

    % Atualização de x2
    x(2) = (1 - omega) * x_old(2) + omega * ((8 - 10 * x(1)) / -2);

    % Calcular erro relativo
    rel_error = norm(x - x_old) / norm(x);

    % Exibir resultados
    fprintf('%d\t\t %.6f\t %.6f\t %.6f\n', k, x(1), x(2), rel_error);

    % Verificar se o erro relativo é menor que a tolerância
    if rel_error < tol
        fprintf('Convergência alcançada após %d iterações.\n', k);
        break;
    end
end

if k == max_iter
    fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
end

