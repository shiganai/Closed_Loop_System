
clear all

width_Body = 1;
height_Body = 2;
depth_Body = 0.5;
m_Body = 10;
m_Hand = 1;
length_Hand = 1;
radius_Hand = 1;
g = 1;
k = 100;

beta_Body = deg2rad(0);
gamma_Body = deg2rad(0);
offset_Body = 1;
alpha_Body = deg2rad(-90);

r_Offset_Hand = 0;
r_Alpha_Hand = -deg2rad(0);
r_Beta_Hand = deg2rad(0);
r_Gamma_Hand = deg2rad(0);

l_Offset_Hand = 0;
l_Alpha_Hand = -deg2rad(0);
l_Beta_Hand = -deg2rad(0);
l_Gamma_Hand = -deg2rad(0);

tau_Alpha_Body = 0;
r_Tau_Alpha_Hand = 10;
l_Tau_Alpha_Hand = 10;

r_Shoulder = find_R_Shoulder(alpha_Body,beta_Body,gamma_Body,offset_Body,width_Body);
l_Hand = find_L_Hand(alpha_Body,beta_Body,gamma_Body,length_Hand,l_Alpha_Hand,l_Beta_Hand,offset_Body,width_Body);
l_Hip = find_L_Hip(alpha_Body,beta_Body,gamma_Body,height_Body,offset_Body,width_Body);
l_Shoulder = find_L_Shoulder(alpha_Body,beta_Body,gamma_Body,offset_Body,width_Body);
r_Hand = find_R_Hand(alpha_Body,beta_Body,gamma_Body,length_Hand,offset_Body,r_Alpha_Hand,r_Beta_Hand,width_Body);
r_Hip = find_R_Hip(alpha_Body,beta_Body,gamma_Body,height_Body,offset_Body,width_Body);

r_P_Fixed = r_Hand;
l_P_Fixed = l_Hand;

%%
q = [
    offset_Body, 0, ...
    alpha_Body, 0, ...
    beta_Body, 0, ...
    gamma_Body, 0, ...
    r_Alpha_Hand, 0, ...
    r_Beta_Hand, 0, ...
    r_Gamma_Hand, 0, ...
    l_Alpha_Hand, 0, ...
    l_Beta_Hand, 0, ...
    l_Gamma_Hand, 0, ...
    ]';

time = 0:1e-2:10;

[time, q] = ode45(@(t,q) ddt(t,q,depth_Body,g,length_Hand,height_Body,k,m_Body,m_Hand,width_Body, r_P_Fixed, l_P_Fixed, tau_Alpha_Body, r_Tau_Alpha_Hand, l_Tau_Alpha_Hand, radius_Hand), time, q);

offset_Body = q(:, 1);
doffset_Body = q(:, 2);
alpha_Body = q(:, 3);
dalpha_Body = q(:, 4);
beta_Body = q(:, 5);
dbeta_Body = q(:, 6);
gamma_Body = q(:, 7);
dgamma_Body = q(:, 8);
r_Alpha_Hand = q(:, 9);
dr_Alpha_Hand = q(:, 10);
r_Beta_Hand = q(:, 11);
dr_Beta_Hand = q(:, 12);
r_Gamma_Hand = q(:, 13);
dr_Gamma_Hand = q(:, 14);
l_Alpha_Hand = q(:, 15);
dl_Alpha_Hand = q(:, 16);
l_Beta_Hand = q(:, 17);
dl_Beta_Hand = q(:, 18);
l_Gamma_Hand = q(:, 19);
dl_Gamma_Hand = q(:, 20);

r_Shoulder = find_R_Shoulder(alpha_Body,beta_Body,gamma_Body,offset_Body,width_Body);
l_Hand = find_L_Hand(alpha_Body,beta_Body,gamma_Body,length_Hand,l_Alpha_Hand,l_Beta_Hand,offset_Body,width_Body);
l_Hip = find_L_Hip(alpha_Body,beta_Body,gamma_Body,height_Body,offset_Body,width_Body);
l_Shoulder = find_L_Shoulder(alpha_Body,beta_Body,gamma_Body,offset_Body,width_Body);
r_Hand = find_R_Hand(alpha_Body,beta_Body,gamma_Body,length_Hand,offset_Body,r_Alpha_Hand,r_Beta_Hand,width_Body);
r_Hip = find_R_Hip(alpha_Body,beta_Body,gamma_Body,height_Body,offset_Body,width_Body);

nan_Array = nan(size(time, 1), 1);

x_Array = [r_Shoulder(:, 1), l_Shoulder(:, 1), l_Hip(:, 1), r_Hip(:, 1), r_Shoulder(:, 1), r_Hand(:, 1), nan_Array, l_Shoulder(:, 1), l_Hand(:, 1)];
y_Array = [r_Shoulder(:, 2), l_Shoulder(:, 2), l_Hip(:, 2), r_Hip(:, 2), r_Shoulder(:, 2), r_Hand(:, 2), nan_Array, l_Shoulder(:, 2), l_Hand(:, 2)];
z_Array = [r_Shoulder(:, 3), l_Shoulder(:, 3), l_Hip(:, 3), r_Hip(:, 3), r_Shoulder(:, 3), r_Hand(:, 3), nan_Array, l_Shoulder(:, 3), l_Hand(:, 3)];

