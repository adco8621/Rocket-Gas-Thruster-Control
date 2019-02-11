%% testing my function
%
%This code tests the 1D (soon to be 2D and 3D) motion of a rocket
%given various parameters.
%
%Author: Addison Conzet
%Start Date: 2/1/2019
%Last edit: 2/3/2019

clear;clc;

%Using V-2 specs and some arbitrary numbers
var.m_rf = 2000; %kg
var.g = 9.81; %m/s^2
var.V_e = 2200; %m/s
var.p_e = 2000000; %Pa
var.A_e = .7366; %m
var.p_0 = 101325; %Pa
var.C_d = .3;
var.rho = 1.225; %kg/m^3
var.A_c = 1.65; %m
var.h = [0,0.9,1];
var.mfi = 10000;

massflow = var.A_e*var.V_e; %density of kerosene = 749 kg/m^3




init = [var.mfi,0,0,0,0,0,0]; %fuel mass, initial speed, initial height
tspan = (0:0.005:200);
[t,y] = ode45(@(t,y) Main3D(t,y,massflow,var),tspan,init);

m = y(:,1);
V = y(:,2:4);
r = y(:,5:7);

%plot(t,h)
plot3(r(:,1),r(:,2),r(:,3))
xlabel("x")
ylabel("y")
zlabel("z")

figure
plot(t,V)
legend("x-vel","y-vel","z-vel")
xlabel("t (s)")
ylabel("V (m/s) (check units)")

figure
plot(t,m)
xlabel("t (s)")
ylabel("mass")
