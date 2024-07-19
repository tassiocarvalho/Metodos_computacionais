% Definindo as variáveis
v_max = 1.5; % m/s
r_0 = 0.5; % m
n = 8; % valor dado

% Número de subintervalos (N deve ser par para Simpson 1/3)
N = 1000; 
if mod(N, 2) ~= 0
    N = N + 1; % garantindo que N seja par
end

% Definindo o vetor de r
r = linspace(0, r_0, N+1);

% Função de velocidade
v_r = v_max * (1 - r/r_0).^(1/n);

% Integral usando o método de Simpson 1/3 composto
h = r(2) - r(1); % Tamanho do passo

% Calculando a integral usando a fórmula de Simpson 1/3 composto
integral_simpson = (h/3) * (r(1) * v_r(1) + r(end) * v_r(end) + ...
    4 * sum((r(2:2:end-1) .* v_r(2:2:end-1))) + ...
    2 * sum((r(3:2:end-2) .* v_r(3:2:end-2))));

% Velocidade média calculada numericamente
v_media_numeric = (2 * v_max / r_0^2) * integral_simpson;

% Solução analítica
v_media_analytical = (2 * v_max / r_0^2) * integral(@(r) r .* (1 - r/r_0).^(1/n), 0, r_0);

% Cálculo do erro
erro = abs(v_media_numeric - v_media_analytical);

% Exibindo os resultados
fprintf('Velocidade média (numericamente - Simpson 1/3 composto): %.6f m/s\n', v_media_numeric);
fprintf('Velocidade média (analiticamente): %.6f m/s\n', v_media_analytical);
fprintf('Erro: %.6f\n', erro);