anime = AnimeAndData(time, x_Array, y_Array, z_Array);
plot_Lim = 4 * [-1, 1];
xlim(anime.axAnime, plot_Lim)
ylim(anime.axAnime, plot_Lim)
zlim(anime.axAnime, plot_Lim)
view(anime.axAnime, [-1,-1,-1])

dockfig(1)
plot(time, [r_Hand l_Hand])

dockfig(2)
plot(time, [alpha_Body, beta_Body])

dockfig(3)
plot(time, [r_Alpha_Hand, r_Beta_Hand])

dockfig(4)
plot(time, [l_Alpha_Hand, l_Beta_Hand])

%{
%%
r_Hand = [0, -hand_Length, 0, 1];
r_G_Hand = [0, -hand_Length/2, 0, 1];

r_Trans_Vec_Hand = ...
    [1, 0, 0, 0; 0, cos(r_Alpha_Hand), -sin(r_Alpha_Hand), 0; 0, sin(r_Alpha_Hand), cos(r_Alpha_Hand), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(r_Beta_Hand), -sin(r_Beta_Hand), 0, 0; sin(r_Beta_Hand), cos(r_Beta_Hand), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, width_Body/2; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    1;
r_Hand = r_Hand * r_Trans_Vec_Hand;
r_G_Hand = r_G_Hand * r_Trans_Vec_Hand;

%%
l_Hand = [0, -hand_Length, 0, 1];
l_G_Hand = [0, -hand_Length/2, 0, 1];

l_Trans_Vec_Hand = ...
    [1, 0, 0, 0; 0, cos(l_Alpha_Hand), -sin(l_Alpha_Hand), 0; 0, sin(l_Alpha_Hand), cos(l_Alpha_Hand), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(l_Beta_Hand), -sin(l_Beta_Hand), 0, 0; sin(l_Beta_Hand), cos(l_Beta_Hand), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, -width_Body/2; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    1;
l_Hand = l_Hand * l_Trans_Vec_Hand;
l_G_Hand = l_G_Hand * l_Trans_Vec_Hand;

%%
head = [0, 0, 0, 1];
r_Shoulder = [width_Body/2, 0, 0, 1];
l_Shoulder = [-width_Body/2, 0, 0, 1];
r_Hip = [width_Body/2, height_Body, 0, 1];
l_Hip = [-width_Body/2, height_Body, 0, 1];
g_Body = (r_Shoulder + l_Shoulder + r_Hip + l_Hip)/4;

trans_Vec_Body = ...
    [cos(beta_Body), 0, sin(beta_Body), 0; 0, 1, 0, 0; -sin(beta_Body), 0, cos(beta_Body), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(gamma_Body), -sin(gamma_Body), 0, 0; sin(gamma_Body), cos(gamma_Body), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, 0; 0, 1, 0, offset_Body; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, 0; 0, cos(alpha_Body), -sin(alpha_Body), 0; 0, sin(alpha_Body), cos(alpha_Body), 0; 0, 0, 0, 1]' ...
    * ...
    1;

head = (head * trans_Vec_Body);
r_Shoulder = (r_Shoulder * trans_Vec_Body);
l_Shoulder = (l_Shoulder * trans_Vec_Body);
r_Hip = (r_Hip * trans_Vec_Body);
l_Hip = (l_Hip * trans_Vec_Body);
g_Body = (g_Body * trans_Vec_Body);

r_Hand = (r_Hand * trans_Vec_Body);
r_G_Hand = (r_G_Hand * trans_Vec_Body);
l_Hand = (l_Hand * trans_Vec_Body);
l_G_Hand = (l_G_Hand * trans_Vec_Body);

x_Plot3 = [r_Shoulder(1), l_Shoulder(1), l_Hip(1), r_Hip(1), r_Shoulder(1)];
y_Plot3 = [r_Shoulder(2), l_Shoulder(2), l_Hip(2), r_Hip(2), r_Shoulder(2)];
z_Plot3 = [r_Shoulder(3), l_Shoulder(3), l_Hip(3), r_Hip(3), r_Shoulder(3)];
after_Color = plot3(x_Plot3, y_Plot3, z_Plot3);
hold on
scatter3(head(1), head(2), head(3), 'k' ,'filled')
plot3([r_Shoulder(1), r_Hand(1)], [r_Shoulder(2), r_Hand(2)], [r_Shoulder(3), r_Hand(3)], '-o', 'Color', after_Color.Color)
plot3([l_Shoulder(1), l_Hand(1)], [l_Shoulder(2), l_Hand(2)], [l_Shoulder(3), l_Hand(3)], '-o', 'Color', after_Color.Color)
hold off
xlabel('x')
ylabel('y')
zlabel('z')
daspect([1,1,1])
%}












































