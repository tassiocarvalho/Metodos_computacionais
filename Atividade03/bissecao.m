function raiz = bissecao()
    % Definindo a função
    f = @(x) sin(x) - x^2;

    % Intervalos inicial
    a = 0.5;
    b = 1;

    % Tolerância para o erro relativo aproximado
    tolerancia = 2; % 2%

    % Inicializando variáveis
    fa = f(a);
    fb = f(b);
    if fa * fb > 0
        error('f(a) e f(b) devem ter sinais opostos');
    end

    % Imprime o cabeçalho da tabela uma única vez
    fprintf('%10s%15s%15s%15s%15s%15s%15s%15s\n', ...
            'Iteração', 'Intervalo_a', 'f(a)', 'Intervalo_b', 'f(b)', 'Raiz', 'f(r)', 'E_aprox');

    % Loop principal do método da bissecção
    iteracao = 0;
    r_ant = (a + b) / 2; % inicializa para calcular o erro corretamente
    while true
        iteracao = iteracao + 1;
        r = (a + b) / 2;
        fr = f(r);

        % Calculando erro relativo aproximado
        if iteracao > 1
            erro = abs((r - r_ant) / r) * 100;
        else
            erro = 100; % inicializa com 100 na primeira iteração
        end

        % Imprimindo os resultados atuais da iteração
        fprintf('%10d%15.6f%15.6f%15.6f%15.6f%15.6f%15.6f%15.6f\n', ...
                iteracao, a, fa, b, fb, r, fr, erro);

        % Verifica o critério de parada
        if erro < tolerancia
            raiz = r;
            break;
        end

        % Preparando para a próxima iteração
        if fa * fr < 0
            b = r;
            fb = fr;
        else
            a = r;
            fa = fr;
        end
        r_ant = r; % atualiza a raiz anterior para cálculo do erro
    end
end
