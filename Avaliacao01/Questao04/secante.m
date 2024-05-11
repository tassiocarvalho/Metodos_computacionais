function h = secante()
    % Constantes
    r = 1; % raio da esfera em metros
    ps = 200; % densidade da esfera em kg/m^3
    pw = 1000; % densidade da água em kg/m^3
    pi = 3.141592653589793;
    
    % Volume submerso da esfera
    volume_submerso = @(h) (4/3) * pi * r^3 - (pi * h^2 / 3) * (3 * r - h);
    
    % Volume total da esfera
    volume_total = (4 / 3) * pi * r^3;
    
    % Função g(h) que deve ser zero no ponto de equilíbrio
    g = @(h) ps * volume_total / pw - volume_submerso(h);
    
    % Valor de referência conhecido
    h_real = 1.42480;
    
    % Estimativas iniciais
    x0 = 0; % Primeiro palpite inicial
    x1 = 2 * r; % Segundo palpite inicial (diâmetro da esfera)
    tol = 0.1; % Tolerância para o erro
    iter = 0;
    erro_aproximado = 100; % Erro inicial é 100%
    erro_verdadeiro = 100;
    
    % Tabela de saída com largura fixa
    fprintf('%-12s %-22s %-22s %-20s %-22s\n', 'Iteração', 'xr - Raiz Aproximada', 'f(xr)', 'Erro Aproximado (%)', 'Erro Verdadeiro (%)');
    
    % Método da secante
    while erro_aproximado > tol
        % Calcular o novo valor de xr usando a fórmula da secante
        xr = x1 - g(x1) * (x1 - x0) / (g(x1) - g(x0));
        iter = iter + 1;
        
        % Calcular erro aproximado
        if iter == 1
            erro_aproximado = 100;
        else
            erro_aproximado = abs((xr - x1) / xr) * 100;
        end
        
        % Calcular erro verdadeiro
        erro_verdadeiro = abs((xr - h_real) / h_real) * 100;

        % Imprimir os resultados na tabela
        fprintf('%-12d %-22.8f %-22.8f %-20.8f %-22.8f\n', iter, xr, g(xr), erro_aproximado, erro_verdadeiro);
        
        % Atualizar as variáveis para a próxima iteração
        x0 = x1;
        x1 = xr;
    end
    
    % Resultado final
    fprintf('\nRaiz aproximada (h): %.8f\n', xr);
    h = xr; % Retorna a raiz aproximada
end
