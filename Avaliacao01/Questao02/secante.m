function secante()
    % Definição dos valores iniciais
    x0 = 0;
    x1 = 100;
    tol = 1e-5;
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

    % Inicialização da tabela
    fprintf('Iteração\tXr\t\tf(Xr)\t\tErro Aprox\n');

    % Inicialização do método
    iter = 0;
    while iter < max_iter
        fx0 = f(x0);
        fx1 = f(x1);
        
        % Cálculo da próxima aproximação
        xr = x1 - (fx1 * (x1 - x0)) / (fx1 - fx0);
        fxr = f(xr);
        
        % Cálculo do erro aproximado
        if iter > 0
            erro_aprox = abs((xr - x1) / xr) * 100;
        else
            erro_aprox = 100;  % Indefinido na primeira iteração
        end
        
        % Mostra os resultados da iteração
        fprintf('%d\t\t%.4f\t\t%.4f\t\t%.2f%%\n', ...
                iter+1, xr, fxr, erro_aprox);
        
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
    fprintf('A raiz aproximada é t = %.5f\n', xr);
end
