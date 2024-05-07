function secante()
    % Definição dos valores iniciais
    x0 = 0;
    x1 = 100;
    tol = 1e-2;
    max_iter = 1000;

    % Definição dos parâmetros
    Pu_max = 80000;
    ku = 0.05;
    Pu_min = 110000;
    Ps_max = 320000;
    P0 = 10000;
    ks = 0.09;
    
    % Função f(t)
    f = @(t) (Ps_max / (1 + ((Ps_max / P0) - 1) * exp(-ks * t))) - ...
             1.2 * (Pu_max * exp(-ku * t) + Pu_min);

    % Inicialização da tabela com largura fixa
    fprintf('%-10s %-15s %-15s %-15s\n', ...
            'Iteração', 'Xr', 'f(Xr)', 'Erro Aprox (%)');

    % Inicialização do método
    iter = 0;
    erro_aprox = 100;  % Inicia com 100% na primeira iteração

    while iter < max_iter
        fx0 = f(x0);
        fx1 = f(x1);
        
        % Cálculo da próxima aproximação
        xr = x1 - (fx1 * (x1 - x0)) / (fx1 - fx0);
        fxr = f(xr);
        
        % Cálculo do erro aproximado
        if iter > 0
            erro_aprox = abs((xr - x1) / xr) * 100;
        end
        
        % Mostra os resultados da iteração com largura fixa
        fprintf('%-10d %-15.8f %-15.8f %-15.8f\n', ...
                iter + 1, xr, fxr, erro_aprox);
        
        % Verifica a condição de parada
        if abs(fxr) < tol || abs(xr - x1) < tol
            break;
        end
        
        % Preparação para a próxima iteração
        x0 = x1;
        x1 = xr;
        
        iter = iter + 1;
    end
    
    % Resultado final
    fprintf('\nA raiz aproximada é t = %.8f\n', xr);
end
