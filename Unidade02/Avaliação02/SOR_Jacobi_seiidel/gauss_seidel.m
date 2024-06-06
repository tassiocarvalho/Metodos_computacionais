function gauss_seidel()
    % Definindo a matriz A e o vetor b
    A = [-17/105, 1/30, 0, 1/10; 1/30, -253/840, 1/8, 1/7; 0, 1/8, -23/120, 1/15; 1/10, 1/7, 1/15, -107/210];
    b = [-20/35; 0; 0; -28];

    % Inicialização do tamanho de A
    n = size(A, 1);

    % Tentar rearranjar A e b para satisfazer o critério de Sassenfeld
    [A, b, success] = try_all_rearrangements(A, b);

    if ~success
        error('O critério de Sassenfeld não é satisfeito com nenhum rearranjo. O método de Gauss-Seidel pode não convergir.');
    end

    % Critério de Sassenfeld garantido satisfeito
    disp('Um rearranjo satisfatório foi encontrado. O método de Gauss-Seidel deve convergir.');

    % Inicialização
    x0 = zeros(n, 1); % vetor inicial
    x = x0;
    tol = 0.001; % tolerância
    max_iter = 100; % número máximo de iterações
    iter = 0;

    fprintf('Iteração\t x1\t\t x2\t\t x3\t\t x4\t\t Erro Relativo\n');
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
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', k, x(1), x(2), x(3), x(4), rel_error);
    
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
end

function [A, b, success] = try_all_rearrangements(A, b)
    % Gera todas as permutações possíveis das linhas
    n = size(A, 1);
    perm = perms(1:n);
    numPerms = size(perm, 1);
    for p = 1:numPerms
        % Aplica a permutação atual à matriz A e ao vetor b
        Ap = A(perm(p,:), :);
        bp = b(perm(p,:));

        % Verifica o critério de Sassenfeld
        if check_sassenfeld(Ap)
            A = Ap;
            b = bp;
            success = true;
            return;
        end
    end
    success = false;
end

function success = check_sassenfeld(A)
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
    success = max(B) < 1;
end
