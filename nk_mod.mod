%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A simple 3-equations New Keynesian Model
% By Tercy Nyabagabo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

var y i pi ; 
varexo eps g m pi_t; 

parameters sigma beta kappa theta_y theta_pi; 

beta = 0.05; 
kappa = 0.05;
sigma = 0.5; 
theta_y = 0.2;
theta_pi = 0.8; 

model; 
  y = y(+1) - sigma*(i - pi(+1)) + g ; 
  pi = beta*pi(+1) + kappa*y + eps ; 
  i = theta_pi*(pi - pi_t) + theta_y*y + m ; 
end; 

initval; 
  y = 0 ; 
  pi = 0 ; 
  i = 0; 
  pi_t = 5; % Corrected variable name
end; 

varobs y i pi ; 
shocks; 
  % supply shock
  var eps;  
  stderr 0.3;

  % fiscal policy shock 
  var g; 
  stderr 0.03; 

  % monetary policy shock 
  var m;  
  stderr 0.01; 
end; 

steady; 
stoch_simul(irf=20);
