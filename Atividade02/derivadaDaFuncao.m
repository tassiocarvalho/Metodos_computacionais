% Define a função f(x)
f = @(x) -0.1*x.^4 - 0.15*x.^3 - 0.5*x.^2 - 0.25*x + 1.2;

% Define a derivada de f(x) para o valor verdadeiro
df = @(x) -0.4*x.^3 - 0.45*x.^2 - x - 0.25;

% Calcula o valor verdadeiro da derivada em x = 0.5
true_derivative = df(0.5);

% Inicializa as variáveis para os tamanhos de passo, diferença finita e erro verdadeiro
h_values = zeros(1, 5);
finite_diffs = zeros(1, 5);
true_errors = zeros(1, 5);

% Define o tamanho do passo inicial
h = 1;

% Executa o cálculo para diferentes tamanhos de passo
for i = 1:11
    % Calcula a derivada aproximada com diferença centrada
    approx_derivative = (f(0.5 + h) - f(0.5 - h)) / (2 * h);
    true_error = true_derivative - approx_derivative;
    
    % Armazena os valores
    h_values(i) = h;
    finite_diffs(i) = approx_derivative;
    true_errors(i) = abs(true_error);
    
    % Atualiza o tamanho do passo
    h = h / 10;
end

% Formata os números com 14 casas decimais e armazena como strings
formatted_h_values = arrayfun(@(x) sprintf('%.14f', x), h_values, 'UniformOutput', false);
formatted_finite_diffs = arrayfun(@(x) sprintf('%.14f', x), finite_diffs, 'UniformOutput', false);
formatted_true_errors = arrayfun(@(x) sprintf('%.14f', x), true_errors, 'UniformOutput', false);

% Cria a tabela com os valores formatados
T = table(formatted_h_values', formatted_finite_diffs', formatted_true_errors', ...
    'VariableNames', {'Tamanho_do_passo', 'Diferenca_finita', 'Erro_verdadeiro'});

% Exibe a tabela
disp(T);

% Plot o gráfico de erro
loglog(h_values, true_errors, '-o');
xlabel('Tamanho do passo (h)');
ylabel('Erro verdadeiro');
title('Erro na Derivada Numérica');
grid on;
