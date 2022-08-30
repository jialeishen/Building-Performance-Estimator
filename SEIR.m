% SEIR model
% Jialei Shen
% 08/06/2020

clc
clear
close all

%% parameters
N0 = 10e6; % 10 million initial population
alpha = 0.006; % fatality rate, 0.006/day
beta = 0.75; % disease transmission probability per contact*contact number per unit time, 0.75/day
gamma = 1./8; % recovery rate, 1/8/day --> reciprocal: infectious period, 8day
epsilon = 1./3; % infection rate, 1/3/day --> reciprocal: incubation period, 3day
mu = 1./(83.*365); % natural death rate, 1/(83*365)/day --> reciprocal: normal life expectancy, 83years
R0 = beta.*epsilon./((epsilon+mu).*(gamma+alpha+mu)); % reproduction ratio, 5.72 here (>1)
% change R0 <-- change beta
% R0 = 1;
% beta = (gamma+alpha).*R0;

dt = 0.01; % time step, 0.01day
T = 80; % total simulated time, 80day
n = T/dt; % total simulation steps
S = [];
E = [];
I = [];
R = [];
N = [];
D = [];
Dd = [];
t = [];
E(1) = 20e3;
I(1) = 1;
R(1) = 0;
S(1) = N0 - E(1) - I(1);
N(1) = N0;
D(1) = 0;
Lambda(1) = mu.*N(1);
t(1) = 0;

%% modeling
for i = 2:n
    Sd = Lambda(i-1) - mu.*S(i-1) - beta.*S(i-1).*I(i-1)./N(i-1);
    Ed = beta.*S(i-1).*I(i-1)./N(i-1) - (mu+epsilon).*E(i-1);
    Id = epsilon.*E(i-1) - (gamma+mu+alpha).*I(i-1);
    Rd = gamma.*I(i-1) - mu.*R(i-1);
    Dd(i-1) = -1.*(Sd+Ed+Id+Rd);
    
    S(i) = S(i-1) + dt.*Sd;
    E(i) = E(i-1) + dt.*Ed;
    I(i) = I(i-1) + dt.*Id;
    R(i) = R(i-1) + dt.*Rd;
    N(i) = S(i) + E(i) + I(i) + R(i);
    Lambda(i) = mu.*N(i);
    D(i) = N0 - N(i);
    t(i) = t(i-1) + dt;
end

IFR = D./(R+D);

%% Results
figure;
plot(t,S)
hold on
plot(t,E)
plot(t,I)
plot(t,R)
hold off
legend('S','E','I','R')
xlabel('Time [days]')
ylabel('Population [#]')

figure;
Dd(n) = Dd(n-1);
plot(t,Dd)
xlabel('Time [days]')
ylabel('Dead individuals per day [#]')

figure;
plot(t,D)
xlabel('Time [days]')
ylabel('Total dead individuals [#]')

figure;
plot(t,IFR.*100)
xlabel('Time [days]')
ylabel('IFR [%]')