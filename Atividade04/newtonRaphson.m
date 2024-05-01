function [raiz, iter] = newtonRaphson()
    % Definição da função, sua derivada e ponto inicial
    f = @(x) x^2 - 3*x + exp(x) - 2;
    df = @(x) 2*x - 3 + exp(x);
    x0 = 0; % Supomos que a raiz negativa está próxima de 0
    
    % Limites do erro e de iterações
    d = 1e-4;
    N = 1000;
    
    % Inicialização de variáveis
    xn = x0;
    
    % Cabeçalho da tabela
    fprintf('Iter     Xn         f(Xn)         Eaproximado\n');
    
    % Loop de iteração
    for iter = 1:N
        % Cálculo do próximo valor de xn
        xn_next = xn - f(xn) / df(xn);
        
        % Cálculo do erro aproximado
        if xn_next ~= 0
            ea = abs((xn_next - xn) / xn_next) * 100;
        else
            ea = 0;
        end
        
        % Saída dos resultados
        fprintf('%d     %.8f     %.8f     %.8f\n', iter, xn_next, f(xn_next), ea);
        
        % Verificação de critérios de parada
        if ea < d
            raiz = xn_next;
            fprintf('\nRaiz encontrada: %.8f\nNúmero de iterações: %d\n', raiz, iter);
            return;
        end
        
        xn = xn_next;
    end
    
    % Se o método falhou em N iterações
    fprintf('Método falhou em %d iterações.\n', N);
end

