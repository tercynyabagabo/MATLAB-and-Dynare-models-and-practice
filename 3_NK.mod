%  A simple 3 equation NK-model 

var y, i, pi ; 
varexo  g, eps, g, m; 

parameters  sigma, beta, kappa, theta_y, theta_pi; 

beta=0.50; 
kappa=0.05;
sigma=0.5
theta_y=0.5;
theta_pi=1.5; 

model; 

y= y(+1)-sigma*(i-pi(+1))+g ; 
pi=beta*pi(+1)+kappa*y+eps ; 
i=theta_pi*pi+theta_y*y+m ; 

end; 

initval; 
y=0 ; 
pi=0 ; 
i=0 ; 

end; 

shocks; 
% supply shock
var eps;  
stderr 1.5;
% fiscal policy shock 
var g; 
stderr 2; 
% monetary policy shock 
var m;  
stderr 0.03; 
end; 

steady; 
stoch_simul(irf=20); 


