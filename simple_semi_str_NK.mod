%---------------------------------------------------------
% Model Name: Simple Semi-Structural NK model of a small closed economy
%
%
%
% Authors: [Tercy Nyabagabo]
% Date: [22/05/2023]
%---------------------------------------------------------


% variables declaration

% endogenous variables

var Y; % Output
var Pi; % Inflation
var r;  % Real interest rate


% exogenous variables

varexo epsilon_Y; % Shock on output
varexo epsilon_Pi; % Shock on inflation
varexo epsilon_r; % Shock on real interest rate
varexo Pi_star; % Inflation target


% declaring parameters

parameters alpha beta lambda rho gamma;


% model equations
model;

Y = alpha*Y(-1) + beta*r + epsilon_Y; % IS equation
Pi = lambda*Pi(-1) + (1-lambda)*Pi + rho*Y + epsilon_Pi; % Phillips Curve
r = gamma*r(-1) + (1-gamma)*(Pi - Pi_star) + epsilon_r; % Policy reaction function

end;


initval;

Y = 0;
r = 0;
Pi = 0;
Pi_star = 0.02;

end;


% specifying parameters

alpha = 0.5;
beta = 0.1;
lambda = 0.7;
rho = 0.6;
gamma = 0.3;


shocks;
var epsilon_Y;
stderr 0.1;

end;

shocks;
var epsilon_r;
stderr 0.4;

end;

shocks;
var epsilon_Pi;
stderr 0.7;

end;


steady;
check;

stoch_simul(irf=20);
