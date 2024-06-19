% Definindo a matriz A
A = [
    -17/105, 1/30, 0, 1/10;
    1/30, -253/840, 1/8, 1/7;
    0, 1/8, -23/120, 1/15;
    1/10, 1/7, 1/15, -107/210
];

% Determinante de A
det_A = det(A);

% Número de condição de A
cond_A = cond(A);

% Cálculo das matrizes para Jacobi e Gauss-Seidel
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

% Matriz de iteração Jacobi
C_J = inv(D) * (L + U);

% Matriz de iteração Gauss-Seidel
C_GS = inv(D + L) * U;

% Raios espectrais
eigenvalues_J = eig(C_J);
rho_J = max(abs(eigenvalues_J));

eigenvalues_GS = eig(C_GS);
rho_GS = max(abs(eigenvalues_GS));

fprintf('Determinante de A: %f\n', det_A);
fprintf('Número de condição de A: %f\n', cond_A);
fprintf('Raio espectral para Jacobi: %f\n', rho_J);
fprintf('Raio espectral para Gauss-Seidel: %f\n', rho_GS);

