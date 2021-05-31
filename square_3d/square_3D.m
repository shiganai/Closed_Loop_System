
clear all
tic

syms l_Arm real
syms th1_Pre(t) th2_Pre(t) th3_Pre(t)
syms phi1_Pre(t) phi2_Pre(t) phi3_Pre(t)
syms m1 m2 m3 real
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

%% Solve Restraint
symfun_One = symfun(1, t);
symfun_Zero = symfun(0, t);

p0 = [x_Pre, y_Pre, z_Pre];
p1 = p0 + l_Arm * [sin(th1_Pre) * cos(phi1_Pre), sin(th1_Pre) * sin(phi1_Pre), cos(th1_Pre)];
p2 = p1 + l_Arm * [sin(th2_Pre) * cos(phi2_Pre), sin(th2_Pre) * sin(phi2_Pre), cos(th2_Pre)];
p3 = p2 + l_Arm * [sin(th3_Pre) * cos(phi3_Pre), sin(th3_Pre) * sin(phi3_Pre), cos(th3_Pre)];

restraint = p3' == p0' + [1, 0, 0]';
restraint = diff(restraint, t, t);

%% Solve Newton Eq

p1 = formula(p1);
p2 = formula(p2);
p3 = formula(p3);

v1 = diff(p1);
v2 = diff(p2);
v3 = diff(p3);

T = 1/2 * m1 * (v1 * v1') ...
    + 1/2 * m2 * (v2 * v2') ...
    + 1/2 * m3 * (v3 * v3') ...
    ;
U = (p1(3) * m1 + p2(3) * m2 + p3(3) * m3) * g...
    ;
L = T - U;

M = m1 * v1 + m2 * v2 + m3 * v3;
d_M = diff(M, t);

F_X = -functionalDerivative(L, x_Pre) - (f_X * diff(p3(1), x_Pre) + f_Y * diff(p3(2), x_Pre) + f_Z * diff(p3(3), x_Pre));
F_Y = -functionalDerivative(L, y_Pre) - (f_X * diff(p3(1), y_Pre) + f_Y * diff(p3(2), y_Pre) + f_Z * diff(p3(3), y_Pre));
F_Z = -functionalDerivative(L, z_Pre) - (f_X * diff(p3(1), z_Pre) + f_Y * diff(p3(2), z_Pre) + f_Z * diff(p3(3), z_Pre));

% Apply x = y = z = 0
L = subs(L, [x_Pre, y_Pre, z_Pre], sym([0, 0, 0]));
restraint = subs(restraint, [x_Pre, y_Pre, z_Pre], sym([0, 0, 0]));
d_M = subs(d_M, [x_Pre, y_Pre, z_Pre], sym([0, 0, 0]));
F_X = subs(F_X, [x_Pre, y_Pre, z_Pre], sym([0, 0, 0]));
F_Y = subs(F_Y, [x_Pre, y_Pre, z_Pre], sym([0, 0, 0]));
F_Z = subs(F_Z, [x_Pre, y_Pre, z_Pre], sym([0, 0, 0]));

equations = [
    restraint;
    -functionalDerivative(L, th1_Pre) == tau1 + f_X * diff(p3(1), th1_Pre) + f_Y * diff(p3(2), th1_Pre) + f_Z * diff(p3(3), th1_Pre);
    -functionalDerivative(L, th2_Pre) == tau2 + f_X * diff(p3(1), th2_Pre) + f_Y * diff(p3(2), th2_Pre) + f_Z * diff(p3(3), th2_Pre);
    -functionalDerivative(L, th3_Pre) == tau3 + f_X * diff(p3(1), th3_Pre) + f_Y * diff(p3(2), th3_Pre) + f_Z * diff(p3(3), th3_Pre);
    -functionalDerivative(L, phi1_Pre) == 0 + f_X * diff(p3(1), phi1_Pre) + f_Y * diff(p3(2), phi1_Pre) + f_Z * diff(p3(3), phi1_Pre);
    -functionalDerivative(L, phi2_Pre) == 0 + f_X * diff(p3(1), phi2_Pre) + f_Y * diff(p3(2), phi2_Pre) + f_Z * diff(p3(3), phi2_Pre);
    -functionalDerivative(L, phi3_Pre) == 0 + f_X * diff(p3(1), phi3_Pre) + f_Y * diff(p3(2), phi3_Pre) + f_Z * diff(p3(3), phi3_Pre);
    ];

% Convert th1_Pre(t) into th1 which does not depend on t
equations = subs(equations, syms_Replaced, syms_Replacing);
F_X = subs(F_X, syms_Replaced, syms_Replacing);
F_Y = subs(F_Y, syms_Replaced, syms_Replacing);
F_Z = subs(F_Z, syms_Replaced, syms_Replacing);
d_M = subs(d_M, syms_Replaced, syms_Replacing);
toc

tic
variables = [ddth1, ddth2, ddth3, ddphi1, ddphi2, ddphi3, f_X, f_Y, f_Z];
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
f_X_Eq = sol(7);
f_Y_Eq = sol(8);
f_Z_Eq = sol(9);
toc

tic
F_X = subs(F_X, variables, sol');
toc
tic
F_Y = subs(F_Y, variables, sol');
toc
tic
F_Z = subs(F_Z, variables, sol');
toc
tic
d_M = subs(d_M, variables, sol');
toc

tic
% simplify(d_M - [F_X + f_X_Eq, F_Y + f_Y_Eq, F_Z + f_Z_Eq])
toc

parallel.defaultClusterProfile('local');
c = parcluster();

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddth1_Eq, ddth2_Eq, ddth3_Eq, ddphi1_Eq, ddphi2_Eq, ddphi3_Eq, 'file', 'find_Dds.m', 'outputs', {'ddth1', 'ddth2', 'ddth3', 'ddphi1', 'ddphi2', 'ddphi3'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{formula(f_X_Eq), formula(f_Y_Eq), formula(f_Z_Eq), formula(F_X), formula(F_Y), formula(F_Z), 'file', 'find_Ext_Forces.m', 'outputs', {'f_X', 'f_Y', 'f_Z', 'F_X', 'F_Y', 'F_Z'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{formula(d_M), 'file', 'find_D_M.m', 'outputs', {'d_M'}});
submit(job)
job.Tasks

% tic
% matlabFunction(ddth1_Eq, ddth2_Eq, ddth3_Eq, ddphi1_Eq, ddphi2_Eq, ddphi3_Eq, 'file', 'find_Dds_With_Spring.m', 'outputs', {'ddth1', 'ddth2', 'ddth3', 'ddphi1', 'ddphi2', 'ddphi3'})
% toc
% matlabFunction(ddth1_Eq, ddth2_Eq, ddth3_Eq, ddphi1_Eq, ddphi2_Eq, ddphi3_Eq, 'file', 'find_Dds.m', 'outputs', {'ddth1', 'ddth2', 'ddth3', 'ddphi1', 'ddphi2', 'ddphi3'})

























