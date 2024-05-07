function h = ponto_fixo_esfera()
    % Constantes
    r = 1; % raio da esfera
    ps = 200; % densidade da esfera (kg/m^3)
    pw = 1000; % densidade da água (kg/m^3)
    pi = 3.141592653589793;
    
    % Volume total da esfera
    volume_total = (4 / 3) * pi * r^3;
    
    % Volume submerso da esfera para a condição de equilíbrio
    volume_submerso_esperado = ps * volume_total / pw;
    
    % Função g(h)
    g = @(h) (3 * volume_submerso_esperado / (pi * (3 * r - h)))^(1/2);

    % Aproximação inicial
    xr = r; % Estimativa inicial
    erro_aproximado = 100;
    tol = 1e-6;
    iter = 0;

    % Tabela de saída
    fprintf('%-10s %-15s %-15s %-15s\n', 'Iter', 'Xr', 'f(Xr)', 'Erro Aprox');

    % Método do ponto fixo
    while erro_aproximado > tol
        xr_old = xr;
        xr = g(xr);
        iter = iter + 1;
        erro_aproximado = abs((xr - xr_old) / xr) * 100;

        % Imprimir tabela
        fprintf('%-10d %-15.5f %-15.5f %-15.5f\n', iter, xr, g(xr), erro_aproximado);
    end
    
    % Resultado final
    fprintf('\nRaiz aproximada (h): %.5f\n', xr);
end
