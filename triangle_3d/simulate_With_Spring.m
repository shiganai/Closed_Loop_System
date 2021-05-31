
clear all

g = 1;
l_Arm = 1;
th1_0 = 1/2 * pi;
dth1_0 = 0;
th2_0 = 1/2 * pi;
dth2_0 = 0;
th3_0 = 1/2 * pi;
dth3_0 = 0;
phi1_0 = 0;
dphi1_0 = 0;
phi2_0 = 2/3 * pi;
dphi2_0 = 0;
phi3_0 = -2/3 * pi;
dphi3_0 = 0;

tau1 = 0;
tau2 = 0;
tau3 = 0;
m1 = 1;
m2 = 1;
m3 = 1;
k = 1e3;

q_0 = [th1_0, dth1_0, th2_0, dth2_0, th3_0, dth3_0, phi1_0, dphi1_0, phi2_0, dphi2_0, phi3_0, dphi3_0]';
t = 0:1e-1:50;

[time, q] = ode45(@(t,q) ddt_With_Spring(t, q, g, k, l_Arm, m1, m2, m3, tau1, tau2, tau3), t, q_0);

th1 = q(:, 1);
dth1 = q(:, 2);
th2 = q(:, 3);
dth2 = q(:, 4);
th3 = q(:, 5);
dth3 = q(:, 6);
phi1 = q(:, 7);
dphi1 = q(:, 8);
phi2 = q(:, 9);
dphi2 = q(:, 10);
phi3 = q(:, 11);
dphi3 = q(:, 12);

p0 = zeros(size(time, 1), 3);
p1 = l_Arm * [sin(th1) .* cos(phi1), sin(th1) .* sin(phi1), cos(th1)];
p2 = p1 + l_Arm * [sin(th2) .* cos(phi2), sin(th2) .* sin(phi2), cos(th2)];
p3 = p2 + l_Arm * [sin(th3) .* cos(phi3), sin(th3) .* sin(phi3), cos(th3)];

x_Array = [p0(:,1), p1(:,1), p2(:,1), p3(:,1)];
y_Array = [p0(:,2), p1(:,2), p2(:,2), p3(:,2)];
z_Array = [p0(:,3), p1(:,3), p2(:,3), p3(:,3)];


anime = AnimeAndData(time, x_Array, y_Array, z_Array);
plot_Lim = 3 * l_Arm * [-1, 1];
xlim(anime.axAnime, plot_Lim)
ylim(anime.axAnime, plot_Lim)
zlim(anime.axAnime, plot_Lim)
view(anime.axAnime, [0,-1,0])

dockfig(1)
plot(time, [th1, th2, th3])

dockfig(2)
plot(time, [phi1, phi2, phi3])



































