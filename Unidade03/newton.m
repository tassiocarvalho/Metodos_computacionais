% Data points
x = [0, 0.5, 1.0];
y = [1.0, 2.12, 3.55];

% Number of data points
n = length(x);

% Initialize divided difference table
b = zeros(n,n);
b(:,1) = y';

% Calculate the divided differences
for j = 2:n
    for i = 1:n-j+1
        b(i,j) = (b(i+1,j-1) - b(i,j-1)) / (x(i+j-1) - x(i));
    end
end

% Display the divided difference table
disp('Tabela de diferença dividida:');
disp(b);

% Evaluate the Newton interpolating polynomial at a given point xx
xx = 0.7;
y_int = b(1,1);
xt = 1;
for j = 1:n-1
    xt = xt * (xx - x(j));
    y_int = y_int + b(1,j+1) * xt;
end

fprintf('O valor interpolado em x = %.2f is y = %.4f\n', xx, y_int);

% Plot the polynomial
xx_values = linspace(min(x), max(x), 100);
yy_values = zeros(size(xx_values));
for k = 1:length(xx_values)
    xt = 1;
    yy_values(k) = b(1,1);
    for j = 1:n-1
        xt = xt * (xx_values(k) - x(j));
        yy_values(k) = yy_values(k) + b(1,j+1) * xt;
    end
end

figure;
plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Pontos de dados');
hold on;
plot(xx_values, yy_values, 'b-', 'DisplayName', 'Polinomio interpolador');
xlabel('x');
ylabel('f(x)');
title('Polinomio interpolador de Newton');
legend show;
grid on;