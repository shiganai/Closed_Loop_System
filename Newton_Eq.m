
syms l_Arm real
syms g real
syms phi_L_Pre phi_R_Pre real
syms th_L_Pre th_R_Pre real
syms tau_th_L tau_th_R real

p_L = l_Arm * [sin(phi_L_Pre) * sin(th_L_Pre), -sin(phi_L_Pre) * cos(th_L_Pre), cos(phi_L_Pre)];
p_R = l_Arm * [sin(phi_R_Pre) * sin(th_R_Pre), -sin(phi_R_Pre) * cos(th_R_Pre), cos(phi_R_Pre)];

diff_Lr = p_R - p_L;
a = diff_Lr * diff_Lr' == l_Arm^2;
solve(a, phi_L_Pre)



















































