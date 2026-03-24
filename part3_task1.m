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

Tests = ["Steel 22V and 203mA"; "Brass 30V and 285mA"; ...
         "Brass 25V and 237mA"; "Aluminum 30V and 290mA"; ...
         "Aluminum 25V and 240mA"];

distance = [0.034925, 0.047625, 0.060325, 0.073025, ...
            0.085725, 0.098425, 0.111125, 0.123825];

H_analytical = [286.6; 150.5; 105.6; 79.2; 55.4];
T0 = [15.1074; 16.7804; 16.5417; 17.2399; 17];

alpha = [4.050e-6; 3.563e-5; 3.563e-5; 4.819e-5; 4.819e-5];

L = 0.148825;  
N_terms = 10;

ana_color = [0 0.4470 0.7410];
exp_color = [0.8500 0.3250 0.0980];

for i = 1:5
    t = cases{i}{:,1};
    H = H_analytical(i);

    % ---- Sweep alpha ----
    scale = linspace(0.5, 1.5, 40);
    rms_vals = zeros(size(scale));

    for s = 1:length(scale)
        alpha_test = alpha(i) * scale(s);

        total_error = 0;
        count = 0;

        for tc = 1:8
            x = distance(tc);

            series_sum = zeros(size(t));

            for n = 0:N_terms
                series_sum = series_sum + (-8*H*(-1)^n * L) .* ...
                    sin((2*n+1)*pi/(2*L) * x) .* ...
                    exp(-alpha_test*((2*n+1)*pi/(2*L))^2 .* t) ./ ...
                    (pi^2*(2*n+1)^2);
            end

            u = T0(i) + H*x + series_sum;
            exp_data = cases{i}{:,tc+1};

            total_error = total_error + sum((exp_data - u).^2);
            count = count + length(t);
        end

        rms_vals(s) = sqrt(total_error / count);
    end

    %Best alpha
    [~, idx] = min(rms_vals);
    alpha_best = alpha(i) * scale(idx);

    fprintf("Test %d Best alpha = %.4e\n", i, alpha_best);

    % Plot RMS vs alpha 
    figure;
    plot(alpha(i)*scale, rms_vals, 'LineWidth', 2)
    grid on
    xlabel('\alpha')
    ylabel('RMS Error')
    title("RMS vs Alpha - " + Tests(i))

    %  Final Model III Plot
    figure;
    hold on
    grid on
    title("Model III - " + Tests(i))
    xlabel("Time (s)")
    ylabel("Temperature (C)")

    for tc = 1:8
        x = distance(tc);

        series_sum = zeros(size(t));

        for n = 0:N_terms
            series_sum = series_sum + (-8*H*(-1)^n * L) .* ...
                sin((2*n+1)*pi/(2*L) * x) .* ...
                exp(-alpha_best*((2*n+1)*pi/(2*L))^2 .* t) ./ ...
                (pi^2*(2*n+1)^2);
        end

        u = T0(i) + H*x + series_sum;

        % Experimental
        plot(t, cases{i}{:,tc+1}, '-', ...
            'Color', exp_color, 'LineWidth', 1.2)

        % Model III
        plot(t, u, '--', ...
            'Color', ana_color, 'LineWidth', 2)
    end

    legend("Experimental","Model III","Location","best")
    hold off
end