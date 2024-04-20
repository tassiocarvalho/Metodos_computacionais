function raiz = falsa_posicao()
    % Definição da função cuja raiz estamos buscando
    f = @(x) x^3 - 9*x + 3;

    % Definição dos limites iniciais do intervalo [a, b]
    a = 0;
    b = 1;

    % Avaliação inicial da função nos pontos a e b
    fa = f(a);
    fb = f(b);

    % Verificação inicial: f(a) e f(b) devem ter sinais opostos
    if fa * fb > 0
        error('f(a) e f(b) devem ter sinais opostos para garantir uma raiz entre eles.');
    end

    % Inicialização do contador de iterações
    iteracao = 0;
    
    % Tolerância para o erro relativo aproximado
    tolerancia = 0.005; % 0.05%

    % Imprime o cabeçalho da tabela para visualização dos resultados
    fprintf('%10s%15s%15s%15s%15s%15s%15s%15s\n', ...
            'Iteração', 'Intervalo_a', 'f(a)', 'Intervalo_b', 'f(b)', 'Raiz', 'f(r)', 'E_aprox');

    % Loop principal do método da falsa posição
    while true
        iteracao = iteracao + 1;

        % Calcula a próxima aproximação da raiz usando a fórmula da falsa posição
        r = b - (fb * (b - a)) / (fb - fa);
        fr = f(r);

        % Cálculo do erro relativo aproximado
        if iteracao > 1
            erro = abs((r - r_ant) / r) * 100;
        else
            erro = 100; % Erro inicial alto para garantir a primeira iteração
        end

        % Imprime os resultados da iteração atual
        fprintf('%10d%15.6f%15.6f%15.6f%15.6f%15.6f%15.6f%15.6f\n', ...
                iteracao, a, fa, b, fb, r, fr, erro);

        % Verifica se o erro relativo aproximado é menor que a tolerância especificada
        if erro < tolerancia
            raiz = r;
            break; % Interrompe o loop, pois a raiz foi encontrada com a precisão desejada
        end

        % Atualiza o intervalo [a, b] com base no sinal de f(r)
        if fa * fr < 0
            b = r;
            fb = fr;
        else
            a = r;
            fa = fr;
        end

        % Atualiza a raiz anterior para cálculo do erro na próxima iteração
        r_ant = r;
    end
end
