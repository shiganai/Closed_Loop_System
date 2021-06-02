
clear all
tic

syms width_Body height_Body depth_Body real
syms m_Body real
syms m_Hand real
syms length_Hand real
syms radius_Hand real
syms k g real
syms r_Tau_Alpha_Hand real
syms l_Tau_Alpha_Hand real
syms tau_Alpha_Body real

syms r_X_Fixed r_Y_Fixed r_Z_Fixed real
syms l_X_Fixed l_Y_Fixed l_Z_Fixed real
syms r_F_X r_F_Y r_F_Z real
syms l_F_X l_F_Y l_F_Z real

syms alpha_Body_Pre(t)
syms beta_Body_Pre(t)
syms gamma_Body_Pre(t)

syms x_Head_Pre(t) y_Head_Pre(t) z_Head_Pre(t)

syms r_Alpha_Hand_Pre(t)
syms r_Beta_Hand_Pre(t)
syms r_Gamma_Hand_Pre(t)

syms l_Alpha_Hand_Pre(t)
syms l_Beta_Hand_Pre(t)
syms l_Gamma_Hand_Pre(t)

%%
syms alpha_Body dalpha_Body ddalpha_Body real
syms beta_Body dbeta_Body ddbeta_Body real
syms gamma_Body dgamma_Body ddgamma_Body real

syms x_Head dx_Head ddx_Head real
syms y_Head dy_Head ddy_Head real
syms z_Head dz_Head ddz_Head real

syms r_Alpha_Hand dr_Alpha_Hand ddr_Alpha_Hand real
syms r_Beta_Hand dr_Beta_Hand ddr_Beta_Hand real
syms r_Gamma_Hand dr_Gamma_Hand ddr_Gamma_Hand real

syms l_Alpha_Hand dl_Alpha_Hand ddl_Alpha_Hand real
syms l_Beta_Hand dl_Beta_Hand ddl_Beta_Hand real
syms l_Gamma_Hand dl_Gamma_Hand ddl_Gamma_Hand real

syms_Replaced = [
    alpha_Body_Pre diff(alpha_Body_Pre, t) diff(alpha_Body_Pre, t, t), ...
    beta_Body_Pre diff(beta_Body_Pre, t) diff(beta_Body_Pre, t, t), ...
    gamma_Body_Pre diff(gamma_Body_Pre, t) diff(gamma_Body_Pre, t, t), ...
    r_Alpha_Hand_Pre diff(r_Alpha_Hand_Pre, t) diff(r_Alpha_Hand_Pre, t, t), ...
    r_Beta_Hand_Pre diff(r_Beta_Hand_Pre, t) diff(r_Beta_Hand_Pre, t, t), ...
    r_Gamma_Hand_Pre diff(r_Gamma_Hand_Pre, t) diff(r_Gamma_Hand_Pre, t, t), ...
    l_Alpha_Hand_Pre diff(l_Alpha_Hand_Pre, t) diff(l_Alpha_Hand_Pre, t, t), ...
    l_Beta_Hand_Pre diff(l_Beta_Hand_Pre, t) diff(l_Beta_Hand_Pre, t, t), ...
    l_Gamma_Hand_Pre diff(l_Gamma_Hand_Pre, t) diff(l_Gamma_Hand_Pre, t, t), ...
    x_Head_Pre diff(x_Head_Pre, t) diff(x_Head_Pre, t, t), ...
    y_Head_Pre diff(y_Head_Pre, t) diff(y_Head_Pre, t, t), ...
    z_Head_Pre diff(z_Head_Pre, t) diff(z_Head_Pre, t, t), ...
    ];

syms_Replacing = [
    alpha_Body dalpha_Body ddalpha_Body ...
    beta_Body dbeta_Body ddbeta_Body ...
    gamma_Body dgamma_Body ddgamma_Body ...
    r_Alpha_Hand dr_Alpha_Hand ddr_Alpha_Hand ...
    r_Beta_Hand dr_Beta_Hand ddr_Beta_Hand ...
    r_Gamma_Hand dr_Gamma_Hand ddr_Gamma_Hand ...
    l_Alpha_Hand dl_Alpha_Hand ddl_Alpha_Hand ...
    l_Beta_Hand dl_Beta_Hand ddl_Beta_Hand ...
    l_Gamma_Hand dl_Gamma_Hand ddl_Gamma_Hand ...
    x_Head dx_Head ddx_Head ...
    y_Head dy_Head ddy_Head ...
    z_Head dz_Head ddz_Head ...
    ];

