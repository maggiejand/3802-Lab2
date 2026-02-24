clear; 
clc;
close all;
cd("ASEN3802_HeatConduction_FA25\")
cases{1} = readtable("Steel_22V_203mA");
cases{2} = readtable("Brass_30V_285mA");
cases{3} = readtable("Brass_25V_237mA");
cases{4} = readtable("Aluminum_30V_290mA");
cases{5} = readtable("Aluminum_25V_240mA");
cd()
