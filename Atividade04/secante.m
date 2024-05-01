function [raiz, iter] = secante()
    % Definição da função e valores iniciais
    f = @(x) x^2 - 3*x + exp(x) - 2;
    x0 = -1; % Valor aproximado x0
    x1 = 0; % Valor aproximado x1
    
    % Limites do erro e de iterações
    d = 1e-4;
    N = 1000;
    
    % Inicialização de variáveis
    xn_minus_1 = x0;
    xn = x1;
    
    % Cabeçalho da tabela
    fprintf('Iter     Xn         f(Xn)         Eaproximado\n');
    
    % Loop de iteração
    for iter = 1:N
        % Cálculo de xn+1
        xn_plus_1 = (xn_minus_1 * f(xn) - xn * f(xn_minus_1)) / (f(xn) - f(xn_minus_1));
        
        % Cálculo do erro aproximado
        if xn_plus_1 ~= 0
            ea = abs((xn_plus_1 - xn) / xn_plus_1) * 100;
        else
            ea = 0;
        end
        
        % Saída dos resultados
        fprintf('%d     %.8f     %.8f     %.8f\n', iter, xn_plus_1, f(xn_plus_1), ea);
        
        % Verificação de critérios de parada
        if ea < d
            raiz = xn_plus_1;
            fprintf('\nRaiz encontrada: %.8f\nNúmero de iterações: %d\n', raiz, iter);
            return;
        end
        
        % Atualiza os valores de xn-1 e xn
        xn_minus_1 = xn;
        xn = xn_plus_1;
    end
    
    % Se o método falhou em N iterações
    fprintf('Método falhou em %d iterações.\n', N);
end
