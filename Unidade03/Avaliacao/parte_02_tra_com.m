% Definição das variáveis
r0 = 0.5; % raio do tubo em metros
n = 8; % valor de n
vmax = 1.5; % velocidade máxima em m/s

% Definição da função de velocidade
v = @(r) vmax * (1 - (r / r0).^(1/n));

% Número de segmentos para integração
num_segments = 1000;

% Intervalo de integração
r = linspace(0, r0, num_segments);
h = r(2) - r(1); % largura de cada segmento

% Aplicação da regra do trapézio composta
integral_value = 0;
for i = 1:num_segments-1
    integral_value = integral_value + (v(r(i)) * r(i) + v(r(i+1)) * r(i+1)) * h / 2;
end

% Cálculo da velocidade média
vmedia = (2 * vmax / r0^2) * integral_value;

% Exibição dos resultados
fprintf('Velocidade média do fluxo de óleo: %.4f m/s\n', vmedia);
