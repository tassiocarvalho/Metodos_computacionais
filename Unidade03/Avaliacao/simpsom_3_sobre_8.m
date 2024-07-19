% Definição das variáveis
r0 = 0.5; % raio do tubo em metros
n = 8; % valor de n
vmax = 1.5; % velocidade máxima em m/s

% Definição da função de velocidade
v = @(r) vmax * (1 - (r / r0).^(1/n));

% Número de segmentos para integração (deve ser múltiplo de 3)
num_segments = 999;
if mod(num_segments, 3) ~= 0
    num_segments = num_segments + (3 - mod(num_segments, 3)); % garantir que num_segments seja múltiplo de 3
end

% Intervalo de integração
r = linspace(0, r0, num_segments + 1);
h = (r0 - 0) / num_segments; % largura de cada segmento

% Aplicação da regra de Simpson 3/8
integral_value = v(r(1)) * r(1) + v(r(end)) * r(end); % termos nas extremidades
for i = 2:3:num_segments-1
    integral_value = integral_value + 3 * v(r(i)) * r(i);
end
for i = 3:3:num_segments-2
    integral_value = integral_value + 3 * v(r(i)) * r(i);
end
for i = 4:3:num_segments-3
    integral_value = integral_value + 2 * v(r(i)) * r(i);
end
integral_value = integral_value * 3 * h / 8;

% Cálculo da velocidade média
vmedia = (2 * vmax / r0^2) * integral_value;

% Exibição dos resultados
fprintf('Velocidade média do fluxo de óleo: %.4f m/s\n', vmedia);
