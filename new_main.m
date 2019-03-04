function dydt = new_main(t,y,var)

x = y(2:4);
v = y(5:7);

normx = norm(x);

if y(1) > var.m_dry
   m = y(1);
   mdot = -var.mdot;
   T = var.T;
   D = (var.cd*var.rho*(norm(v))^2*var.a)/2;
   a = (-(var.grav/normx^3)*x) + (T*var.dir)/m-(D*var.dir)/m;
elseif v == [0;0;0]
   m = var.m_dry;
   mdot = 0;
   T = 0;
   D = 0;
   a = [0;0;0];
else
   m = var.m_dry;
   mdot = 0;
   T = 0;
   D = (var.cd*var.rho*(norm(v))^2*var.a)/2;
   a = (-(var.grav/normx^3)*x) + (T*var.dir)/m-(D*var.dir)/m;
end

dm = mdot;
dx = v;
dv = a;

dydt = [dm;dx;dv];
end

