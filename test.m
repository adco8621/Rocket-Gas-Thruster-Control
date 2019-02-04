%% testing my function
%
%This code tests the 1D (soon to be 2D and 3D) motion of a rocket
%given various parameters.
%
%Author: Addison Conzet
%Start Date: 2/1/2019
%Last edit: 2/3/2019



%starting conditions
global m_rf %rocket fuselage mass
global g %gravity

%thrust variables
global V_e %Exit velocity of propellant for thrust calculations
global p_e %Exit pressure of propellant for thrust calculations
global A_e %Exit area of propellant
global p_0 %Atmospheric Pressure

%drag variables
global C_d %Drag Coefficient
global rho %atmospheric density
global A_c % cross-sectional area (top down)



%Using V-2 specs and some arbitrary numbers
m_rf = 2000; %kg
g = 9.81; %m/s^2
V_e = 2200; %m/s
p_e = 2000000; %Pa
A_e = .7366; %m
p_0 = 101325; %Pa
C_d = .3;
rho = 1.225; %kg/m^3
A_c = 1.65; %m

massflow = 749*A_e*V_e; %density of kerosene = 749 kg/m^3




init = [10000,0,0]; %fuel mass, initial speed, initial height
tspan = (0:0.005:78.5);
[t,y] = ode45(@(t,y) Main(t,y,massflow),tspan,init);

V = y(:,2);
h = y(:,3);

plot(t,h)
xlabel("t (s)")
ylabel("height (m?) (need to make sure all my units check out)")

figure
plot(t,V)
xlabel("t (s)")
ylabel("V (m/s) (check units)")
