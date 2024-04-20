function raiz = bissecao()
    % Definição da função cuja raiz estamos buscando.
    % f(x) = sin(x) - x^2
    f = @(x) sin(x) - x^2;

    % Definição dos limites iniciais do intervalo [a, b]
    a = 0.5;
    b = 1;

    % Definição da tolerância para o erro relativo aproximado (em porcentagem).
    tolerancia = 2; % 2%

    % Avaliação da função nos pontos a e b
    fa = f(a);
    fb = f(b);

    % Verificação inicial: f(a) e f(b) devem ter sinais opostos.
    % Se não tiverem, não é possível garantir uma raiz no intervalo [a, b] pelo Teorema do Valor Intermediário.
    if fa * fb > 0
        error('f(a) e f(b) devem ter sinais opostos');
    end

    % Imprime o cabeçalho da tabela para visualização dos resultados.
    fprintf('%10s%15s%15s%15s%15s%15s%15s%15s\n', ...
            'Iteração', 'Intervalo_a', 'f(a)', 'Intervalo_b', 'f(b)', 'Raiz', 'f(r)', 'E_aprox');

    % Inicialização do contador de iterações e do ponto médio anterior.
    iteracao = 0;
    r_ant = (a + b) / 2;

    % Loop principal do método da bissecção.
    while true
        % Incrementa o contador de iterações.
        iteracao = iteracao + 1;

        % Calcula o ponto médio do intervalo.
        r = (a + b) / 2;
        fr = f(r);

        % Cálculo do erro relativo aproximado se não for a primeira iteração.
        if iteracao > 1
            erro = abs((r - r_ant) / r) * 100;
        else
            erro = 100; % Erro inicial alto para garantir a primeira iteração.
        end

        % Imprime os resultados da iteração atual.
        fprintf('%10d%15.6f%15.6f%15.6f%15.6f%15.6f%15.6f%15.6f\n', ...
                iteracao, a, fa, b, fb, r, fr, erro);

        % Verifica se o erro relativo aproximado é menor que a tolerância especificada.
        % Se for, o ponto médio r é considerado a raiz da função no intervalo dado.
        if erro < tolerancia
            raiz = r;
            break; % Interrompe o loop, pois a raiz foi encontrada com a precisão desejada.
        end

        % Atualiza o intervalo [a, b] com base no sinal de f(r).
        % Isso é feito para garantir que a raiz esteja sempre dentro do intervalo.
        if fa * fr < 0
            b = r;
            fb = fr;
        else
            a = r;
            fa = fr;
        end

        % Atualiza o ponto médio anterior para cálculo do erro na próxima iteração.
        r_ant = r;
    end
end
