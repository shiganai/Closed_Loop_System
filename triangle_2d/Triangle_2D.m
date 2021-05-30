
syms l_Arm real
syms th1_Pre(t) th2_Pre(t) th3_Pre(t)
syms m1 m2 m3 real
syms g real
syms tau1 tau2 tau3 real

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
restraint = subs(restraint, syms_Replaced, syms_Replacing);

sol_Restraint = solve(restraint, [th2, th3]);

th2_Eq = simplify(sol_Restraint.th2(1));
th3_Eq = simplify(sol_Restraint.th3(1));

th2_Eq = subs(th2_Eq, syms_Replacing, syms_Replaced);
th3_Eq = subs(th3_Eq, syms_Replacing, syms_Replaced);

partial_Th2_Th1 = diff(th2_Eq, th1_Pre);
partial_Th3_Th1 = diff(th3_Eq, th1_Pre);

if isequal(simplify(diff(th2_Eq, th1_Pre, t)), symfun_Zero)
    partial_Th2_Th1 = subs(diff(th2_Eq, th1_Pre), th1_Pre, 0);
    th2_Eq = simplify(partial_Th2_Th1 * th1_Pre + subs(th2_Eq, th1_Pre, 0));
end
if isequal(simplify(diff(th3_Eq, th1_Pre, t)), symfun_Zero)
    partial_Th3_Th1 = subs(diff(th3_Eq, th1_Pre), th1_Pre, 0);
    th3_Eq = simplify(partial_Th3_Th1 * th1_Pre + subs(th3_Eq, th1_Pre, 0));
end

[th2_Eq; th3_Eq]

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

% Apply restraint
L = subs(L, [th2_Pre, th3_Pre], [th2_Eq, th3_Eq]);
d_M = subs(d_M, [th2_Pre, th3_Pre], [th2_Eq, th3_Eq]);

f_X = -functionalDerivative(L, x_Pre);
f_Y = -functionalDerivative(L, y_Pre);

% Apply x = y = 0
L = subs(L, [x_Pre, y_Pre], sym([0, 0]));

equations = [
    -functionalDerivative(L, th1_Pre) == tau1 + tau2 * partial_Th2_Th1 + tau3 * partial_Th3_Th1; % (tau2 * partial_Th2_Th1) is normalized force
    ];

% Convert th1_Pre(t) into th1 which does not depend on t
equations = subs(equations, syms_Replaced, syms_Replacing);
f_X = subs(f_X, syms_Replaced, syms_Replacing);
f_Y = subs(f_Y, syms_Replaced, syms_Replacing);
d_M = subs(d_M, syms_Replaced, syms_Replacing);

variables = [ddth1];
[A,B] = equationsToMatrix(equations, variables);
sol = simplify(inv(A) * B);

ddth1_Eq = simplify(sol(1));

f_X = subs(f_X, variables, sol');
f_Y = subs(f_Y, variables, sol');
d_M = subs(d_M, variables, sol');

simplify(d_M - [f_X, f_Y - g * (m1 + m2 + m3)])

matlabFunction(ddth1_Eq, 'file', 'find_Triangle_Ddth1.m', 'outputs', {'ddth1'})

th2_Eq = subs(th2_Eq, syms_Replaced, syms_Replacing);
th3_Eq = subs(th3_Eq, syms_Replaced, syms_Replacing);

matlabFunction(th2_Eq, th3_Eq, 'file', 'find_Triangle_Th2_Th3.m', 'outputs', {'th2', 'th3'})

























