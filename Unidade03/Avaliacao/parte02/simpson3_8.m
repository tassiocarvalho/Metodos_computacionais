% Definindo as variáveis
v_max = 1.5; % m/s
r_0 = 0.5; % m
n = 8; % valor dado

% Número de subintervalos (N deve ser múltiplo de 3 para Simpson 3/8)
N = 999; 
if mod(N, 3) ~= 0
    N = N + 3 - mod(N, 3); % garantindo que N seja múltiplo de 3
end

% Definindo o vetor de r
r = linspace(0, r_0, N+1);

% Função de velocidade
v_r = v_max * (1 - r/r_0).^(1/n);

% Integral usando o método de Simpson 3/8
h = r(2) - r(1); % Tamanho do passo

% Calculando a integral usando a fórmula de Simpson 3/8
integral_simpson_38 = (3*h/8) * (r(1) * v_r(1) + r(end) * v_r(end) + ...
    3 * sum((r(2:3:end) .* v_r(2:3:end))) + ...
    3 * sum((r(3:3:end) .* v_r(3:3:end))) + ...
    2 * sum((r(4:3:end-3) .* v_r(4:3:end-3))));

% Velocidade média calculada numericamente
v_media_numeric = (2 * v_max / r_0^2) * integral_simpson_38;

% Solução analítica
v_media_analytical = (2 * v_max / r_0^2) * integral(@(r) r .* (1 - r/r_0).^(1/n), 0, r_0);

% Cálculo do erro
erro = abs(v_media_numeric - v_media_analytical);

% Exibindo os resultados
fprintf('Velocidade média (numericamente - Simpson 3/8): %.6f m/s\n', v_media_numeric);
fprintf('Velocidade média (analiticamente): %.6f m/s\n', v_media_analytical);
fprintf('Erro: %.6f\n', erro);
