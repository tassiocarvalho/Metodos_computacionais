% Dados fornecidos
x = [0 1 2 3 4 5];
y = [0 20 60 68 77 100];

% Número de pontos
n = length(x);

% Graus dos polinômios a ajustar
graus = 1:5;

% Preparar a figura
figure;
hold on;

% Plotar os pontos originais
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'Dados originais');

for g = graus
    % Número de coeficientes a determinar
    m = g + 1;

    % Inicializar matriz A e vetor b
    A = zeros(m, m);
    b = zeros(m, 1);
    
    % Formação do sistema de equações
    for i = 1:m
        for j = 1:m
            if i == 1 && j == 1
                A(i, j) = n;
            else
                k1 = i - 1;
                k2 = j - 1;
                s = 0;
                for k = 1:n
                    s = s + x(k)^(k1 + k2);
                end
                A(i, j) = s;
            end
        end
        s = 0;
        if i == 1
            for k = 1:n
                s = s + y(k);
            end
        else
            for k = 1:n
                s = s + y(k) * x(k)^(i-1);
            end
        end
        b(i) = s;
    end
    
    % Resolução do sistema linear usando eliminação de Gauss
    for k = 1:m-1
        for i = k+1:m
            pv = A(i, k) / A(k, k);
            A(i, k) = 0;
            for j = k+1:m
                A(i, j) = A(i, j) - pv * A(k, j);
            end
            b(i) = b(i) - pv * b(k);
        end
    end
    
    % Solução do sistema
    coef = zeros(m, 1);
    coef(m) = b(m) / A(m, m);
    for k = m-1:-1:1
        s = 0;
        for j = k+1:m
            s = s + A(k, j) * coef(j);
        end
        coef(k) = (b(k) - s) / A(k, k);
    end
    
    % Formação do polinômio de regressão
    y_fit = zeros(size(x));
    for i = 1:m
        y_fit = y_fit + coef(i) * x.^(i-1);
    end
    
    % Calcular o coeficiente de determinação (R²)
    SS_tot = sum((y - mean(y)).^2);
    SS_res = sum((y - y_fit).^2);
    R2 = 1 - (SS_res / SS_tot);
    
    % Exibir os coeficientes
    fprintf('Coeficientes do polinômio de ordem %d:\n', g);
    for i = 1:m
        fprintf('a%d = %.4f\n', i-1, coef(i));
    end
    fprintf('R² = %.4f\n\n', R2);
    
    % Plotar o polinômio ajustado
    plot(x, y_fit, 'DisplayName', sprintf('Polinômio de ordem %d (R² = %.4f)', g, R2));
end

% Configurações do gráfico
xlabel('x');
ylabel('y');
title('Ajuste Polinomial dos Dados');
legend('show');
grid on;
hold off;
