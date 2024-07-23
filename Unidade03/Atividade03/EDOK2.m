function runge_kutta_ralston()
    % Constantes físicas
    rho = 300;  % densidade em kg/m^3
    V = 0.001;  % volume em m^3
    A = 0.25;   % área em m^2
    C = 900;    % calor específico em J/kgK
    hc = 30;    % coeficiente de transferência de calor em J/m^2K
    epsilon = 0.8; % emissividade
    sigma = 5.67e-8; % constante de Boltzmann em W/m^2K^4
    T_room = 297; % temperatura da sala em K
    
    % Condição inicial
    T0 = 473; % temperatura inicial em K
    
    % Parâmetros de integração
    h = 1; % passo de integração em segundos
    t_final = 180; % tempo final em segundos
    
    % Número de passos
    n_steps = t_final / h;
    
    % Vetores de tempo e temperatura
    t = 0:h:t_final;
    T = zeros(1, n_steps+1);
    T(1) = T0;
    
    % Loop de integração RK2 Ralston
    for i = 1:n_steps
        k1 = temperature_derivative(T(i), A, rho, C, V, epsilon, sigma, T_room, hc);
        k2 = temperature_derivative(T(i) + (2/3)*h*k1, A, rho, C, V, epsilon, sigma, T_room, hc);
        T(i+1) = T(i) + h * (1/4*k1 + 3/4*k2);
    end
    
    % Plotando o resultado
    plot(t, T, '-o')
    xlabel('Tempo (s)')
    ylabel('Temperatura (K)')
    title('Resfriamento de uma placa usando RK2 Ralston')
    grid on
end

function dTdt = temperature_derivative(T, A, rho, C, V, epsilon, sigma, T_room, hc)
    % Derivada da temperatura
    dTdt = (A / (rho * C * V)) * (epsilon * sigma * (T_room^4 - T^4) + hc * (T_room - T));
end
