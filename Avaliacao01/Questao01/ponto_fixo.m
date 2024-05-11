% Parâmetros iniciais
P = 35000;    % Valor do veículo
A = 8500;     % Pagamento anual
n = 7;        % Número de anos
tol = 0.00005; % Critério de parada
i0 = 0.01;    % Palpite inicial para a taxa de juros

% Definindo a função g(i)
g = @(i) (A * (1 + i)^n - A) / (P * (1 + i)^n);

% Inicializações para armazenar os resultados de cada iteração
iters = [];
roots = [];
g_values = [];
approx_errors = [];
true_errors = [];

% Método do ponto fixo
iter = 0;
i = i0;
while true
    iter = iter + 1;
    inew = g(i);  % Calcula o novo valor de i usando g(i)
    
    % Armazena os dados da iteração
    iters(end+1) = iter;
    roots(end+1) = i;
    g_values(end+1) = inew;
    if iter > 1
        approx_errors(end+1) = abs((inew - i) / inew) * 100;
    else
        approx_errors(end+1) = 100;  % Não há erro aproximado na primeira iteração
    end
    
    % Verifica a condição de parada
    if abs(inew - i) < tol
        break;
    end
    
    i = inew;  % Atualiza i para a nova estimativa
end

% Cálculo do erro verdadeiro
final_root = roots(end);  % A última estimativa de taxa de juros encontrada
for j = 1:length(roots)
    true_errors(j) = abs((final_root - roots(j)) / final_root) * 100;
end

% Cria a tabela com os resultados
T = table(iters', roots', g_values', approx_errors',...
    'VariableNames', {'Iteração', 'i - Taxa de Juros Aproximada', 'g(i)', 'Erro Aproximado'});
disp(T);

% Exibe a taxa de juros final encontrada
fprintf('A taxa de juros estimada é: %.5f%%\n', final_root * 100);
