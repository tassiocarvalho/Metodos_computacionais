function runge_kutta_rk4()
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
    
    % Loop de integração RK4
    for i = 1:n_steps
        k1 = temperature_derivative(T(i), A, rho, C, V, epsilon, sigma, T_room, hc);
        k2 = temperature_derivative(T(i) + (1/2)*h*k1, A, rho, C, V, epsilon, sigma, T_room, hc);
        k3 = temperature_derivative(T(i) + (1/2)*h*k2, A, rho, C, V, epsilon, sigma, T_room, hc);
        k4 = temperature_derivative(T(i) + h*k3, A, rho, C, V, epsilon, sigma, T_room, hc);
        T(i+1) = T(i) + (1/6)*h*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    % Plotando o resultado
    plot(t, T, '-o')
    xlabel('Tempo (s)')
    ylabel('Temperatura (K)')
    title('Resfriamento de uma placa usando RK4')
    grid on
end

function dTdt = temperature_derivative(T, A, rho, C, V, epsilon, sigma, T_room, hc)
    % Derivada da temperatura
    dTdt = (A / (rho * C * V)) * (epsilon * sigma * (T_room^4 - T^4) + hc * (T_room - T));
end
