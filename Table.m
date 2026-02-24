cases = {
    'Aluminum_25V_240mA'
    'Aluminum_30V_290mA'
    'Brass_25V_237mA'
    'Brass_30V_285mA'
    'Steel_22V_203mA'
    };

T0   = [23.1; 24.0; 22.5; 23.8; 21.9];
Hexp = [105; 130; 98; 120; 85];
Han  = [110; 128; 100; 118; 90];

results = generateHeatTable(cases, T0, Hexp, Han);

disp(results)

function resultsTable = generateHeatTable(cases, T0, Hexp, Han)

    T0   = T0(:);
    Hexp = Hexp(:);
    Han  = Han(:);

    % Create table
    resultsTable = table(cases(:), T0, Hexp, Han, ...
        'VariableNames', {'Case', 'T0_C', 'Hexp_C_per_m', 'Han_C_per_m'});

end