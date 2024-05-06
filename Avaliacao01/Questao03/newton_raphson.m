function xr = newton_raphson()
    % Constantes
    e0 = 8.9e-12;
    q = 2e-5;
    Q = 2e-5;
    a = 0.85;
    F = 1.25;
    pi = 3.141592653589793;

    % Função g(x)
    g = @(x) (1 / (4 * pi * e0)) * (q * Q * x) / ((x^2 + a^2)^(3/2)) - F;
    % Derivada de g(x)
    dg = @(x) (1 / (4 * pi * e0)) * (q * Q * ((x^2 + a^2)^(3/2) - 3 * x^2 * (x^2 + a^2)^(1/2))) / ((x^2 + a^2)^3);

    % Aproximação inicial
    xr = 1.0; % Estimativa inicial de x
    erro_aproximado = 100;
    tol = 1e-6;
    iter = 0;

    % Tabela de saída
    fprintf('%-10s %-15s %-15s %-15s\n', 'Iter', 'Xr', 'f(Xr)', 'Erro Aprox');

    % Método de Newton-Raphson
    while erro_aproximado > tol
        xr_old = xr;
        xr = xr - g(xr) / dg(xr);
        iter = iter + 1;
        erro_aproximado = abs((xr - xr_old) / xr) * 100;

        % Imprimir tabela
        fprintf('%-10d %-15.5f %-15.5f %-15.5f\n', iter, xr, g(xr), erro_aproximado);
    end
    
    % Resultado final
    fprintf('\nRaiz aproximada: %.5f\n', xr);
end
