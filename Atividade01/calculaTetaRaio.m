function T = calculaTetaRaio(x, y)
    % Calcula o número de entradas com base no comprimento dos vetores x e y
    n = length(x);
    
    % Inicializar vetores para armazenar r e teta
    r = zeros(n, 1);
    teta = zeros(n, 1);
    
    % Loop para calcular r e teta baseado nos valores de x e y fornecidos
    for i = 1:n
        % Calcular o raio
        r(i) = sqrt(x(i)^2 + y(i)^2);
        
        % Calcular teta baseado nas condições fornecidas
        if x(i) > 0
            teta(i) = atan(y(i)/x(i));
        elseif x(i) < 0
            if y(i) >= 0
                teta(i) = atan(y(i)/x(i)) + pi;
            else
                teta(i) = atan(y(i)/x(i)) - pi;
            end
        else % x(i) == 0
            if y(i) > 0
                teta(i) = pi/2;
            elseif y(i) < 0
                teta(i) = -pi/2;
            else % x = 0 e y = 0
                teta(i) = 0; % A direção não é definida
            end
        end
        % Convertendo teta para graus
        teta(i) = rad2deg(teta(i));
    end
    
    % Criar uma tabela com os resultados
    T = table(x', y', r, teta, 'VariableNames', {'x', 'y', 'r', 'teta'});
end

%para realizar testes no terminal use os inputs:
%x=[2, 2, 0, -3, -2, -1, 0, 0, 2];
%y=[0, 1, 3, 1, 0, -2, 0, -2, 2];
%T = calculaTetaRaio(x, y);
%disp(T);