function dotq = ddt_With_Double_Spring(~, q, g, k, l_Arm, m0, m1, m2, m3, tau1, tau2, tau3, p0_Fixed, p3_Fixed)

x0_Fixed = p0_Fixed(1);
y0_Fixed = p0_Fixed(2);
z0_Fixed = p0_Fixed(3);

x3_Fixed = p3_Fixed(1);
y3_Fixed = p3_Fixed(2);
z3_Fixed = p3_Fixed(3);

th1 = q(1);
dth1 = q(2);
th2 = q(3);
dth2 = q(4);
th3 = q(5);
dth3 = q(6);
phi1 = q(7);
dphi1 = q(8);
phi2 = q(9);
dphi2 = q(10);
phi3 = q(11);
dphi3 = q(12);
x = q(13);
dx = q(14);
y = q(15);
dy = q(16);
z = q(17);
dz = q(18);

[ddth1,ddth2,ddth3,ddphi1,ddphi2,ddphi3,ddx,ddy,ddz] = ...
    find_Dds_With_Double_Spring_mex(dphi1,dphi2,dphi3,dth1,dth2,dth3,g,k,l_Arm,m0,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3,x,x0_Fixed,x3_Fixed,y,y0_Fixed,y3_Fixed,z,z0_Fixed,z3_Fixed);

dotq = [dth1, ddth1, dth2, ddth2, dth3, ddth3, dphi1, ddphi1, dphi2, ddphi2, dphi3, ddphi3, dx, ddx, dy, ddy, dz, ddz]';