%% Equations of Motion for a generic rocket
%
%This code represents the 1D (soon to be 2D and 3D) motion of a rocket
%given various parameters.
%
%Author: Addison Conzet
%Start Date: 1/31/2019
%last edit: 2/3/2019

function dydt = Main(t,y,massflow,put_necessary_variables_here)

%% Variables and Initial Conditions

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

%y-values
m_fuel = y(1); %mass of fuel
V = y(2); %Velocity
h = y(3); %height

%% Flight Phase 1 (Engine on)

if m_fuel > 0
    
    %mass flow in flight
    mdot = -massflow;
    
    %Thrust (T)
    T = -mdot*V_e+A_e*(p_e-p_0);
    
    %Drag (D), velocity (V)
    D = (C_d*rho*V^2*A_c)/2;

    
    
    %% Flight Phase 2 (Engine off) 
else
    
    T = 0;
    mdot = 0;
    D = (C_d*rho*V^2*A_c)/2;
    
end

%% Calculating Motion

m_r = m_rf + m_fuel;
F = T - D - m_r*g;
dV_dt = F/m_r;
dh_dt = V;


dydt = [mdot;dV_dt;dh_dt];










