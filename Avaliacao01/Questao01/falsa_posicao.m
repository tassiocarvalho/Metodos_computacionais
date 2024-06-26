% Parâmetros iniciais
P = 35000;  % Valor do veículo
A = 8500;   % Pagamento anual
n = 7;      % Número de anos
tol = 0.00005;  % Critério de parada (tolerância)
a = 0.01;   % Limite inferior inicial para taxa de juros
b = 0.3;    % Limite superior inicial para taxa de juros

% Função para o cálculo do pagamento anual A
f = @(i) P * i * (1 + i)^n / ((1 + i)^n - 1) - A;

% Inicializações para armazenar os resultados de cada iteração
iters = [];
lower_bounds = [];
upper_bounds = [];
roots = [];
f_values = [];
errors = [];

% Método da falsa posição
iter = 0;  % Contador de iterações
while (b - a) > tol
    c = b - (f(b) * (b - a)) / (f(b) - f(a));  % Cálculo de c pelo método da falsa posição
    iter = iter + 1;  % Incrementa a iteração

    % Armazena os dados da iteração
    iters(end+1) = iter;
    lower_bounds(end+1) = a;
    upper_bounds(end+1) = b;
    roots(end+1) = c;
    f_values(end+1) = f(c);
    if iter > 1
        errors(end+1) = abs((roots(end) - roots(end-1)) / roots(end)*100);
    else
        errors(end+1) = 100;  % Não há erro na primeira iteração
    end  % Encerra o bloco if

    % Verifica a condição de parada mais estrita
    if f(c) == 0 || abs(f(c)) < tol || (iter > 1 && errors(end) < tol)
        break;

    elseif f(a) * f(c) < 0
        b = c;  % A raiz está no intervalo [a, c]
    else
        a = c;  % A raiz está no intervalo [c, b]
    end
end

% Cria a tabela com os resultados
T = table(iters', lower_bounds', upper_bounds', roots', f_values', ...
    'VariableNames', {'Iteração', 'Limite Inferior', 'Limite Superior', 'xr - Raiz Aproximada', 'f(xr)'});
disp(T);

% Exibe a raiz final encontrada
fprintf('A taxa de juros estimada é: %.5f%%\n', roots(end) * 100);
