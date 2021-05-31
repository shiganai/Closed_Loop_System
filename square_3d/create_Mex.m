
g = 1;
l_Arm = 1;
th1 = 1/2 * pi;
dth1 = 0;
th2 = 1/2 * pi;
dth2 = 0;
th3 = 1/2 * pi;
dth3 = 0;
phi1 = 0;
dphi1 = 0;
phi2 = 1/2 * pi;
dphi2 = 0;
phi3 = 2/2 * pi;
dphi3 = 0;

x = 0;
dx = 0;
y = 0;
dy = 0;
z = 0;
dz = 0;

tau1 = 0;
tau2 = 0;
tau3 = 0;
m0 = 1;
m1 = 1;
m2 = 1;
m3 = 1;
k = 1e4;

p0 = [0,0,0];
p1 = l_Arm * [sin(th1) .* cos(phi1), sin(th1) .* sin(phi1), cos(th1)];
p2 = p1 + l_Arm * [sin(th2) .* cos(phi2), sin(th2) .* sin(phi2), cos(th2)];
p3 = p2 + l_Arm * [sin(th3) .* cos(phi3), sin(th3) .* sin(phi3), cos(th3)];

x0_Fixed = p0(1);
y0_Fixed = p0(2);
z0_Fixed = p0(3);

x3_Fixed = p3(1);
y3_Fixed = p3(2);
z3_Fixed = p3(3);

[ddth1,ddth2,ddth3,ddphi1,ddphi2,ddphi3,ddx,ddy,ddz] = ...
    find_Dds_With_Double_Spring(dphi1,dphi2,dphi3,dth1,dth2,dth3,g,k,l_Arm,m0,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3,x,x0_Fixed,x3_Fixed,y,y0_Fixed,y3_Fixed,z,z0_Fixed,z3_Fixed);