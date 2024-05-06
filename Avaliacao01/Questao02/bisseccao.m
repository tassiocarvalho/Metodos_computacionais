function bisseccao()
    % Definição dos limites iniciais e tolerância
    a = 0;
    b = 100;
    tol = 1e-5;

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
    fprintf('Iteração\tLim Inf\t\tLim Sup\t\tXr\t\tf(Xr)\t\tErro Aprox\n');
    
    % Inicialização do método
    iter = 0;
    xr_prev = 0;
    while (b - a) / 2 > tol
        xr = (a + b) / 2;
        fa = f(a);
        fxr = f(xr);
        
        % Atualiza os limites
        if fa * fxr < 0
            b = xr;
        else
            a = xr;
        end
        
        % Cálculo do erro aproximado
        if iter > 0
            erro_aprox = abs((xr - xr_prev) / xr) * 100;
        else
            erro_aprox = 100;  % Indefinido na primeira iteração
        end
        
        % Atualiza para próxima iteração
        xr_prev = xr;
        
        % Mostra os resultados da iteração
        fprintf('%d\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.2f%%\n', ...
                iter, a, b, xr, fxr, erro_aprox);
        
        iter = iter + 1;
    end
    
    % Resultado final
    t = xr;
    fprintf('A raiz aproximada é t = %.5f\n', t);
end
