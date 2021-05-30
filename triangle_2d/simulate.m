
clear all

g = 1;
l_Arm = 1;
th1_0 = 0;
dth1_0 = 0;
[th2_0, th3_0] = find_Triangle_Th2_Th3(th1_0);
tau1 = 0;
tau2 = 0;
tau3 = 0;
m1 = 1;
m2 = 1;
m3 = 1;

q_0 = [th1_0, dth1_0]';
t = 0:1e-2:100;

[time, q] = ode45(@(t,q) ddt(t, q, g, l_Arm, m1, m2, tau1, tau2, tau3), t, q_0);

th1 = q(:,1);
dth1 = q(:,2);

[th2,th3] = find_Triangle_Th2_Th3(th1);

p0 = zeros(size(time, 1), 2);
p1 = l_Arm * [cos(th1), sin(th1)];
p2 = p1 + l_Arm * [cos(th2), sin(th2)];
p3 = p2 + l_Arm * [cos(th3), sin(th3)];

x_Array = [p0(:,1), p1(:,1), p2(:,1), p3(:,1)];
z_Array = [p0(:,2), p1(:,2), p2(:,2), p3(:,2)];
y_Array = zeros(size(x_Array));


anime = AnimeAndData(time, x_Array, y_Array, z_Array);
xlim(anime.axAnime, [-1, 1])
ylim(anime.axAnime, [-1, 1])
zlim(anime.axAnime, [-1, 1])
view(anime.axAnime, [0,-1,0])




































