clear;
clc;
close all;

cd("ASEN3802_HeatConduction_FA25\")
cases{1} = readtable("Steel_22V_203mA");
cases{2} = readtable("Brass_30V_285mA");
cases{3} = readtable("Brass_25V_237mA");
cases{4} = readtable("Aluminum_30V_290mA");
cases{5} = readtable("Aluminum_25V_240mA");
cd('..');

Tests = ["Steel 22V and 203mA"; "Brass 30V and 285mA"; "Brass 25V and 237mA"; ...
         "Aluminum 30V and 290mA"; "Aluminum 25V and 240mA"];

distance = [0.034925, 0.047625, 0.060325, 0.073025, 0.085725, 0.098425, 0.111125, 0.123825];

H_analytical = [544.1; 146.7; 101.7; 132.1; 91.1];
T0           = [15.107440476190478; 16.780357142857130; 16.541666666666664;17.239880952380950; 17];

alpha = [4.050e-6; 3.563e-5; 3.563e-5; 4.819e-5; 4.819e-5];

L = 0.148825;  
N_terms = 50;

exp_color = [0 0.4470 0.7410];   % MATLAB blue
ana_color = [0.8500 0.3250 0.0980]; % MATLAB red

for i = 1:5
    t = cases{i}{:,1};

    figure(i)
    hold on
    grid on
    title("Model IA - " + Tests(i))
    xlabel("Time (s)")
    ylabel("Temperature (C)")

    for tc = 1:8
        x = distance(tc);
        H = H_analytical(i);

        series_sum = zeros(size(t));

        for n = 0:N_terms
            series_sum = series_sum + (-8*H*(-1)^n * L) .* ...
                sin((2*n+1)*pi/(2*L) * x) .* ...
                exp(-alpha(i)*((2*n+1)*pi/(2*L))^2 .* t) ./ ...
                (pi^2*(2*n+1)^2);
        end

        u = T0(i) + H*x + series_sum;

        % Experimental
        plot(t, cases{i}{:,tc+1}, '-', ...
            'Color', exp_color, 'LineWidth', 1.5)

        % Analytical
        plot(t, u, '--', ...
            'Color', ana_color, 'LineWidth', 2)
    end

    legend("Experimental","Analytical","Location","best")

    hold off
end
