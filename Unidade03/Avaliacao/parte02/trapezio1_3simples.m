% Definindo as variáveis
v_max = 1.5; % m/s
r_0 = 0.5; % m
n = 8; % valor dado

% Número de subintervalos
N = 1000; % maior N, mais precisa a integração

% Definindo o vetor de r
r = linspace(0, r_0, N+1);

% Função de velocidade
v_r = v_max * (1 - r/r_0).^(1/n);

% Integral usando o método trapezoidal
integral_trapezoidal = trapz(r, r .* v_r);

% Velocidade média calculada numericamente
v_media_numeric = (2 * v_max / r_0^2) * integral_trapezoidal;

% Solução analítica
v_media_analytical = (2 * v_max / r_0^2) * integral(@(r) r .* (1 - r/r_0).^(1/n), 0, r_0);

% Cálculo do erro
erro = abs(v_media_numeric - v_media_analytical);

% Exibindo os resultados
fprintf('Velocidade média (numericamente): %.6f m/s\n', v_media_numeric);
fprintf('Velocidade média (analiticamente): %.6f m/s\n', v_media_analytical);
fprintf('Erro: %.6f\n', erro);
