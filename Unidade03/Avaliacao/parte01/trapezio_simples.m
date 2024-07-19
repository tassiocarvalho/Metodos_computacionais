% Definição das variáveis
h = pi/12;
x = pi/4;

% Valor verdadeiro da derivada de y = cos(x) em x = pi/4
dy_true = -sin(x);

% Diferenças progressivas O(h)
dy_forward_1 = (cos(x + h) - cos(x)) / h;
error_forward_1 = abs((dy_true - dy_forward_1) / dy_true) * 100;

% Diferenças regressivas O(h)
dy_backward_1 = (cos(x) - cos(x - h)) / h;
error_backward_1 = abs((dy_true - dy_backward_1) / dy_true) * 100;

% Diferenças centradas O(h^2)
dy_centered_2 = (cos(x + h) - cos(x - h)) / (2 * h);
error_centered_2 = abs((dy_true - dy_centered_2) / dy_true) * 100;

% Diferenças progressivas O(h^2)
dy_forward_2 = (-cos(x + 2*h) + 4*cos(x + h) - 3*cos(x)) / (2 * h);
error_forward_2 = abs((dy_true - dy_forward_2) / dy_true) * 100;

% Diferenças regressivas O(h^2)
dy_backward_2 = (3*cos(x) - 4*cos(x - h) + cos(x - 2*h)) / (2 * h);
error_backward_2 = abs((dy_true - dy_backward_2) / dy_true) * 100;

% Exibição dos resultados
fprintf('Aproximações da primeira derivada de y = cos(x) em x = pi/4\n');
fprintf('Diferença Progressiva O(h): %f\n', dy_forward_1);
fprintf('Erro Relativo Percentual: %f%%\n\n', error_forward_1);

fprintf('Diferença Regressiva O(h): %f\n', dy_backward_1);
fprintf('Erro Relativo Percentual: %f%%\n\n', error_backward_1);

fprintf('Diferença Centrada O(h^2): %f\n', dy_centered_2);
fprintf('Erro Relativo Percentual: %f%%\n\n', error_centered_2);

fprintf('Diferença Progressiva O(h^2): %f\n', dy_forward_2);
fprintf('Erro Relativo Percentual: %f%%\n\n', error_forward_2);

fprintf('Diferença Regressiva O(h^2): %f\n', dy_backward_2);
fprintf('Erro Relativo Percentual: %f%%\n\n', error_backward_2);
