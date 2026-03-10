clear;
clc;
close all;

cd("ASEN3802_HeatConduction_FA25\")
cases{1} = readtable("Steel_22V_203mA");
cases{2} = readtable("Brass_30V_285mA");
cases{3} = readtable("Brass_25V_237mA");
cases{4} = readtable("Aluminum_30V_290mA");
cases{5} = readtable("Aluminum_25V_240mA");
cd();

Tests = ["Steel 22V and 203mA"; "Brass 30V and 285mA"; "Brass 25V and 237mA"; ...
         "Aluminum 30V and 290mA"; "Aluminum 25V and 240mA"];

distance = [0.041275, 0.05375, 0.066675, 0.079375, 0.092075, 0.10795, 0.12065, 0.13335];

H_analytical = [544.1; 146.7; 101.7; 132.1; 91.1];
T0           = [13.95; 15.78; 15.81; 16.98; 16.91];
alpha        = [0; 0; 0; 0; 0];  % insert alpha values here (m^2/s)
L            = 0;                 % insert rod length here (m)
N_terms      = 50;

for i = 1:5
    t = cases{i}{:,1};

    figure(i)
    hold on;
    grid on;
    title("Model IA - " + Tests(i));
    xlabel("Time (s)")
    ylabel("Temperature (C)")

    exp_plots = gobjects(8,1);
    ana_plots = gobjects(8,1);

    for tc = 1:8
        x = distance(tc);

        T_ss = H_analytical(i) * x + T0(i);

        u = zeros(size(t)); % insert Model IA u(x,t) formula here using T_ss, x, t, alpha(i), L, N_terms

        exp_plots(tc) = plot(t, cases{i}{:, tc+1}, '-', 'LineWidth', 1.5);
        ana_plots(tc) = plot(t, u, '--', 'Color', get(exp_plots(tc), 'Color'), 'LineWidth', 2);
    end

    legend([exp_plots; ana_plots], ...
        {'TC1 Exp','TC2 Exp','TC3 Exp','TC4 Exp','TC5 Exp','TC6 Exp','TC7 Exp','TC8 Exp', ...
         'TC1 Analytical','TC2 Analytical','TC3 Analytical','TC4 Analytical', ...
         'TC5 Analytical','TC6 Analytical','TC7 Analytical','TC8 Analytical'}, ...
        'Location', 'best');

    hold off;
end