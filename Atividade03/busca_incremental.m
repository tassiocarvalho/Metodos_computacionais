function busca_incremental()
    % Definição da função
    f = @(x) sin(10*x) + cos(3*x);

    % Intervalo inicial
    x_start = 3;
    x_end = 6;

    % Números de subintervalos
    subintervals = [5, 10, 50];

    % Processando cada caso de número de subintervalos
    for n = subintervals
        % Calculando o tamanho de cada subintervalo
        h = (x_end - x_start) / n;
        
        % Inicializando variáveis
        x = x_start;
        previous_f = f(x);
        interval_start = x;

        % Imprimindo cabeçalho para clareza
        fprintf('\nSubintervalos para n = %d\n', n);
        fprintf('Intervalo\t\tf(Intervalo_inicio)\tf(Intervalo_final)\tMudança de Sinal\n');
        
        % Iterando sobre cada subintervalo
        for i = 1:n
            x_new = x_start + i * h;
            current_f = f(x_new);
            
            % Verificando mudança de sinal
            if previous_f * current_f < 0
                fprintf('[%.4f, %.4f]\t\t%.4f\t\t\t%.4f\t\t\tSim\n', interval_start, x_new, previous_f, current_f);
            else
                fprintf('[%.4f, %.4f]\t\t%.4f\t\t\t%.4f\t\t\tNão\n', interval_start, x_new, previous_f, current_f);
            end
            
            % Preparando para a próxima iteração
            previous_f = current_f;
            interval_start = x_new;
        end
    end
end
