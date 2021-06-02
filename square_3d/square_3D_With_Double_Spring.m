
clear all
tic

syms l_Arm real
syms th1_Pre(t) th2_Pre(t) th3_Pre(t)
syms phi1_Pre(t) phi2_Pre(t) phi3_Pre(t)
syms m0 m1 m2 m3 real
syms g real
syms tau1 tau2 tau3 real
syms f_X f_Y f_Z real

syms x_Pre(t) y_Pre(t) z_Pre(t)
syms x dx ddx real
syms y dy ddy real
syms z dz ddz real

syms th1 dth1 ddth1 real
syms th2 dth2 ddth2 real
syms th3 dth3 ddth3 real
syms phi1 dphi1 ddphi1 real
syms phi2 dphi2 ddphi2 real
syms phi3 dphi3 ddphi3 real

syms k real
syms x0_Fixed y0_Fixed z0_Fixed real
syms x3_Fixed y3_Fixed z3_Fixed real

syms_Replaced = [
    th1_Pre, diff(th1_Pre, t), diff(th1_Pre, t, t), ...
    th2_Pre, diff(th2_Pre, t), diff(th2_Pre, t, t), ...
    th3_Pre, diff(th3_Pre, t), diff(th3_Pre, t, t), ...
    phi1_Pre, diff(phi1_Pre, t), diff(phi1_Pre, t, t), ...
    phi2_Pre, diff(phi2_Pre, t), diff(phi2_Pre, t, t), ...
    phi3_Pre, diff(phi3_Pre, t), diff(phi3_Pre, t, t), ...
    x_Pre, diff(x_Pre, t), diff(x_Pre, t, t), ...
    y_Pre, diff(y_Pre, t), diff(y_Pre, t, t), ...
    z_Pre, diff(z_Pre, t), diff(z_Pre, t, t), ...
    ];

syms_Replacing = [
    th1, dth1, ddth1, ...
    th2, dth2, ddth2, ...
    th3, dth3, ddth3, ...
    phi1, dphi1, ddphi1, ...
    phi2, dphi2, ddphi2, ...
    phi3, dphi3, ddphi3, ...
    x dx ddx, ...
    y dy ddy, ...
    z dz ddz, ...
    ];

symfun_One = symfun(1, t);
symfun_Zero = symfun(0, t);

p0 = [x_Pre, y_Pre, z_Pre];
p1 = p0 + l_Arm * [sin(th1_Pre) * cos(phi1_Pre), sin(th1_Pre) * sin(phi1_Pre), cos(th1_Pre)];
p2 = p1 + l_Arm * [sin(th2_Pre) * cos(phi2_Pre), sin(th2_Pre) * sin(phi2_Pre), cos(th2_Pre)];
p3 = p2 + l_Arm * [sin(th3_Pre) * cos(phi3_Pre), sin(th3_Pre) * sin(phi3_Pre), cos(th3_Pre)];

p0_Fixed = [x0_Fixed, y0_Fixed, z0_Fixed];
p3_Fixed = [x3_Fixed, y3_Fixed, z3_Fixed];

%% Solve Newton Eq

p0 = formula(p0);
p1 = formula(p1);
p2 = formula(p2);
p3 = formula(p3);

v0 = diff(p0);
v1 = diff(p1);
v2 = diff(p2);
v3 = diff(p3);

T = 1/2 * m0 * (v0 * v0') ...
    + 1/2 * m1 * (v1 * v1') ...
    + 1/2 * m2 * (v2 * v2') ...
    + 1/2 * m3 * (v3 * v3') ...
    ;
U = (p0(3) * m0 + p1(3) * m1 + p2(3) * m2 + p3(3) * m3) * g...
    + 1/2 * k * ((p0 - p0_Fixed) * (p0 - p0_Fixed)')...
    + 1/2 * k * ((p3 - p3_Fixed) * (p3 - p3_Fixed)')...
    ;
L = T - U;

M = m0 * v0 + m1 * v1 + m2 * v2 + m3 * v3;
d_M = diff(M, t);

equations = [
    -functionalDerivative(L, th1_Pre) == tau1;
    -functionalDerivative(L, th2_Pre) == tau2;
    -functionalDerivative(L, th3_Pre) == tau3;
    -functionalDerivative(L, phi1_Pre) == 0;
    -functionalDerivative(L, phi2_Pre) == 0;
    -functionalDerivative(L, phi3_Pre) == 0;
    -functionalDerivative(L, x_Pre) == 0;
    -functionalDerivative(L, y_Pre) == 0;
    -functionalDerivative(L, z_Pre) == 0;
    ];

% Convert th1_Pre(t) into th1 which does not depend on t
equations = subs(equations, syms_Replaced, syms_Replacing);
d_M = subs(d_M, syms_Replaced, syms_Replacing);
toc

tic
variables = [ddth1, ddth2, ddth3, ddphi1, ddphi2, ddphi3, ddx, ddy, ddz];
[A,B] = equationsToMatrix(equations, variables);
sol = inv(A) * B;
toc

tic
ddth1_Eq = sol(1);
ddth2_Eq = sol(2);
ddth3_Eq = sol(3);
ddphi1_Eq = sol(4);
ddphi2_Eq = sol(5);
ddphi3_Eq = sol(6);
x_Eq = sol(7);
y_Eq = sol(8);
z_Eq = sol(9);
toc

% tic
% d_M = subs(d_M, variables, sol');
% toc

parallel.defaultClusterProfile('local');
c = parcluster();

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddth1_Eq, ddth2_Eq, ddth3_Eq, ddphi1_Eq, ddphi2_Eq, ddphi3_Eq, x_Eq, y_Eq, z_Eq, ...
    'file', 'find_Dds_With_Double_Spring.m', 'outputs', ...
    {'ddth1', 'ddth2', 'ddth3', 'ddphi1', 'ddphi2', 'ddphi3', 'ddx', 'ddy', 'ddz'}});
submit(job)
job.Tasks

% job = createJob(c);
% createTask(job, @matlabFunction, 1,{formula(d_M), 'file', 'find_D_M.m', 'outputs', {'d_M'}});
% submit(job)
% job.Tasks

% tic
% matlabFunction(ddth1_Eq, ddth2_Eq, ddth3_Eq, ddphi1_Eq, ddphi2_Eq, ddphi3_Eq, 'file', 'find_Dds_With_Spring.m', 'outputs', {'ddth1', 'ddth2', 'ddth3', 'ddphi1', 'ddphi2', 'ddphi3'})
% toc
% matlabFunction(ddth1_Eq, ddth2_Eq, ddth3_Eq, ddphi1_Eq, ddphi2_Eq, ddphi3_Eq, 'file', 'find_Dds.m', 'outputs', {'ddth1', 'ddth2', 'ddth3', 'ddphi1', 'ddphi2', 'ddphi3'})
























