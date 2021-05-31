
clear all

syms l_Arm real
syms th1_Pre(t) th2_Pre(t) th3_Pre(t)
syms m1 m2 m3 real
syms g real
syms tau1 tau2 tau3 real
syms f_X f_Y real

syms x_Pre(t) y_Pre(t)
syms x dx ddx real
syms y dy ddy real

syms th1 dth1 ddth1 real
syms th2 dth2 ddth2 real
syms th3 dth3 ddth3 real

syms_Replaced = [
    th1_Pre, diff(th1_Pre, t), diff(th1_Pre, t, t), ...
    th2_Pre, diff(th2_Pre, t), diff(th2_Pre, t, t), ...
    th3_Pre, diff(th3_Pre, t), diff(th3_Pre, t, t), ...
    x_Pre, diff(x_Pre, t), diff(x_Pre, t, t), ...
    y_Pre, diff(y_Pre, t), diff(y_Pre, t, t), ...
    ];

syms_Replacing = [
    th1, dth1, ddth1, ...
    th2, dth2, ddth2, ...
    th3, dth3, ddth3, ...
    x dx ddx, ...
    y dy ddy, ...
    ];

%% Solve Restraint
symfun_One = symfun(1, t);
symfun_Zero = symfun(0, t);

p1 = [x_Pre, y_Pre] + l_Arm * [cos(th1_Pre), sin(th1_Pre)];
p2 = p1 + l_Arm * [cos(th2_Pre), sin(th2_Pre)];
p3 = p2 + l_Arm * [cos(th3_Pre), sin(th3_Pre)];

restraint = p3' == [x_Pre, y_Pre]';
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
U = (p1(2) * m1 + p2(2) * m2 + p3(2) * m3) * g;
L = T - U;

M = m1 * v1 + m2 * v2 + m3 * v3;
d_M = diff(M, t);

F_X = -functionalDerivative(L, x_Pre) - (f_X * diff(p3(1), x_Pre) + f_Y * diff(p3(2), x_Pre));
F_Y = -functionalDerivative(L, y_Pre) - (f_X * diff(p3(1), y_Pre) + f_Y * diff(p3(2), y_Pre));

% Apply x = y = 0
L = subs(L, [x_Pre, y_Pre], sym([0, 0]));
restraint = subs(restraint, [x_Pre, y_Pre], sym([0, 0]));
F_X = subs(F_X, [x_Pre, y_Pre], sym([0, 0]));
F_Y = subs(F_Y, [x_Pre, y_Pre], sym([0, 0]));
d_M = subs(d_M, [x_Pre, y_Pre], sym([0, 0]));


equations = [
    restraint;
    -functionalDerivative(L, th1_Pre(t)) == tau1 + f_X * diff(p3(1), th1_Pre) + f_Y * diff(p3(2), th1_Pre);
    -functionalDerivative(L, th2_Pre(t)) == tau2 + f_X * diff(p3(1), th2_Pre) + f_Y * diff(p3(2), th2_Pre);
    -functionalDerivative(L, th3_Pre(t)) == tau3 + f_X * diff(p3(1), th3_Pre) + f_Y * diff(p3(2), th3_Pre);
    ];

equations = subs(equations, syms_Replaced, syms_Replacing);
F_X = subs(F_X, syms_Replaced, syms_Replacing);
F_Y = subs(F_Y, syms_Replaced, syms_Replacing);
d_M = subs(d_M, syms_Replaced, syms_Replacing);

variables = [ddth1, ddth2, ddth3, f_X, f_Y];
[A,B] = equationsToMatrix(equations, variables);
isequal(det(A), 0)
sol = inv(A) * B;

f_X_Eq = sol(4);
f_Y_Eq = sol(5);

F_X = subs(F_X, variables, sol');
F_Y = subs(F_Y, variables, sol');
d_M = subs(d_M, variables, sol');

simplify(d_M - [F_X + f_X_Eq, F_Y + f_Y_Eq])

% matlabFunction(simplify(sol(1)), simplify(sol(2)), simplify(sol(3)), 'file', 'find_Dds_Triangle_2D_Force.m', 'outputs', {'ddth1', 'ddth2', 'ddth3'})










































