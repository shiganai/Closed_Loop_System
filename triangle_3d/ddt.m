function dotq = ddt(~, q, g,k,l_Arm,m1,m2,m3, tau1, tau2, tau3)

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


% [ddth1,ddth2,ddth3,ddphi1,ddphi2,ddphi3] = find_Dds(dphi1,dphi2,dphi3,dth1,dth2,dth3,g,l_Arm,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3);
[ddth1,ddth2,ddth3,ddphi1,ddphi2,ddphi3] = find_Dds_With_Spring(dphi1,dphi2,dphi3,dth1,dth2,dth3,g,k,l_Arm,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3);

dotq = [dth1, ddth1, dth2, ddth2, dth3, ddth3, dphi1, ddphi1, dphi2, ddphi2, dphi3, ddphi3]';