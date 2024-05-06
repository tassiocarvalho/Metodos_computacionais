function xr = falsa_posicao()
    % Constantes
    e0 = 8.9e-12;
    q = 2e-5;
    Q = 2e-5;
    a = 0.85;
    F = 1.25;
    pi = 3.141592653589793;

    % Função g(x)
    g = @(x) (1 / (4 * pi * e0)) * (q * Q * x) / ((x^2 + a^2)^(3/2)) - F;

    % Limites iniciais
    xl = 1; % Iniciar um pouco acima de 0 para evitar divisão por zero
    xu = 2;    % Estimativa superior inicial
    xr = xl;
    erro_aproximado = 100;
    tol = 1e-6;
    iter = 0;

    % Tabela de saída
    fprintf('%-10s %-15s %-15s %-15s %-15s %-15s\n', 'Iter', 'Xl', 'Xu', 'Xr', 'f(Xr)', 'Erro Aprox');

    % Método da falsa posição
    while erro_aproximado > tol
        xr_old = xr;
        xr = xu - (g(xu) * (xl - xu)) / (g(xl) - g(xu));
        iter = iter + 1;
        if g(xl) * g(xr) < 0
            xu = xr;
        else
            xl = xr;
        end
        if iter > 1
            erro_aproximado = abs((xr - xr_old) / xr) * 100;
        end
        
        % Imprimir tabela
        fprintf('%-10d %-15.5f %-15.5f %-15.5f %-15.5f %-15.5f\n', iter, xl, xu, xr, g(xr), erro_aproximado);
    end
    
    % Resultado final
    fprintf('\nRaiz aproximada: %.5f\n', xr);
end
