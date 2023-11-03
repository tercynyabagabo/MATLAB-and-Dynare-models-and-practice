%% HANK Model of Central Bank Communication

clear all; clc;

%% Model Parameters

% Household Parameters
gamma_a = 0.8;      % Marginal propensity to consume for attentive households
gamma_n = 0.2;      % Marginal propensity to consume for non-attentive households
phi_a = 0.5;        % Marginal disutility of labor for attentive households
phi_n = 0.5;        % Marginal disutility of labor for non-attentive households
eta_a = 1;          % Labor elasticity for attentive households
eta_n = 1;          % Labor elasticity for non-attentive households

% Firm Parameters
epsilon_w = 11;     % Elasticity of wages
epsilon_p = 6;      % Elasticity of prices
mu_a = 1.5;         % Markup for attentive firms
mu_n = 2.5;         % Markup for non-attentive firms

% Central Bank Parameters
rho_i = 0.8;        % Persistence of the interest rate rule
bar_pi = 2;         % Inflation target
phi_pi = 1.5;       % Coefficient on inflation deviation
phi_y = 0.2;        % Coefficient on output deviation
epsilon_i = 0.1;    % Monetary policy shock

% Other Parameters
beta = 0.99;        % Discount factor
alpha = 0.3;        % Production function parameter
delta = 0.1;        % Capital depreciation rate

% Steady State Values
K_ss = ((1/beta - 1 + delta)/alpha)^(1/(alpha-1));
Y_ss = K_ss^alpha;
N_ss = Y_ss/(1/alpha * (W_ss/P_ss));
W_ss = (1-alpha)*Y_ss/N_ss;
R_ss = 1/beta;
P_ss = 1;

%% Model Equations

% Attentive Households
C_a = @(Y, T, C) gamma_a*(Y - T) + (1 - gamma_a)*C;
N_a = @(W, P, Y) (1 - phi_a) * (W/P)^(-eta_a) * Y;
u_C_a = @(C, N) C/N;
u_N_a = @(N) phi_a * (N/N_ss - 1).^2;

% Non-attentive Households
C_n = @(Y, T, C) gamma_n*(Y - T) + (1 - gamma_n)*C;
N_n = @(W, P, Y) (1 - phi_n) * (W/P)^(-eta_n) * Y;
u_C_n = @(C, N) C/N;
u_N_n = @(N) phi_n * (N/N_ss - 1).^2;

% Attentive Firms
Y_a = @(A, N) A * N;
theta_a = @(mu_a) 1/(1 + mu_a);
W_a = @(theta_a, P, Y) (theta_a/epsilon_w) * P * Y;
MC_a = @(W_a, A) W_a/A;
theta_p = @(mu_p) 1/(1 + mu_p);
P_a = @(theta_p, epsilon_p, MC) (theta_p/epsilon_p) * MC + (1 - theta_p/epsilon_p);

% Non-attentive firms
Yn = An.*Nn;
thetan = 1./(1+mun);
Wn = (thetan/epsilon_w)*P.*Yn;
MCn = Wn./An;
thetap = 1./(1+mup);
P(2:T) = (thetap/epsilon_p)*MCn(2:T) + (1-thetap/epsilon_p)*P(1:T-1);

% Central bank
i(2:T) = rho_i*i(1:T-1) + (1-rho_i)*(pi(1:T-1) + phi_pi*pi(1:T-1) + phi_y*(Y(1:T-1)-Ystar) + epsilon_i);

