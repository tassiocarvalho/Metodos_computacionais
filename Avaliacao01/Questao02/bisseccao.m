function bisseccao()
    % Definição dos limites iniciais e tolerância
    a = 0;
    b = 100;
    tol = 1e-3;

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
    fprintf('%-10s %-15s %-15s %-15s %-15s %-15s\n', ...
            'Iteração', 'Lim Inf', 'Lim Sup', 'Xr', 'f(Xr)', 'Erro Aprox (%)');
    
    % Inicialização do método
    iter = 0;
    xr_prev = 0;
    erro_aprox = 100; % Definido inicialmente como 100 para a primeira iteração
    
    while (b - a) / 2 > tol
        % Calcular a raiz média entre os limites
        xr = (a + b) / 2;
        fa = f(a);
        fxr = f(xr);
        
        % Atualiza os limites com base no sinal do produto fa * fxr
        if fa * fxr < 0
            b = xr;
        else
            a = xr;
        end
        
        % Cálculo do erro aproximado
        if iter > 0
            erro_aprox = abs((xr - xr_prev) / xr) * 100;
        end
        
        % Atualiza a raiz anterior para a próxima iteração
        xr_prev = xr;
        
        % Exibe os resultados da iteração com alinhamento fixo
        fprintf('%-10d %-15.8f %-15.8f %-15.8f %-15.8f %-15.8f\n', ...
                iter, a, b, xr, fxr, erro_aprox);
        
        iter = iter + 1;
    end
    
    % Resultado final
    fprintf('\nA raiz aproximada é t = %.8f\n', xr);
end
