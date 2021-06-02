
clear all

width_Body = 1;
height_Body = 2;
depth_Body = 0.5;
m_Body = 1;
m_Hand = 0.1;
length_Hand = 1;
g = 1;
k = 1e3;

beta_Body = deg2rad(0);
gamma_Body = deg2rad(0);
offset_Body = 1;
alpha_Body = deg2rad(-90);

r_Offset_Hand = 0;
r_Alpha_Hand = -deg2rad(90);
r_Beta_Hand = deg2rad(0);
r_Gamma_Hand = deg2rad(0);

l_Offset_Hand = 0;
l_Alpha_Hand = -deg2rad(90);
l_Beta_Hand = -deg2rad(0);
l_Gamma_Hand = -deg2rad(0);

%%
r_Hand = [0, -length_Hand, 0, 1];
r_Hand_Bottom_R = [0.1, 0, 0, 1];
r_Hand_Bottom_L = [-0.1, 0, 0, 1];
r_G_Hand = [0, -length_Hand/2, 0, 1];

r_Trans_Vec_Hand = ...
    [cos(r_Gamma_Hand), 0, sin(r_Gamma_Hand), 0; 0, 1, 0, 0; -sin(r_Gamma_Hand), 0, cos(r_Gamma_Hand), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(r_Beta_Hand), -sin(r_Beta_Hand), 0, 0; sin(r_Beta_Hand), cos(r_Beta_Hand), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, 0; 0, cos(r_Alpha_Hand), -sin(r_Alpha_Hand), 0; 0, sin(r_Alpha_Hand), cos(r_Alpha_Hand), 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, width_Body/2; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    1;
r_Hand = r_Hand * r_Trans_Vec_Hand;
r_Hand_Bottom_R = r_Hand_Bottom_R * r_Trans_Vec_Hand;
r_Hand_Bottom_L = r_Hand_Bottom_L * r_Trans_Vec_Hand;
r_G_Hand = r_G_Hand * r_Trans_Vec_Hand;

%%
l_Hand = [0, -length_Hand, 0, 1];
l_Hand_Bottom_R = [0.1, 0, 0, 1];
l_Hand_Bottom_L = [-0.1, 0, 0, 1];
l_G_Hand = [0, -length_Hand/2, 0, 1];

l_Trans_Vec_Hand = ...
    [cos(l_Gamma_Hand), 0, sin(l_Gamma_Hand), 0; 0, 1, 0, 0; -sin(l_Gamma_Hand), 0, cos(l_Gamma_Hand), 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, 0; 0, cos(l_Alpha_Hand), -sin(l_Alpha_Hand), 0; 0, sin(l_Alpha_Hand), cos(l_Alpha_Hand), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(l_Beta_Hand), -sin(l_Beta_Hand), 0, 0; sin(l_Beta_Hand), cos(l_Beta_Hand), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, -width_Body/2; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    1;
l_Hand = l_Hand * l_Trans_Vec_Hand;
l_Hand_Bottom_R = l_Hand_Bottom_R * l_Trans_Vec_Hand;
l_Hand_Bottom_L = l_Hand_Bottom_L * l_Trans_Vec_Hand;
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

r_Hand_Bottom_R = (r_Hand_Bottom_R * trans_Vec_Body);
r_Hand_Bottom_L = (r_Hand_Bottom_L * trans_Vec_Body);

l_Hand_Bottom_R = (l_Hand_Bottom_R * trans_Vec_Body);
l_Hand_Bottom_L = (l_Hand_Bottom_L * trans_Vec_Body);

x_Plot3 = [r_Shoulder(1), l_Shoulder(1), l_Hip(1), r_Hip(1), r_Shoulder(1)];
y_Plot3 = [r_Shoulder(2), l_Shoulder(2), l_Hip(2), r_Hip(2), r_Shoulder(2)];
z_Plot3 = [r_Shoulder(3), l_Shoulder(3), l_Hip(3), r_Hip(3), r_Shoulder(3)];
after_Color = plot3(x_Plot3, y_Plot3, z_Plot3);
hold on
scatter3(head(1), head(2), head(3), 'k' ,'filled')
plot3([r_Hand_Bottom_R(1), r_Hand_Bottom_L(1), r_Hand(1), r_Hand_Bottom_R(1)], ...
    [r_Hand_Bottom_R(2), r_Hand_Bottom_L(2), r_Hand(2), r_Hand_Bottom_R(2)], ...
    [r_Hand_Bottom_R(3), r_Hand_Bottom_L(3), r_Hand(3), r_Hand_Bottom_R(3)], ...
    '-o', 'Color', after_Color.Color)
plot3([l_Hand_Bottom_R(1), l_Hand_Bottom_L(1), l_Hand(1), l_Hand_Bottom_R(1)], ...
    [l_Hand_Bottom_R(2), l_Hand_Bottom_L(2), l_Hand(2), l_Hand_Bottom_R(2)], ...
    [l_Hand_Bottom_R(3), l_Hand_Bottom_L(3), l_Hand(3), l_Hand_Bottom_R(3)], ...
    '-o', 'Color', after_Color.Color)
hold off
xlabel('x')
ylabel('y')
zlabel('z')
daspect([1,1,1])












































