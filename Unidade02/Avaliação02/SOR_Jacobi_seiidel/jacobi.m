% Sistema de Equações
A = [-17/105, 1/30, 0, 1/10, 0, 0, 0;
     1/30, -253/840, 1/8, 1/7, 0, 0, 0;
     0, 1/8, -23/120, 1/15, 0, 0, 0;
     1/10, 1/7, 1/15, -107/210, 0, 0, 0;
     0, 0, 0, 0, -30, 7, 0;
     0, 0, 0, 0, 4, -47, 10;
     0, 0, 0, 0, 0, 10, -50];

b = [-20/35; 0; 0; -28; 0; 0; -120];

% Inicialização
n = size(A, 1); % Número de variáveis
x = zeros(n, 1); % Vetor inicial
tol = 0.01; % Tolerância
max_iter = 1000; % Número máximo de iterações
iter = 0;

% Cabeçalho para impressão
header = 'Iteração';
for i = 1:n
    header = sprintf('%s\t x%-7d', header, i);
end
header = sprintf('%s\t Erro Relativo\n', header);
fprintf(header);

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
    fprintf('%-9d', k);
    for i = 1:n
        fprintf('\t %-10.6f', x_new(i));
    end
    fprintf('\t %-13.8f\n', rel_error);

    % Verificar se o erro relativo é menor que a tolerância
    if rel_error < tol
        fprintf('Convergência alcançada após %d iterações.\n', k);
        break;
    end

    x = x_new; % Atualizar x para a nova estimativa
    iter = k;
end

if iter == max_iter
    fprintf('Número máximo de iterações atingido. Método não convergiu.\n');
end

