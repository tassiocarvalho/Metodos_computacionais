% Parâmetros iniciais
P = 35000;    % Valor do veículo
A = 8500;     % Pagamento anual
n = 7;        % Número de anos
tol = 0.00005;  % Critério de parada (tolerância)
x0 = 0.01;     % Palpite inicial para a taxa de juros

% Definindo a função e sua derivada
f = @(i) P * i * (1 + i)^n / ((1 + i)^n - 1) - A;
df = @(i) P * ((1 + i)^n * (1 + n * i) - n * i * (1 + i)^(n - 1)) / ((1 + i)^(2 * n) - 2 * (1 + i)^n + 1);

% Inicializações para armazenar os resultados de cada iteração
iters = [];
roots = [];
f_values = [];
errors = [];
true_errors = [];

% Método de Newton-Raphson
iter = 0;
x = x0;
erro_aproximado = 100;
while true
    iter = iter + 1;
    fx = f(x);
    dfx = df(x);
    xnew = x - fx / dfx;  % Próxima aproximação

    % Calcula o erro aproximado
    if iter > 1
        erro_aproximado = abs((xnew - x) / xnew) * 100;
    end

    % Armazena os dados da iteração
    iters(end + 1) = iter;
    roots(end + 1) = x;
    f_values(end + 1) = fx;
    errors(end + 1) = erro_aproximado;

    % Verifica a condição de parada
    if abs(xnew - x) < tol
        iter = iter + 1;
        iters(end + 1) = iter;
        roots(end + 1) = xnew;
        f_values(end + 1) = f(xnew);
        errors(end + 1) = erro_aproximado;  % Mantém o erro calculado na penúltima iteração
        break;
    end

    x = xnew;  % Atualiza x para a nova estimativa
end

% Cálculo do erro verdadeiro
final_root = roots(end);  % A última estimativa de taxa de juros encontrada
for j = 1:length(roots)
    true_errors(j) = abs((final_root - roots(j)) / final_root) * 100;
end

% Cria a tabela com os resultados
T = table(iters', roots', f_values', errors', true_errors',  ...
    'VariableNames', {'Iteração', 'xr - Raiz Aproximada', 'f(xr)', 'Erro Aproximado', 'Erro Verdadeiro' });
disp(T);

% Exibe a raiz final encontrada
fprintf('A taxa de juros estimada é: %.5f%%\n', final_root * 100);