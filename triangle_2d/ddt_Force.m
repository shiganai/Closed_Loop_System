function dotq = ddt_Force(~, q, g, l_Arm, m1, m2, tau1, tau2, tau3)

th1 = q(1);
dth1 = q(2);
th2 = q(3);
dth2 = q(4);
th3 = q(5);
dth3 = q(6);

[ddth1,ddth2,ddth3] = find_Dds_Triangle_2D_Force(dth1,dth2,dth3,g,l_Arm,m1,m2,tau1,tau2,tau3,th1,th2,th3);

dotq = [dth1, ddth1, dth2, ddth2, dth3, ddth3]';

end