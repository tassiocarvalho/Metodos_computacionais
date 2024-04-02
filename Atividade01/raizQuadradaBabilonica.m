function [raiz, erro] = raizQuadradaBabilonica()
    % Solicita ao usuário o número a
    a = input('Digite o valor de a: ');
    epsilon = 1e-4; % Define epsilon
    
    % Checa se o número é negativo
    if a < 0
        raiz = sqrt(-a) * 1i; % Calcula a raiz quadrada imaginária
        erro = 0; % Não há erro no cálculo de raízes imaginárias
        fprintf('Raiz: %f + %fi, Erro: %f\n', real(raiz), imag(raiz), erro); % Imprime a raiz e o erro corretamente
        return;
    elseif a == 0
        raiz = 0; % A raiz quadrada de 0 é 0
        erro = 0; % Não há erro
        fprintf('Raiz: %f, Erro: %f\n', raiz, erro); % Imprime a raiz e o erro
        return;
    end
    
    % Inicializa x com o próprio número a
    x_velho = a;
    x_novo = (x_velho + a / x_velho) / 2;
    
    while true
        erro = abs(x_novo - x_velho) / x_novo;
        
        if erro <= epsilon
            break;
        end
        
        x_velho = x_novo;
        x_novo = (x_velho + a / x_velho) / 2;
    end
    
    raiz = x_novo;
    fprintf('Raiz: %f, Erro: %f\n', raiz, erro); % Imprime a raiz e o erro
end
