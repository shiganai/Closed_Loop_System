function dotq = ddt_Velocity(~, q, g,l_Arm,m1,m2,m3, tau1, tau2, tau3)

th1 = q(1);
dth1 = q(2);
th2 = q(3);
dth2 = q(4);
th3 = q(5);
dth3 = q(6);
phi1 = q(7);
phi2 = q(8);
phi3 = q(9);

[ddth1,ddth2,ddth3] = find_Dds_Velocity(dth1,dth2,dth3,g,l_Arm,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3);

[dphi1,dphi2,dphi3] = find_Ds_Velocity(dth1,dth2,dth3,l_Arm,phi1,phi2,phi3,th1,th2,th3);

dotq = [dth1, ddth1, dth2, ddth2, dth3, ddth3, dphi1, dphi2, dphi3]';