%%
I_Body = 1/12 * m_Body * [
    height_Body^2 + depth_Body^2, 0, 0;
    0, width_Body^2 + depth_Body^2, 0;
    0, 0, width_Body^2 + height_Body^2;
    ];

I_Hand = 1/12 * m_Hand * [
    length_Hand^2 + 0^2, 0, 0;
    0, 0^2 + length_Hand^2, 0;
    0, 0, 0^2 + 0^2;
    ];

% I_Hand = 1/12 * m_Hand * [
%     length_Hand^2 + radius_Hand^2, 0, 0;
%     0, radius_Hand^2 + length_Hand^2, 0;
%     0, 0, radius_Hand^2 + radius_Hand^2;
%     ];

%%
r_Hand = [0, -length_Hand, 0, 1];
r_G_Hand = [0, -length_Hand/2, 0, 1];

r_Trans_Vec_Hand = ...
    [1, 0, 0, 0; 0, cos(r_Alpha_Hand_Pre), -sin(r_Alpha_Hand_Pre), 0; 0, sin(r_Alpha_Hand_Pre), cos(r_Alpha_Hand_Pre), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(r_Beta_Hand_Pre), -sin(r_Beta_Hand_Pre), 0, 0; sin(r_Beta_Hand_Pre), cos(r_Beta_Hand_Pre), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, width_Body/2; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    1;

r_Hand = r_Hand * r_Trans_Vec_Hand;
r_G_Hand = r_G_Hand * r_Trans_Vec_Hand;

%%
l_Hand = [0, -length_Hand, 0, 1];
l_G_Hand = [0, -length_Hand/2, 0, 1];

l_Trans_Vec_Hand = ...
    [1, 0, 0, 0; 0, cos(l_Alpha_Hand_Pre), -sin(l_Alpha_Hand_Pre), 0; 0, sin(l_Alpha_Hand_Pre), cos(l_Alpha_Hand_Pre), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(l_Beta_Hand_Pre), -sin(l_Beta_Hand_Pre), 0, 0; sin(l_Beta_Hand_Pre), cos(l_Beta_Hand_Pre), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
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
    [cos(beta_Body_Pre), 0, sin(beta_Body_Pre), 0; 0, 1, 0, 0; -sin(beta_Body_Pre), 0, cos(beta_Body_Pre), 0; 0, 0, 0, 1]' ...
    * ...
    [cos(gamma_Body_Pre), -sin(gamma_Body_Pre), 0, 0; sin(gamma_Body_Pre), cos(gamma_Body_Pre), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, 0; 0, cos(alpha_Body_Pre), -sin(alpha_Body_Pre), 0; 0, sin(alpha_Body_Pre), cos(alpha_Body_Pre), 0; 0, 0, 0, 1]' ...
    * ...
    [1, 0, 0, x_Head_Pre; 0, 1, 0, y_Head_Pre; 0, 0, 1, z_Head_Pre; 0, 0, 0, 1]' ...
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

r_Shoulder = r_Shoulder(1:3);
l_Shoulder = l_Shoulder(1:3);
r_Hip = r_Hip(1:3);
l_Hip = l_Hip(1:3);
g_Body = g_Body(1:3);

r_Hand = r_Hand(1:3);
r_G_Hand = r_G_Hand(1:3);
l_Hand = l_Hand(1:3);
l_G_Hand = l_G_Hand(1:3);

%%
r_P_Fixed = [r_X_Fixed, r_Y_Fixed, r_Z_Fixed];
l_P_Fixed = [l_X_Fixed, l_Y_Fixed, l_Z_Fixed];
% 
% restraint = [
%     r_P_Fixed' == r_Hand';
%     l_P_Fixed' == l_Hand';
%     ];
% restraint_Velocity = diff(restraint, t);
% restraint_Velocity = subs(restraint_Velocity, syms_Replaced, syms_Replacing);
% 
% variables_Velocity = [doffset_Body, dalpha_Body, dbeta_Body, dgamma_Body, dr_Beta_Hand, dl_Beta_Hand];
% [A,B] = equationsToMatrix(restraint_Velocity, variables_Velocity);
% toc
% tic
% sol_Velocity = inv(A) * B;
% toc
% 
% restraint_Acceleration = diff(restraint, t, t);
% restraint_Acceleration = subs(restraint_Acceleration, syms_Replaced, syms_Replacing);
% 
% variables_Acceleration = [ddoffset_Body, ddalpha_Body, ddbeta_Body, ddgamma_Body, ddr_Beta_Hand, ddl_Beta_Hand];
% [A,B] = equationsToMatrix(restraint_Acceleration, variables_Acceleration);
% tic
% sol_Acceleration = inv(A) * B;
% toc
% tic

%%
v_G_Body = diff(g_Body, t);
r_V_G_Hand = diff(r_G_Hand, t);
l_V_G_Hand = diff(l_G_Hand, t);

T = ...
    1/2 * m_Body * (v_G_Body * v_G_Body')...
    + ...
    1/2 * m_Hand * (r_V_G_Hand * r_V_G_Hand')...
    + ...
    1/2 * m_Hand * (l_V_G_Hand * l_V_G_Hand')...
    + ...
    1/2 * ([diff(alpha_Body_Pre, t), diff(beta_Body_Pre, t), diff(gamma_Body_Pre, t)] * (I_Body * [diff(alpha_Body_Pre, t), diff(beta_Body_Pre, t), diff(gamma_Body_Pre, t)]'))...
    + ...
    1/2 * ([diff(r_Alpha_Hand_Pre, t), diff(r_Beta_Hand_Pre, t), 0] * (I_Hand * [diff(r_Alpha_Hand_Pre, t), diff(r_Beta_Hand_Pre, t), 0]'))...
    + ...
    1/2 * ([diff(l_Alpha_Hand_Pre, t), diff(l_Beta_Hand_Pre, t), 0] * (I_Hand * [diff(l_Alpha_Hand_Pre, t), diff(l_Beta_Hand_Pre, t), 0]'))...
    + ...
    0;

% U = ...
%     m_Body * g * g_Body(3)...
%     +...
%     m_Hand * g * r_G_Hand(3)...
%     +...
%     m_Hand * g * l_G_Hand(3)...
%     +...
%     0;

% T = ...
%     1/2 * m_Body * (v_G_Body * v_G_Body')...
%     + ...
%     1/2 * m_Hand * (r_V_G_Hand * r_V_G_Hand')...
%     + ...
%     1/2 * m_Hand * (l_V_G_Hand * l_V_G_Hand')...
%     + ...
%     1/2 * ([diff(alpha_Body_Pre, t), diff(beta_Body_Pre, t), diff(gamma_Body_Pre, t)] * (I_Body * [diff(alpha_Body_Pre, t), diff(beta_Body_Pre, t), diff(gamma_Body_Pre, t)]'))...
%     + ...
%     1/2 * ([diff(r_Alpha_Hand_Pre, t), diff(r_Beta_Hand_Pre, t), diff(r_Gamma_Hand_Pre, t)] * (I_Hand * [diff(r_Alpha_Hand_Pre, t), diff(r_Beta_Hand_Pre, t), diff(r_Gamma_Hand_Pre, t)]'))...
%     + ...
%     1/2 * ([diff(l_Alpha_Hand_Pre, t), diff(l_Beta_Hand_Pre, t), diff(l_Gamma_Hand_Pre, t)] * (I_Hand * [diff(l_Alpha_Hand_Pre, t), diff(l_Beta_Hand_Pre, t), diff(l_Gamma_Hand_Pre, t)]'))...
%     + ...
%     0;

U = ...
    m_Body * g * g_Body(3)...
    +...
    m_Hand * g * r_G_Hand(3)...
    +...
    m_Hand * g * l_G_Hand(3)...
    +...
    1/2 * k * ((r_Hand - r_P_Fixed) * (r_Hand - r_P_Fixed)')...
    +...
    1/2 * k * ((l_Hand - l_P_Fixed) * (l_Hand - l_P_Fixed)')...
    +...
    0;

L = T - U;

%%
% equations = [
%     restraint_Acceleration;
%     -functionalDerivative(L, offset_Body_Pre) == 0 ...
%     + (r_F_X * diff(r_Hand(1), offset_Body_Pre) + r_F_X * diff(r_Hand(1), offset_Body_Pre) + r_F_X * diff(r_Hand(1), offset_Body_Pre))...
%     + (l_F_X * diff(l_Hand(1), offset_Body_Pre) + l_F_X * diff(l_Hand(2), offset_Body_Pre) + l_F_X * diff(l_Hand(3), offset_Body_Pre));
%     -functionalDerivative(L, alpha_Body_Pre) == tau_Alpha_Body ...
%     + (r_F_X * diff(r_Hand(1), alpha_Body_Pre) + r_F_X * diff(r_Hand(1), alpha_Body_Pre) + r_F_X * diff(r_Hand(1), alpha_Body_Pre))...
%     + (l_F_X * diff(l_Hand(1), alpha_Body_Pre) + l_F_X * diff(l_Hand(2), alpha_Body_Pre) + l_F_X * diff(l_Hand(3), alpha_Body_Pre));
%     -functionalDerivative(L, beta_Body_Pre) == 0 ...
%     + (r_F_X * diff(r_Hand(1), beta_Body_Pre) + r_F_X * diff(r_Hand(1), beta_Body_Pre) + r_F_X * diff(r_Hand(1), beta_Body_Pre))...
%     + (l_F_X * diff(l_Hand(1), beta_Body_Pre) + l_F_X * diff(l_Hand(2), beta_Body_Pre) + l_F_X * diff(l_Hand(3), beta_Body_Pre));
%     -functionalDerivative(L, gamma_Body_Pre) == 0 ...
%     + (r_F_X * diff(r_Hand(1), gamma_Body_Pre) + r_F_X * diff(r_Hand(1), gamma_Body_Pre) + r_F_X * diff(r_Hand(1), gamma_Body_Pre))...
%     + (l_F_X * diff(l_Hand(1), gamma_Body_Pre) + l_F_X * diff(l_Hand(2), gamma_Body_Pre) + l_F_X * diff(l_Hand(3), gamma_Body_Pre));
%     -functionalDerivative(L, r_Beta_Hand_Pre) == 0 ...
%     + (r_F_X * diff(r_Hand(1), r_Beta_Hand_Pre) + r_F_X * diff(r_Hand(1), r_Beta_Hand_Pre) + r_F_X * diff(r_Hand(1), r_Beta_Hand_Pre))...
%     + (l_F_X * diff(l_Hand(1), r_Beta_Hand_Pre) + l_F_X * diff(l_Hand(2), r_Beta_Hand_Pre) + l_F_X * diff(l_Hand(3), r_Beta_Hand_Pre));
%     -functionalDerivative(L, l_Beta_Hand_Pre) == 0 ...
%     + (r_F_X * diff(r_Hand(1), l_Beta_Hand_Pre) + r_F_X * diff(r_Hand(1), l_Beta_Hand_Pre) + r_F_X * diff(r_Hand(1), l_Beta_Hand_Pre))...
%     + (l_F_X * diff(l_Hand(1), l_Beta_Hand_Pre) + l_F_X * diff(l_Hand(2), l_Beta_Hand_Pre) + l_F_X * diff(l_Hand(3), l_Beta_Hand_Pre));
%     -functionalDerivative(L, r_Alpha_Hand_Pre) == r_Tau_Alpha_Hand ...
%     + (r_F_X * diff(r_Hand(1), r_Alpha_Hand) + r_F_X * diff(r_Hand(1), r_Alpha_Hand) + r_F_X * diff(r_Hand(1), r_Alpha_Hand))...
%     + (l_F_X * diff(l_Hand(1), r_Alpha_Hand) + l_F_X * diff(l_Hand(2), r_Alpha_Hand) + l_F_X * diff(l_Hand(3), r_Alpha_Hand));
%     -functionalDerivative(L, l_Alpha_Hand_Pre) == l_Tau_Alpha_Hand ...
%     + (r_F_X * diff(r_Hand(1), l_Alpha_Hand) + r_F_X * diff(r_Hand(1), l_Alpha_Hand) + r_F_X * diff(r_Hand(1), l_Alpha_Hand))...
%     + (l_F_X * diff(l_Hand(1), l_Alpha_Hand) + l_F_X * diff(l_Hand(2), l_Alpha_Hand) + l_F_X * diff(l_Hand(3), l_Alpha_Hand));
%     ];

equations = [
    -functionalDerivative(L, alpha_Body_Pre) == tau_Alpha_Body;
    -functionalDerivative(L, beta_Body_Pre) == 0;
    -functionalDerivative(L, gamma_Body_Pre) == 0;
    -functionalDerivative(L, r_Alpha_Hand_Pre) == r_Tau_Alpha_Hand;
    -functionalDerivative(L, r_Beta_Hand_Pre) == 0;
    -functionalDerivative(L, l_Alpha_Hand_Pre) == l_Tau_Alpha_Hand;
    -functionalDerivative(L, l_Beta_Hand_Pre) == 0;
    -functionalDerivative(L, x_Head_Pre) == 0;
    -functionalDerivative(L, y_Head_Pre) == 0;
    -functionalDerivative(L, z_Head_Pre) == 0;
    ];

% equations = [
%     -functionalDerivative(L, offset_Body_Pre) == 0;
%     -functionalDerivative(L, alpha_Body_Pre) == tau_Alpha_Body;
%     -functionalDerivative(L, beta_Body_Pre) == 0;
%     -functionalDerivative(L, gamma_Body_Pre) == 0;
%     -functionalDerivative(L, r_Alpha_Hand_Pre) == r_Tau_Alpha_Hand;
%     -functionalDerivative(L, r_Beta_Hand_Pre) == 0;
%     -functionalDerivative(L, r_Gamma_Hand_Pre) == 0;
%     -functionalDerivative(L, l_Alpha_Hand_Pre) == l_Tau_Alpha_Hand;
%     -functionalDerivative(L, l_Beta_Hand_Pre) == 0;
%     -functionalDerivative(L, l_Gamma_Hand_Pre) == 0;
%     ];

%%

equations = subs(equations, syms_Replaced, syms_Replacing);

toc
% tic
% equations = subs(equations, variables_Velocity, sol_Velocity');
% toc
% tic
% equations = subs(equations, variables_Acceleration, sol_Acceleration');
% toc
tic

% variables = [ddr_Alpha_Hand, ddl_Alpha_Hand, r_F_X, r_F_Y, r_F_Z, l_F_X, l_F_Y, l_F_Z];
variables = [ddalpha_Body, ddbeta_Body, ddgamma_Body, ddr_Alpha_Hand, ddr_Beta_Hand, ddl_Alpha_Hand, ddl_Beta_Hand, ddx_Head, ddy_Head, ddz_Head];
% variables = [ddoffset_Body, ddalpha_Body, ddbeta_Body, ddgamma_Body, ddr_Alpha_Hand, ddr_Beta_Hand, ddl_Alpha_Hand, ddl_Beta_Hand];
% variables = [ddoffset_Body, ddalpha_Body, ddbeta_Body, ddgamma_Body, ddr_Alpha_Hand, ddr_Beta_Hand, ddr_Gamma_Hand, ddl_Alpha_Hand, ddl_Beta_Hand, ddl_Gamma_Hand];

[A, B] = equationsToMatrix(equations, variables);
toc
tic
X = inv(A)*B;
toc

parallel.defaultClusterProfile('local');
c = parcluster();

% job = createJob(c);
% createTask(job, @matlabFunction, 1,{X(1), X(2), ...
%     'file', 'find_Dds_Velocity.m', 'outputs', ...
%     {'ddr_Alpha_Hand', 'ddl_Alpha_Hand'}});
% submit(job)
% job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{X(1), X(2), X(3), X(4), X(5), X(6), X(7), X(8), X(9), X(10), ...
    'file', 'find_Dds.m', 'outputs', ...
    {'ddalpha_Body', 'ddbeta_Body', 'ddgamma_Body', 'ddr_Alpha_Hand', 'ddr_Beta_Hand', 'ddl_Alpha_Hand', 'ddl_Beta_Hand', 'ddx_Head', 'ddy_Head', 'ddz_Head'}});
submit(job)
job.Tasks

% job = createJob(c);
% createTask(job, @matlabFunction, 1,{X(1), X(2), X(3), X(4), X(5), X(6), X(7), X(8), X(9), X(10), ...
%     'file', 'find_Dds.m', 'outputs', ...
%     {'ddoffset_Body', 'ddalpha_Body', 'ddbeta_Body', 'ddgamma_Body', 'ddr_Alpha_Hand', 'ddr_Beta_Hand', 'ddr_Gamma_Hand', 'ddl_Alpha_Hand', 'ddl_Beta_Hand', 'ddl_Gamma_Hand'}});
% submit(job)
% job.Tasks







































