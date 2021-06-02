
clear all
tic

syms width_Body height_Body depth_Body real
syms m_Body real
syms m_Hand real
syms hand_Length real
syms k g real

syms offset_Body doffset_Body ddoffset_Body real
syms alpha_Body dalpha_Body ddalpha_Body real
syms beta_Body dbeta_Body ddbeta_Body real
syms gamma_Body dgamma_Body ddgamma_Body real

syms r_Alpha_Hand dr_Alpha_Hand ddr_Alpha_Hand real
syms r_Beta_Hand dr_Beta_Hand ddr_Beta_Hand real

syms l_Alpha_Hand dl_Alpha_Hand ddl_Alpha_Hand real
syms l_Beta_Hand dl_Beta_Hand ddl_Beta_Hand real

%%
I_Body = 1/12 * m_Body * [
    height_Body^2 + depth_Body^2, 0, 0;
    0, width_Body^2 + depth_Body^2, 0;
    0, 0, width_Body^2 + height_Body^2
    ];

I_Hand = 1/12 * m_Hand * [
    hand_Length^2 + 0^2, 0, 0;
    0, 0^2 + hand_Length^2, 0;
    0, 0, 0^2 + 0^2
    ];

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

head = formula(head * trans_Vec_Body);
r_Shoulder = formula(r_Shoulder * trans_Vec_Body);
l_Shoulder = formula(l_Shoulder * trans_Vec_Body);
r_Hip = formula(r_Hip * trans_Vec_Body);
l_Hip = formula(l_Hip * trans_Vec_Body);
g_Body = formula(g_Body * trans_Vec_Body);

r_Hand = formula(r_Hand * trans_Vec_Body);
r_G_Hand = formula(r_G_Hand * trans_Vec_Body);
l_Hand = formula(l_Hand * trans_Vec_Body);
l_G_Hand = formula(l_G_Hand * trans_Vec_Body);

parallel.defaultClusterProfile('local');
c = parcluster();

job = createJob(c);
createTask(job, @matlabFunction, 1,{r_Shoulder(1:3), ...
    'file', 'find_R_Shoulder.m', 'outputs', ...
    {'r_Shoulder'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{l_Shoulder(1:3), ...
    'file', 'find_L_Shoulder.m', 'outputs', ...
    {'l_Shoulder'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{r_Hip(1:3), ...
    'file', 'find_R_Hip.m', 'outputs', ...
    {'r_Hip'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{l_Hip(1:3), ...
    'file', 'find_L_Hip.m', 'outputs', ...
    {'l_Hip'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{r_Hand(1:3), ...
    'file', 'find_R_Hand.m', 'outputs', ...
    {'r_Hand'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{l_Hand(1:3), ...
    'file', 'find_L_Hand.m', 'outputs', ...
    {'l_Hand'}});
submit(job)
job.Tasks











