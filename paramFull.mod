

% Main Parameters Calibrations

    a1 = 0.7;
    a2 = 1.4;
    b1 = 0.91;
    b2 = 0.6;
    c1 = 0.8;
    % al0 = 0;    
    c_gdp = 0.2;
    c_cpi = 1.5;
    c_cpi_low = 1.5;
    c_cpi_up = 2;
    d1 = 0.07;
    d2 = 0.44;
    d3 = 0.2;
    tol = 1;
    cpibar = 5;

% Save a mat file

    save('param.mat', "cpibar", "tol", "d3", "d2", "d1", "c_cpi", ...
        "c_gdp", "c1", "b2", "b1", "a2", "a1", '-mat');