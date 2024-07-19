% Parâmetros fornecidos
r0 = 0.5; % raio do tubo em metros
n = 8; % valor de n
vmax = 1.5; % velocidade máxima em m/s

% Função a ser integrada
f = @(r) r .* (1 - r/r0).^(1/n);

% Número de subintervalos
N = 1000;

% Implementação da regra do trapézio
h = r0 / N;
x = 0:h:r0;
y = f(x);

% Cálculo da integral pela regra do trapézio
integral_trapezio = (h/2) * (y(1) + 2*sum(y(2:end-1)) + y(end));

% Cálculo da velocidade média
v_media = (2 * vmax / r0^2) * integral_trapezio;

% Exibir o resultado
fprintf('A velocidade média do fluxo de óleo no duto é: %.4f m/s\n', v_media);
