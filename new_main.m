function dydt = new_main(t,y,var)

m = y(1);
x_inert = y(2:4);
v_inert = y(5:7);
sig = y(8:10);
omeg = y(11:13);

T = var.T;
if v_inert ~= [0;0;0]
    D = ((v_inert/norm(v_inert)) * ((var.cd * var.rho * norm(v_inert)^2 * var.a)/2));
else
    D = [0;0;0];
end

normx = norm(x_inert);

mdot = -var.mdot;
a = ((MRP2DCM(sig).'*T)/m) + (-(var.grav/normx^3)*x_inert) - D/m;
sigdot = (.25*((1-(sig.'*sig))*eye(3) + 2*skew(sig.') + (2*sig*(sig.'))))*omeg;
odot = (-skew(omeg)*(var.Imat*omeg)) + var.Imat\(skew(var.COM)*T) + var.Imat\var.L;

dm = mdot;
dx = v_inert;
dv = a;
ds = sigdot;
do = odot;

dydt = [dm;dx;dv;ds;do];
end

