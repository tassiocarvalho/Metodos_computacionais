funcao = @(x) 1/(4 * pi * 8.9e-12) * ((2e-5 * 2e-5 * x)/(x.^2 + 0.85^2)^(3/2)) - 1.25;
funcao_derivada = @(x) (1 / (4 * pi * 8.9e-12)) * (2e-5 * 2e-5 * ((x^2 + 0.85^2)^(3/2) - 3 * x^2 * (x^2 + 0.85^2)^(1/2))) / ((x^2 + 0.85^2)^3);
a = 1;
b = 2;
E = 1e-6;

if funcao(a) * funcao(b) > 0
  error('Não há raízes no intervalo dado!');
else
  r = b - (funcao(b) * (a - b))/(funcao(a) - funcao(b));
  i = 1;
  r0 = 0;

  % Inicializações para armazenar os resultados das iterações
  iters = [];
  raizes = [];
  f_raizes = [];
  aprox_errors = [];

  fprintf('Iteração\t a\t    b\t\t    r\t\t  fr\t\tEa\n');

  while true
    Ea = abs(((r - r0)/r) * 100);
    fprintf('\n   %d    %10d%15.6f%15.6f%15.6f%15.6f\n', ...
                i, a, b, r, funcao(r), Ea);
    
    % Armazena os resultados de cada iteração
    iters(end + 1) = i;
    raizes(end + 1) = r;
    f_raizes(end + 1) = funcao(r);
    aprox_errors(end + 1) = Ea;

    r0 = r;

    if Ea < E
      raiz = r;
      break
    end

    if funcao(a) * funcao(r) < 0
        b = r;
    else
        a = r;
    end

    i = i + 1;
    r = b - (funcao(b) * (a - b))/(funcao(a) - funcao(b));
  end

  fprintf('A raiz do intervalo dado é %.6f\n', raiz);
end

% Gráfico de convergência
plot(iters, raizes, '-o');
xlabel('Iteração');
ylabel('Raiz Aproximada');
title('Convergência da Raiz Aproximada');
grid on;
