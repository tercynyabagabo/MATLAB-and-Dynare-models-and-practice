%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A simple RBC Model 
% By Tercy Nyabagabo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set parameters 
alpha=0.36 ; % capital share
beta=0.99; % discount factor
delta=0.025; % depreciation rate
rho=0.95; % persistence of technology shock 
sigma=0.02; % SD of technology shock
psi=1; % parameter of labor disutility
theta=2; % Firsch elasticity of labor supply

% steady state values
A_bar=1; % steady state technology
K_bar = (alpha*A_bar/(1/beta - 1 + delta))^(1/(1-alpha)); % Steady state capital
L_bar = (1-alpha)*A_bar/(psi*(1+theta)); % Steady state labor

% model equations 
c_t = @(k_t, l_t) (1 - alpha)*A_bar*k_t^alpha*l_t^(1 - alpha) - delta*k_t;  % consumption 
l_t = @(k_t) (1 - alpha)*A_bar*alpha*k_t^alpha/((1+theta)*psi);             % leisure

% solving the model
num_periods = 40;
k_t = zeros(1, num_periods);
k_t(1) = K_bar; % Initial capital level at steady state
    
for t = 1:num_periods-1
    k_t(t+1) = (1 - delta)*k_t(t) + A_bar*alpha*k_t(t)^alpha*l_t(k_t(t))^(1 - alpha);
end

% Plotting
t = 1:num_periods;
figure;
subplot(2, 1, 1);
plot(t, k_t, 'b', 'LineWidth', 2);
title('Capital Dynamics');
xlabel('Time');
ylabel('Capital');

subplot(2, 1, 2);
plot(t, l_t(k_t), 'r', 'LineWidth', 2);
title('Labor Dynamics');
xlabel('Time');
ylabel('Labor');

    

