function dotq = ddt_With_Double_Spring(~, q, g, k, l_Arm, m1, m2, m3, tau1, tau2, tau3)

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

[ddth1,ddth2,ddth3,ddphi1,ddphi2,ddphi3,ddx,ddy,ddz] = find_Dds_With_Double_Spring(dphi1,dphi2,dphi3,dth1,dth2,dth3,g,k,l_Arm,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3,x,y,z);

dotq = [dth1, ddth1, dth2, ddth2, dth3, ddth3, dphi1, ddphi1, dphi2, ddphi2, dphi3, ddphi3, dx, ddx, dy, ddy, dz, ddz]';