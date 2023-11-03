
//Inflation Tolerance Ranges Model 
   // Authors: MANAYUBAHWE & NYABAGABO 
   // Type: NK-Type DSGE model 
   // Package: Dynare
   //Aim: This highly canonical DSGE model of the Rwandan economy is focused -
   // on understanding the impact of monetary policy shocks, especially under different- 
   // inflation targeting regimes that might have asymmetries in the policy response. 
   // The model captures aggregate demand, inflation dynamics (NKPC), 
   //and a specific monetary policy rule under regime switching.


var 
    gdp 
    cpi 
    cbr
    shock_gdp
    shock_cpi
    shock_cbr
    policy_regime
;

varexo 
    eps_gdp 
    eps_cpi
    eps_cbr
    al0
    al1
;

parameters
    a1
    a2
    b1
    b2
    c1
    c_gdp
    c_cpi
    d1
    d2
    d3
    tol
    cpibar
;
a1 = 0.7;
a2 = 1.4;
b1 = 0.91;
b2 = 0.6;
c1 = 0.8;
c_gdp = 0.2;
c_cpi = 1.5;
d1 = 0.07;
d2 = 0.44;
d3 = 0.2;
tol = 1;
cpibar = 5;
 
model;

    [name = 'Aggregate Demand Function']
   // IS 
 gdp = a1*gdp(+1) - a2*(cbr - cpi(+1)) + shock_gdp;
    // PC 
    [name = 'NKPC1']
    cpi = b1*cpi(+1) + (1-b1)*cpi(-1) + b2*gdp + shock_cpi;
      // TR 
    [name = 'Policy Regime Determination']
    policy_regime = (cpi(-1) < cpibar - tol) + (cpi(-1) > cpibar + tol);

    [name = 'Monetary Policy Rule']
    cbr = c1*cbr(-1) + (1-c1)*(c_cpi*(policy_regime*al1*cpi + (1-policy_regime)*al0*cpi) + c_gdp*gdp) + shock_cbr;

    [name = 'Aggregate Demand Shock']
    shock_gdp = d1*shock_gdp(-1) + eps_gdp;

    [name = 'NKPC Shock']
    shock_cpi = d2*shock_cpi(-1) + eps_cpi;

    [name = 'MP Rule Shock']
    shock_cbr = d3*shock_cbr(-1) + eps_cbr;

end;

initval;
al0 = 0;
al1 = 1;
gdp = 0;
cpi = 0;
cbr = 0;
policy_regime = 0;

end;

steady;

resid(1);
check;

shocks;

var eps_gdp;
stderr 0.235;

var eps_cpi;
stderr 1;
 
var eps_cbr;
stderr 1;

end;

stoch_simul(irf = 10, periods = 1000);

