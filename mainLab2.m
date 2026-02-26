clc;
clear;
close all;

%% Variable Declarations
cases = {
    'Aluminum_25V_240mA'
    'Aluminum_30V_290mA'
    'Brass_25V_237mA'
    'Brass_30V_285mA'
    'Steel_22V_203mA'
    };
Case = {'Aluminum 25V 240mA'
    'Aluminum 30V 290mA'
    'Brass 25V 237mA'
    'Brass 30V 285mA'
    'Steel 22V 203mA'};
P = zeros(5,2);
Tfits =zeros(5,8);

%% Reading in Data
for i = 1:5
    filename= string(cases{i})
    A =readmatrix(filename);


% time = A(:,1);
% CH1 = A(:,2);
% CH2 = A(:,3);
% CH3 = A(:,4);
% CH4 = A(:,5);
% CH5 = A(:,6);
% CH6 = A(:,7);
% CH7 = A(:,8);
% CH8 = A(:,9);

T0 = A(1,2:9)

%% Polyfit
x1 = convlength(1 + 3/8, 'in', 'm');
x2 = x1 +0.0127;
x3 = x2 + 0.0127;
x4 = x3 + 0.0127;
x5 = x4 + 0.0127;
x6 = x5 +0.0127;
x7 = x6 +0.0127;
x8 = x7 +0.0127;

X =[x1,x2,x3,x4,x5,x6,x7,x8];

p = polyfit(X,T0,1);
P(i,:) = p;
Tfit = polyval(p,X);
Tfits(i,:) = Tfit;

figure(i);

hold on;
plot(X,Tfit,'r','LineWidth', 1.5,'DisplayName','Linear Fit');
plot(X,T0,'b','LineWidth', 1.5, 'DisplayName', 'Raw Data');
grid on;
legend;
xlabel('Postion (meters)');
ylabel('Temperature (C)')
title(string(Case{i}))
hold off;
i = i+1;
end
display(P)






