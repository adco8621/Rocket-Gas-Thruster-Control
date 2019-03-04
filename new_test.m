clear;clc;close all;

var.m_e = 5.9723*10^24; %earth mass kg
var.r_e = 6371000; %earth radius m
var.G = 6.67408*10^-11; %G m^3 kg^-1 s^-2
var.grav = var.m_e * var. G; %for gravity calculations
var.dir = [0;0.1;1]; %assuming constant up direction
var.cd = .3; %drag coefficient
var.rho = 1.225; %air density kg m^-3

%electron rocket
var.a = pi*.6^2; %area
var.T = 162000; %thrust
var.isp = 303; %isp
var.mdot = var.T/var.isp; %mass flow
var.m_wet = 12500; %wet mass kg
var.m_dry = 1190; %dry mass kg

%initial stuff
xini = [0;0;var.r_e];
vini = [0;0;0];

y(:,1) = [var.m_wet;xini;vini];
dt = .5;
t = (0:dt:1000);
xdot = @(t,y) new_main(t,y,var);
for i = 2:numel(t)
    if y(1,end)<var.m_dry
        y(1,end) = var.m_dry;
    end
    if norm(y(2:4,i-1))<var.r_e
        y(5:7,i) = 0;
        y(5:7,i-1) = 0;
        y(5:7,i-2) = 0;
    end
    k1 = dt*xdot(t(i-1),y(:,i-1));
    k2 = dt*xdot(t(i-1)+dt/2, y(:,i-1)+k1/2);
    k3 = dt*xdot(t(i-1)+dt/2, y(:,i-1)+k2/2);
    k4 = dt*xdot(t(i-1)+dt, y(:,i-1)+k3);
    y(:,i) = y(:,i-1) + (k1+2*k2+2*k3+k4)/6;
end

m = y(1,:);
r = y(2:4,:);
V = y(5:7,:);

%plot(t,h)
plot3(r(1,:),r(2,:),r(3,:)-var.r_e)
xlabel("x")
ylabel("y")
zlabel("z")
grid

figure
plot(t,V)
legend("x-vel","y-vel","z-vel")
xlabel("t (s)")
ylabel("V (m/s) (check units)")
grid

figure
plot(t,m)
xlabel("t (s)")
ylabel("mass")
grid

figure
plot(t,r(3,:)-var.r_e)
xlabel("t")
ylabel("z")
grid