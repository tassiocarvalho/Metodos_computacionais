% Parâmetros do problema
L = 0.05; % Indutância em H
R = 20; % Resistência em Ohms
E = 10; % Fonte de tensão em V
h = 0.001; % Passo
t_final = 0.02; % Tempo final
N = t_final / h; % Número de passos

% Inicialização das variáveis
t = 0:h:t_final;
i_Euler = zeros(1, N+1);
i_Heun = zeros(1, N+1);
i_Heun_corr = zeros(1, N+1);
i_Midpoint = zeros(1, N+1);

% Função derivada
di_dt = @(t, i) (E - R*i) / L;

% Método de Euler
for n = 1:N
    i_Euler(n+1) = i_Euler(n) + h * di_dt(t(n), i_Euler(n));
end

% Método de Heun (modificado)
for n = 1:N
    f1 = di_dt(t(n), i_Heun(n));
    i_pred = i_Heun(n) + h * f1;
    f2 = di_dt(t(n+1), i_pred);
    i_Heun(n+1) = i_Heun(n) + (h/2) * (f1 + f2);
end

% Método de Heun (modificado com critério de convergência)
tolerance = 1e-6;
for n = 1:N
    f1 = di_dt(t(n), i_Heun_corr(n));
    i_pred = i_Heun_corr(n) + h * f1;
    f2 = di_dt(t(n+1), i_pred);
    i_corr = i_Heun_corr(n) + (h/2) * (f1 + f2);
    
    while abs(i_corr - i_pred) > tolerance
        i_pred = i_corr;
        f2 = di_dt(t(n+1), i_pred);
        i_corr = i_Heun_corr(n) + (h/2) * (f1 + f2);
    end
    i_Heun_corr(n+1) = i_corr;
end

% Método do Ponto Médio
for n = 1:N
    f1 = di_dt(t(n), i_Midpoint(n));
    i_mid = i_Midpoint(n) + (h/2) * f1;
    f2 = di_dt(t(n) + h/2, i_mid);
    i_Midpoint(n+1) = i_Midpoint(n) + h * f2;
end

% Solução analítica
i_analytical = 0.5 * (1 - exp(-400 * t));

% Exibir resultados das primeiras duas iterações
fprintf('Método de Euler:\n');
fprintf('Iteração 1: t = %f, i = %f\n', t(2), i_Euler(2));
fprintf('Iteração 2: t = %f, i = %f\n', t(3), i_Euler(3));

fprintf('\nMétodo de Heun:\n');
fprintf('Iteração 1: t = %f, i = %f\n', t(2), i_Heun(2));
fprintf('Iteração 2: t = %f, i = %f\n', t(3), i_Heun(3));

fprintf('\nMétodo de Heun (com critério de convergência):\n');
fprintf('Iteração 1: t = %f, i = %f\n', t(2), i_Heun_corr(2));
fprintf('Iteração 2: t = %f, i = %f\n', t(3), i_Heun_corr(3));

fprintf('\nMétodo do Ponto Médio:\n');
fprintf('Iteração 1: t = %f, i = %f\n', t(2), i_Midpoint(2));
fprintf('Iteração 2: t = %f, i = %f\n', t(3), i_Midpoint(3));

% Plotar resultados
figure;
hold on;
plot(t, i_Euler, 'r', 'DisplayName', 'Euler');
plot(t, i_Heun, 'g', 'DisplayName', 'Heun');
plot(t, i_Heun_corr, 'b', 'DisplayName', 'Heun com critério');
plot(t, i_Midpoint, 'm', 'DisplayName', 'Ponto Médio');
plot(t, i_analytical, 'k--', 'DisplayName', 'Solução Analítica');
xlabel('Tempo (s)');
ylabel('Corrente (A)');
legend;
title('Métodos Numéricos para Resolução da EDO');
hold off;
