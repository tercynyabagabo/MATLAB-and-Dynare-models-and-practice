
var 
    gdp 
    cpi 
    % cbr
    % cbr_low
    cbr_low
    shock_gdp
    shock_cpi
    shock_cbr


;
varexo 
    eps_gdp 
    eps_cpi
    eps_cbr
    al0                     % This is similar to the alpha_st in (Bihan, Marx and Matheron, 2021)
    al1
    

;

parameters
    a1
    a2
    b1
    b2
    c1
    % al0
    % al1
    c_gdp
    c_cpi
    d1
    d2
    d3
    tol
    cpibar
;

    load param.mat;

    set_param_value('a1', a1);
    set_param_value('a2', a2);
    set_param_value('b1', b1);
    set_param_value('b2', b2);
    set_param_value('c1', c1);
    set_param_value('d1', d1);
    set_param_value('d2', d2);
    set_param_value('d3', d3);
    set_param_value('c_cpi', c_cpi);
    set_param_value('c_gdp', c_gdp);
    set_param_value('tol', tol);
    set_param_value('cpibar', cpibar);



model;

    [name = 'Aggregate Demand Function']
    gdp = a1*gdp(+1) - (1-a1)*(cbr_low - cpi(+1)) + shock_gdp;

    [name = 'NKPC1']
    cpi = b1*cpi(+1) + (1-b1)*cpi(-1) + b2*gdp - shock_cpi;

    % [name = 'Monetary Policy 1']
    % cbr = c1*c1*cbr(-1) + (1-c1)*(c_cpi*cpi(-1) + c_gdp*gdp) + shock_cbr;

    [name = 'Monetary Policy 3']
    cbr_low = c1*cbr_low(-1) + (1-c1)*(c_cpi*(al0*cpi + (-al0*tol + al1*(cpi + tol))) + c_gdp*gdp) + shock_cbr;

    [name = 'Aggregate Demand Shock']
    shock_gdp = d1*shock_gdp(-1) + eps_gdp;

    [name = 'NKPC Shock']
    shock_cpi = d2*shock_cpi(-1) + eps_cpi;

    [name = 'MP Rule Shock']
    shock_cbr = d3*shock_cbr(-1) + eps_cbr;

end;

initval;
al0 = 0;
al1 = 0;
gdp = 0;
cpi = 0;
cbr_low = 0;

end;

endval;
al0 = 1;
al1 = 0;
gdp = 0;
cpi = 0;
cbr_low = 0;

end;

steady;

resid(1);
check;


shocks;

% var eps_gdp;
% stderr 0.235;

var eps_cpi;
stderr 1;

var al1;
stderr 1;
end;

stoch_simul(irf = 10, nograph, periods = 1000);


resultFileName = 'result_occbin_2.mat';
save(resultFileName, 'oo_');












