function [raiz, iter] = pontoFixoInteracaoLinear()
    % Definição da função f(x) e sua função de iteração g(x)
    f = @(x) x^2 - 3*x + exp(x) - 2;
    g = @(x) (x^2 + exp(x) - 2)/3;
    
    % Ponto inicial x0
    x0 = 0; % Usamos 0 como ponto inicial para encontrar a raiz negativa
    
    % Limites do erro e de iterações
    d = 0.0001;
    N = 1000;
    
    % Inicialização de variáveis
    xr = x0;
    iter = 0;
    
    % Cabeçalho da tabela
    fprintf('Iter     Xr         f(Xr)         Eaproximado\n');
    
    % Loop de iteração
    while iter < N
        xr_ant = xr;
        xr = g(xr_ant);
        iter = iter + 1;
        
        % Cálculo do erro aproximado
        if xr ~= 0
            ea = abs((xr - xr_ant) / xr) * 100;
        else
            ea = 0;
        end
        
        % Saída dos resultados
        fprintf('%d     %.8f     %.8f     %.8f\n', iter, xr, f(xr), ea);
        
        % Verificação de critérios de parada
        if ea < d
            raiz = xr;
            fprintf('\nRaiz encontrada: %.8f\nNúmero de iterações: %d\n', raiz, iter);
            return;
        end
    end
    
    % Se o método falhou em N iterações
    fprintf('Método falhou em %d iterações.\n', N);
end
