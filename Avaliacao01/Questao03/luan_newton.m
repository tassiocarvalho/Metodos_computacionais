funcao = @(x) (1 / (4 * pi * 8.9e-12)) * (2e-5 * 2e-5 * x) / ((x^2 + 0.85^2)^(3/2)) - 1.25;
funcao_derivada = @(x) (1 / (4 * pi * 8.9e-12)) * (2e-5 * 2e-5 * ((x^2 + 0.85^2)^(3/2) - 3 * x^2 * (x^2 + 0.85^2)^(1/2))) / ((x^2 + 0.85^2)^3);
ea = 0;
ev = 0;
x0 = 1;
tolerancia = 1e-6;
n = 50;

x = x0;

% Inicializações para armazenar os resultados das iterações
iters = [];
raizes = [];
f_raizes = [];
aprox_errors = [];
true_errors = [];

fprintf('Iteração\tx\t    f(x)\tErro aproximado\t   Erro verdadeiro\n');

for i = 1:n
  xprox = x - (funcao(x)/funcao_derivada(x));
  if i ~= 1
    ea = abs((xprox - x)/xprox) * 100;
  else
    ea = 100;
  end

  ev = abs(1.291280 - x);
  fprintf('   %d\t    %f\t  %f\t  %f\t     %f\n', i, x, funcao(x), ea, ev);
  
  % Armazena os resultados de cada iteração
  iters(end + 1) = i;
  raizes(end + 1) = x;
  f_raizes(end + 1) = funcao(x);
  aprox_errors(end + 1) = ea;
  true_errors(end + 1) = ev;

  if ea < tolerancia
    fprintf('O valor de x é: %f\n', x);
    break;
  end

  x = xprox;
end

% Gráfico de convergência
plot(iters, raizes, '-o');
xlabel('Iteração');
ylabel('Raiz Aproximada');
title('Convergência da Raiz Aproximada');
grid on;
