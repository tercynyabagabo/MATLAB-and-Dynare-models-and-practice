%---------------------------------------------------------
% Model Name: Simple DSGE model with financial frictions
%
% Description: A basic dynamic stochastic general equilibrium (DSGE) model
% incorporating financial frictions to study the effects on economic dynamics.
%
% Authors: [Tercy Nyabagabo]
% Date: [18/05/2023]
%---------------------------------------------------------

% declaration of the endogenous variables 
var y c i r k e_y_persistent junk; // Added junk forward-looking variable

% declaration of the exogenous variables 
varexo e_y;  

% declaring parameter values 
parameters alpha delta phi rho; // phi captures the sensitivity of investment to the credit constraint. 
                                // rho is the shock persistence parameter. 
% Model equations 
model; 
y = c + i + e_y_persistent; 
c = (1-alpha)*(y - i);
i = delta*k;
r = alpha*(k(-1))^(alpha-1);
k = (1-delta)*k(-1) + i - phi*(k-k(-1));// financial friction represented here by credit constraint on investment:
// credit constraint: borrowing capacity measured by deviation of current capital stock from its past level. 
e_y_persistent = rho*e_y_persistent(-1) + e_y;
junk = 0.9*junk(+1); // Added dummy forward-looking equation as Dynare doesn't solve scrictly backward-looking models
end; 

% specifying parameters
alpha = 0.33;
delta = 0.1;
phi = 0.5;
rho = 0.9;

initval; 
k = 1; 
e_y_persistent = 0;
c = 0.7;
i = 0.3; 
r = 0.04;
y = c + i; 
junk = 0; // Initial value for the dummy variable
end; 

varobs y c i r k; 

shocks;
var e_y;  
stderr 0.1;
end;

steady; 
stoch_simul(irf=40);
