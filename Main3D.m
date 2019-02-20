%% Equations of Motion for a generic rocket
%
%This code represents the 1D (soon to be 2D and 3D) motion of a rocket
%given various parameters.
%
%Author: Addison Conzet
%Start Date: 1/31/2019
%last edit: 2/3/2019

function dydt = Main3D(t,y,massflow,var)

%% Variables and Initial Conditions

%y-values
m_fuel = y(1); %mass of fuel
V = y(2:4); %Velocity
r = y(5:7); %position


%% Flight Phase 1 (Engine on)

if m_fuel == var.mfi;
    
    h = var.h/norm(var.h);
    %mass flow in flight
    mdot = -massflow;
    
    %Thrust (T)
    T = -mdot.*var.V_e+var.A_e*(var.p_e-var.p_0);
    T = T*h;
    
    %Drag (D), velocity (V)
    D = ((var.C_d*var.rho*V.^2*var.A_c)./2);
    
    m_r = var.m_rf + m_fuel;

%calculating force direction components
F(1:3) = (T(1:3)-D(1:3)).*h(1:3);
F(3) = F(3)-m_r*var.g;
 

    %% Flight Phase 2 (Engine off)
elseif m_fuel<massflow
    %m_fuel = 0;
    h = (V(1:3)./norm(V))';
    T = 0;
    mdot = -m_fuel;
    D = ((var.C_d*var.rho*V.^2*var.A_c)./2)';
    
    m_r = var.m_rf + m_fuel;

%calculating force direction components
F(1:3) = (-D(1:3)).*h(1:3);
F(3) = F(3)-m_r*var.g;
   


elseif m_fuel > 0;
    
    h = (V(1:3)./norm(V))';
    %mass flow in flight
    mdot = -massflow;
    
    %Thrust (T)
    T = -mdot.*var.V_e+var.A_e*(var.p_e-var.p_0);
    T = T*h;
    
    %Drag (D), velocity (V)
    D = ((var.C_d*var.rho*V.^2*var.A_c)./2)';
    
    m_r = var.m_rf + m_fuel;

%calculating force direction components
F(1:3) = (T(1:3)-D(1:3)).*h(1:3);
F(3) = F(3)-m_r*var.g;
    
end
    

%% Calculating Motion


%calculating velocity change components
dV_dt = (F./m_r)';

%Location change components
dr_dt = V';

if r(3)<0
    r(3)=0;
    dr_dt=[0;0;0];
end


dydt = [mdot;dV_dt;dr_dt];










