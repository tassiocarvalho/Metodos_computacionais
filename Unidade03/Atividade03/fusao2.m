function compare_runge_kutta_methods()
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
    
    % Vetores de tempo
    t = 0:h:t_final;
    
    % Resultados dos métodos
    T_RK2 = runge_kutta_rk2(T0, n_steps, h, A, rho, C, V, epsilon, sigma, T_room, hc);
    T_RK3 = runge_kutta_rk3(T0, n_steps, h, A, rho, C, V, epsilon, sigma, T_room, hc);
    T_RK4 = runge_kutta_rk4(T0, n_steps, h, A, rho, C, V, epsilon, sigma, T_room, hc);
    
    % Solução de referência usando RK4 com passo menor
    h_ref = 0.1; % passo de integração menor para maior precisão
    n_steps_ref = t_final / h_ref;
    T_ref = runge_kutta_rk4(T0, n_steps_ref, h_ref, A, rho, C, V, epsilon, sigma, T_room, hc);
    t_ref = 0:h_ref:t_final;
    T_ref_interp = interp1(t_ref, T_ref, t); % Interpolando para comparar
    
    % Exibindo os resultados finais no terminal
    fprintf('Temperatura final usando RK2: %.2f K\n', T_RK2(end));
    fprintf('Temperatura final usando RK3: %.2f K\n', T_RK3(end));
    fprintf('Temperatura final usando RK4: %.2f K\n', T_RK4(end));
    fprintf('Temperatura final de referência: %.2f K\n', T_ref(end));
    
    % Calculando e exibindo os erros absolutos finais
    error_RK2 = abs(T_RK2 - T_ref_interp);
    error_RK3 = abs(T_RK3 - T_ref_interp);
    error_RK4 = abs(T_RK4 - T_ref_interp);
    fprintf('Erro final usando RK2: %.2e K\n', error_RK2(end));
    fprintf('Erro final usando RK3: %.2e K\n', error_RK3(end));
    fprintf('Erro final usando RK4: %.2e K\n', error_RK4(end));
    
    % Plotando os resultados
    plot(t, T_RK2, '-o', 'DisplayName', 'RK2')
    hold on
    plot(t, T_RK3, '-x', 'DisplayName', 'RK3')
    plot(t, T_RK4, '-s', 'DisplayName', 'RK4')
    plot(t, T_ref_interp, '-.', 'DisplayName', 'Referência')
    hold off
    
    xlabel('Tempo (s)')
    ylabel('Temperatura (K)')
    title('Comparação dos Métodos RK2, RK3 e RK4')
    legend('show')
    grid on
end

function T = runge_kutta_rk2(T0, n_steps, h, A, rho, C, V, epsilon, sigma, T_room, hc)
    T = zeros(1, n_steps+1);
    T(1) = T0;
    for i = 1:n_steps
        k1 = temperature_derivative(T(i), A, rho, C, V, epsilon, sigma, T_room, hc);
        k2 = temperature_derivative(T(i) + (2/3)*h*k1, A, rho, C, V, epsilon, sigma, T_room, hc);
        T(i+1) = T(i) + h * (1/4*k1 + 3/4*k2);
    end
end

function T = runge_kutta_rk3(T0, n_steps, h, A, rho, C, V, epsilon, sigma, T_room, hc)
    T = zeros(1, n_steps+1);
    T(1) = T0;
    for i = 1:n_steps
        k1 = temperature_derivative(T(i), A, rho, C, V, epsilon, sigma, T_room, hc);
        k2 = temperature_derivative(T(i) + (1/2)*h*k1, A, rho, C, V, epsilon, sigma, T_room, hc);
        k3 = temperature_derivative(T(i) - h*k1 + 2*h*k2, A, rho, C, V, epsilon, sigma, T_room, hc);
        T(i+1) = T(i) + (1/6)*h*(k1 + 4*k2 + k3);
    end
end

function T = runge_kutta_rk4(T0, n_steps, h, A, rho, C, V, epsilon, sigma, T_room, hc)
    T = zeros(1, n_steps+1);
    T(1) = T0;
    for i = 1:n_steps
        k1 = temperature_derivative(T(i), A, rho, C, V, epsilon, sigma, T_room, hc);
        k2 = temperature_derivative(T(i) + (1/2)*h*k1, A, rho, C, V, epsilon, sigma, T_room, hc);
        k3 = temperature_derivative(T(i) + (1/2)*h*k2, A, rho, C, V, epsilon, sigma, T_room, hc);
        k4 = temperature_derivative(T(i) + h*k3, A, rho, C, V, epsilon, sigma, T_room, hc);
        T(i+1) = T(i) + (1/6)*h*(k1 + 2*k2 + 2*k3 + k4);
    end
end

function dTdt = temperature_derivative(T, A, rho, C, V, epsilon, sigma, T_room, hc)
    dTdt = (A / (rho * C * V)) * (epsilon * sigma * (T_room^4 - T^4) + hc * (T_room - T));
end
