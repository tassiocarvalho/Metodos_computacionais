function plot_convergencia_bisseccao_esfera()
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
    
    % Limites iniciais para a bissecção
    xl = 0; % Altura mínima
    xu = 2 * r; % Altura máxima (diâmetro da esfera)
    tol = 0.1; % Tolerância para o erro
    iter = 0;
    erro_aproximado = 100;
    xr_old = xl;
    
    % Inicializações para armazenar os resultados de cada iteração
    iters = [];
    roots = [];
    errors = [];

    % Método da bissecção
    while erro_aproximado > tol
        xr = (xl + xu) / 2; % Ponto médio entre xl e xu
        iter = iter + 1;
        if g(xl) * g(xr) < 0
            xu = xr; % A raiz está entre xl e xr
        else
            xl = xr; % A raiz está entre xr e xu
        end
        erro_aproximado = abs((xr - xr_old) / xr) * 100;
        xr_old = xr;

        % Armazenando os dados para plotagem
        iters(end+1) = iter;
        roots(end+1) = xr;
        errors(end+1) = erro_aproximado;
    end

    % Plotando o gráfico de convergência
    figure;
    plot(iters, roots, '-o');
    title('Gráfico de Convergência da Altura Submersa');
    xlabel('Iteração');
    ylabel('Estimativa da Altura Submersa (m)');
    grid on;

    % Plotando o gráfico de erro aproximado
    figure;
    plot(iters, errors, '-o');
    title('Erro Aproximado a Cada Iteração');
    xlabel('Iteração');
    ylabel('Erro Aproximado (%)');
    grid on;
end
