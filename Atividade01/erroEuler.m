% Valor verdadeiro de e^0.5
valorVerdadeiro = 1.648721;

% Inicializações
x = 0.5;
aproximado = 1; % Primeiro termo da série de Taylor é sempre 1 para e^x
n = 1; % Contador para o fatorial e o termo de x^n
epsilon = 1e-5; % Limiar de erro absoluto
erro = abs(valorVerdadeiro - aproximado) / valorVerdadeiro;

% Tabela de resultados
disp('Iteração | Valor Aproximado | Erro Absoluto');
fprintf('%9d | %16.8f | %13.8f\n', 0, aproximado, erro);

% Loop até que o erro esteja abaixo do epsilon
while erro > epsilon
    termo = (x^n) / factorial(n); % Calcula o termo atual da série
    aproximado = aproximado + termo; % Atualiza o valor aproximado
    
    % Recalcula o erro com o novo valor aproximado
    erro = abs(valorVerdadeiro - aproximado) / valorVerdadeiro;
    
    % Exibe os resultados da iteração atual
    fprintf('%9d | %16.8f | %13.8f\n', n, aproximado, erro);
    
    % Prepara para a próxima iteração
    n = n + 1;
end
