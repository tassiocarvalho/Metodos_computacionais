funcao = @(t) (320000 / (1 + 31 * exp(-0.09 * t))) - 1.2 * (80000 * exp(-0.05 * t) + 110000);
a = 0;
b = 100;
E = 1e-3;

if funcao(a) * funcao(b) > 0
  error('Não há mudança de sinal!')
end

i = 1;
r0 = 0;

% Inicializações para armazenar os resultados das iterações
iters = [];
raizes = [];
f_raizes = [];
aprox_errors = [];

fprintf('Iteração\ta\t    f(a)\t   b\t\t    f(b)\t Raiz\t\t   f(r)\t\t   Ea\n');

while true
  r = (a + b)/2;
  fr = funcao(r);
  Ea = abs(((r - r0)/r) * 100);

  fprintf('   %d\t    %.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%6f\t%6f\n', ...
                i, a, funcao(a), b, funcao(b), r, funcao(r), Ea);
  
  % Armazena os resultados de cada iteração
  iters(end + 1) = i;
  raizes(end + 1) = r;
  f_raizes(end + 1) = fr;
  aprox_errors(end + 1) = Ea;

  if Ea < E
    raiz = r;
    fprintf('\nO valor de t é: %f\n', raiz);
    break
  end

  i = i + 1;

  if funcao(a) * funcao(r) < 0
    b = r;
  else
    a = r;
  end

  r0 = r;
end

% Gráfico de convergência
plot(iters, raizes, '-o');
xlabel('Iteração');
ylabel('Raiz Aproximada');
title('Convergência da Raiz Aproximada');
grid on;
