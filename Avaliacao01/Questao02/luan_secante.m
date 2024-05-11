funcao = @(t) (320000 / (1 + 31 * exp(-0.09 * t))) - 1.2 * (80000 * exp(-0.05 * t) + 110000);
ea = 100;
ev = 0;
x1 = 0;
x2 = 100;
tolerancia = 1e-2;
n = 50;

% Inicializações para armazenar os resultados das iterações
iters = [];
raizes = [];
f_raizes = [];
aprox_errors = [];

fprintf('Iteração\tx1\t   x2\t\t  raiz\t  \t  f(raiz)\tErro aproximado\t    Erro verdadeiro\n');

for i = 1:n
  x3 = (x1*funcao(x2) - x2*funcao(x1)) / (funcao(x2) - funcao(x1));
  ev = abs(36.421079 - x3);
  fprintf('   %d\t   %f\t%f\t%f\t%f\t  %f\t\t%f\n', i, x1, x2, x3, funcao(x3), ea, ev);
  
  % Armazena os resultados de cada iteração
  iters(end + 1) = i;
  raizes(end + 1) = x3;
  f_raizes(end + 1) = funcao(x3);
  aprox_errors(end + 1) = ea;

  ea = abs((x3 - x2)/x3) * 100;

  if ea < tolerancia
    fprintf('\nO valor de t é: %f\n', x3)
    break;
  end

  x1 = x2;
  x2 = x3;
end

% Gráfico de convergência
plot(iters, raizes, '-o');
xlabel('Iteração');
ylabel('Raiz Aproximada');
title('Convergência da Raiz Aproximada');
grid on;
