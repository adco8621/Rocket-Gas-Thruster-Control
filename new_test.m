clear;clc;close all;

var.m_e = 5.9723*10^24; %earth mass kg
var.r_e = 6371000; %earth radius m
var.G = 6.67408*10^-11; %G m^3 kg^-1 s^-2
var.grav = var.m_e * var. G; %for gravity calculations
var.cd = .3; %drag coefficient

var.L = [0;0;0];

%electron rocket
var.r = 0.3;
var.a = pi*var.r^2; %area
var.h = 1;
var.T = [0.1;0.1;4000]; %thrust
var.isp = 230; %isp
var.mdot = var.T(3)/(9.81*var.isp); %mass flow
var.m_wet = 300; %wet mass kg
var.m_dry = 200; %dry mass kg
var.COM = [0;0;-var.h/2];

%initial stuff
xini = [0;0;var.r_e];
vini = [0;0;0];
sigini = [0;0;0];
oini = [0;0;0];

y(:,1) = [var.m_wet;xini;vini;sigini;oini];
var.dt = .01;
t = (0:var.dt:160);
for i = 2:numel(t)
    if i == 12178
    end
    m = y(1,i-1);
    x_inert = y(2:4,i-1);
    v_inert = y(5:7,i-1);
    sig = y(8:10,i-1);
    omeg = y(11:13,i-1);
    
    [~,~,~,var.rho] = atmosisa(norm(y(2:4,i-1))-var.r_e);
    
    var.Imat = diag([.5*m*var.h^2 + .25*m*var.r^2 , .5*m*var.h^2 + .25*m*var.r^2 , .5*m*var.r^2]);
    xdot = @(t,y) new_main(t,y,var);
    
    if norm(y(2:4,i-1))<var.r_e
        y(1,i-1) = 0;
        y(5:7,i-1) = 0;
    end
    if m <= var.m_dry
        y(1,i-1) = var.m_dry;
        var.mdot = 0;
        var.T = [0;0;0];
    end
    
    k1 = var.dt*xdot(t(i-1),y(:,i-1));
    k2 = var.dt*xdot(t(i-1)+var.dt/2, y(:,i-1)+k1/2);
    k3 = var.dt*xdot(t(i-1)+var.dt/2, y(:,i-1)+k2/2);
    k4 = var.dt*xdot(t(i-1)+var.dt, y(:,i-1)+k3);
    y(:,i) = y(:,i-1) + (k1+2*k2+2*k3+k4)/6;
    
    n = norm(y(8:10,i));
    if n>1
        y(8:10,i) = - y(8:10,i) ./ (n^2);
    end
end

m = y(1,:);
r = y(2:4,:);
V = y(5:7,:);
sig = y(8:10,:);
om = y(11:13,:);

figure; plot(t,m); grid on; hold off; title('Mass over time')
xlabel('Time seconds'); ylabel('Mass, kg')

figure; plot3(r(1,:),r(2,:),r(3,:)-var.r_e);
grid on; hold off; axis equal;
xlabel('x'); ylabel('y'); zlabel('z')
title('Position vs Time');

figure;
subplot(3,1,1); plot(t,r(1,:)); ylabel('x pos'); xlabel('time, s');
subplot(3,1,2); plot(t,r(2,:)); ylabel('y pos'); xlabel('time, s');
subplot(3,1,3); plot(t,r(3,:)); ylabel('z pos'); xlabel('time, s');
title('Position vs Time'); hold off;

figure;
subplot(3,1,1); plot(t,V(1,:)); ylabel('x vel'); xlabel('time, s');
subplot(3,1,2); plot(t,V(2,:)); ylabel('y vel'); xlabel('time, s');
subplot(3,1,3); plot(t,V(3,:)); ylabel('z vel'); xlabel('time, s');
title('Velocity vs Time'); hold off;

figure;
subplot(3,1,1); plot(t,sig(1,:)); ylabel('\sigma_1'); xlabel('time, s');
subplot(3,1,2); plot(t,sig(2,:)); ylabel('\sigma_2'); xlabel('time, s');
subplot(3,1,3); plot(t,sig(3,:)); ylabel('\sigma_3'); xlabel('time, s');
title('Sigma MRP vs Time'); hold off;

figure;
subplot(3,1,1); plot(t,om(1,:)); ylabel('\omega_1'); xlabel('time, s');
subplot(3,1,2); plot(t,om(2,:)); ylabel('\omega_2'); xlabel('time, s');
subplot(3,1,3); plot(t,om(3,:)); ylabel('\omega_3'); xlabel('time, s');
title('Omega vs Time'); hold off;