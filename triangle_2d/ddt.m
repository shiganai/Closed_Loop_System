function dotq = ddt(~, q, g, l_Arm, m1, m2, tau1, tau2, tau3)

th1 = q(1);
ddth1 = find_Triangle_Ddth1(g,l_Arm,m1,m2,tau1,tau2,tau3,th1);

dotq = [q(2), ddth1]';

end