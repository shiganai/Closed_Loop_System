function dotq = ddt(~,q,depth_Body,g,length_Hand,height_Body,k,m_Body,m_Hand,width_Body, r_P_Fixed, l_P_Fixed, tau_Alpha_Body, r_Tau_Alpha_Hand, l_Tau_Alpha_Hand, radius_Hand)
%DDT この関数の概要をここに記述
%   詳細説明をここに記述

r_X_Fixed = r_P_Fixed(1);
r_Y_Fixed = r_P_Fixed(2);
r_Z_Fixed = r_P_Fixed(3);
l_X_Fixed = l_P_Fixed(1);
l_Y_Fixed = l_P_Fixed(2);
l_Z_Fixed = l_P_Fixed(3);

offset_Body = q(1);
doffset_Body = q(2);
alpha_Body = q(3);
dalpha_Body = q(4);
beta_Body = q(5);
dbeta_Body = q(6);
gamma_Body = q(7);
dgamma_Body = q(8);
r_Alpha_Hand = q(9);
dr_Alpha_Hand = q(10);
r_Beta_Hand = q(11);
dr_Beta_Hand = q(12);
r_Gamma_Hand = q(13);
dr_Gamma_Hand = q(14);
l_Alpha_Hand = q(15);
dl_Alpha_Hand = q(16);
l_Beta_Hand = q(17);
dl_Beta_Hand = q(18);
l_Gamma_Hand = q(19);
dl_Gamma_Hand = q(20);

[ddoffset_Body,ddalpha_Body,ddbeta_Body,ddgamma_Body,ddr_Alpha_Hand,ddr_Beta_Hand,ddr_Gamma_Hand,ddl_Alpha_Hand,ddl_Beta_Hand,ddl_Gamma_Hand] = find_Dds(alpha_Body,beta_Body,dalpha_Body,depth_Body,dgamma_Body,doffset_Body,g,gamma_Body,height_Body,k,l_Alpha_Hand,l_Beta_Hand,l_Tau_Alpha_Hand,l_X_Fixed,l_Y_Fixed,l_Z_Fixed,length_Hand,m_Body,m_Hand,offset_Body,r_Alpha_Hand,r_Beta_Hand,r_Tau_Alpha_Hand,r_X_Fixed,r_Y_Fixed,r_Z_Fixed,radius_Hand,tau_Alpha_Body,width_Body);


dotq = [
    doffset_Body, ddoffset_Body, ...
    dalpha_Body, ddalpha_Body, ...
    dbeta_Body, ddbeta_Body, ...
    dgamma_Body, ddgamma_Body, ...
    dr_Alpha_Hand, ddr_Alpha_Hand, ...
    dr_Beta_Hand, ddr_Beta_Hand, ...
    dr_Gamma_Hand, ddr_Gamma_Hand, ...
    dl_Alpha_Hand, ddl_Alpha_Hand, ...
    dl_Beta_Hand, ddl_Beta_Hand, ...
    dl_Gamma_Hand, ddl_Gamma_Hand, ...
    ]';
end

