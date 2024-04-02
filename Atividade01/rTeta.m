% Solicitar ao usuário o número de entradas
n = input('Quantas entradas? ');

% Inicializar vetores para armazenar x, y, r e teta
x = zeros(n, 1);
y = zeros(n, 1);
r = zeros(n, 1);
teta = zeros(n, 1);

% Loop para coletar os dados e calcular r e teta
for i = 1:n
    % Coletar dados de x e y
    fprintf('Entrada %d\n', i);
    x(i) = input('x: ');
    y(i) = input('y: ');
    
    % Calcular o raio
    r(i) = sqrt(x(i)^2 + y(i)^2);
    
    % Calcular teta baseado nas condições fornecidas
    if x(i) > 0
        teta(i) = atan(y(i)/x(i));
    elseif x(i) < 0
        if y(i) > 0
            teta(i) = atan(y(i)/x(i)) + pi;
        elseif y(i) < 0
            teta(i) = atan(y(i)/x(i)) - pi;
		else 
			teta(i) = p;
        end
    else % x(i) == 0
        if y(i) > 0
            teta(i) = pi/2;
        elseif y(i) < 0
            teta(i) = -pi/2;
        else
            teta(i) = 0;
        end
    end
end

% Criar uma tabela com os resultados
T = table(x, y, r, teta, 'VariableNames', {'x', 'y', 'r', 'teta'});

% Exibir a tabela
disp(T);
