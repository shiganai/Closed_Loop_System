
clear all

d_rad_tmp = 0;
% d_rad_tmp = 5e-2;

% 原点を作成
All_Bodies = rigidBodyTree('DataFormat','row'); % 変数の情報を横に並べるという設定付き
All_Bodies.BaseName = 'Global_Origin';
All_Bodies.Gravity = [0, 0, -9.81];

% 原点に蝶番関節を持つ点1を作成
Point1_revolute = rigidBody('Point1');
joint_GO_P1O = rigidBodyJoint('joint_Global_Origin_Point1_Origin', 'revolute');
joint_GO_P1O.JointAxis = [1,0,0];
% joint_GO_P1O.HomePosition = d_rad_tmp;
joint_GO_P1O.HomePosition = 1/2*pi;
Vec_From_GO_To_P1O = trvec2tform([0,0,0]);
setFixedTransform(joint_GO_P1O, Vec_From_GO_To_P1O);
Point1_revolute.Mass = 0;
Point1_revolute.Inertia = [0,0,0,0,0,0];
Point1_revolute.CenterOfMass = [0,0,0];
Point1_revolute.Joint = joint_GO_P1O;

% 点1に蝶番関節を持つ点2を作成
Point2_revolute = rigidBody('Point2');
joint_P1O_P2O = rigidBodyJoint('joint_Point1_Origin_Point2_Origin', 'revolute');
joint_P1O_P2O.JointAxis = [0,1,0];
% joint_P1O_P2O.HomePosition = d_rad_tmp;
joint_P1O_P2O.HomePosition = 1/6*pi;
Vec_From_P1O_To_P2O = trvec2tform([0,0,0]);
setFixedTransform(joint_P1O_P2O, Vec_From_P1O_To_P2O);
Point2_revolute.Mass = 0;
Point2_revolute.Inertia = [0,0,0,0,0,0];
Point2_revolute.CenterOfMass = [0,0,0];
Point2_revolute.Joint = joint_P1O_P2O;

% 点2の先に接続する質点1の作成
MassPoint1 = rigidBody('MassPoint1');
joint_P2O_MP1O = rigidBodyJoint('joint_Stick1_Origin_MassPoint1_Origin', 'fixed');
Vec_From_P2O_To_MP1O = trvec2tform([0, 0 ,1]);
setFixedTransform(joint_P2O_MP1O, Vec_From_P2O_To_MP1O);
MassPoint1.Mass = 1;
MassPoint1.Inertia = [0,0,0,0,0,0];
MassPoint1.CenterOfMass = [0, 0, 0];
MassPoint1.Joint = joint_P2O_MP1O;

% 質点に蝶番関節を持つ点11を作成
Point11_revolute = rigidBody('Point11');
joint_MP1O_P11O = rigidBodyJoint('joint_MassPoint1_Origin_Point11_Origin', 'revolute');
joint_MP1O_P11O.JointAxis = [1,0,0];
% joint_P1O_P2O.HomePosition = d_rad_tmp;
joint_MP1O_P11O.HomePosition = 0;
Vec_From_MP1O_To_P11O = trvec2tform([0,0,0]);
setFixedTransform(joint_MP1O_P11O, Vec_From_MP1O_To_P11O);
Point11_revolute.Mass = 0;
Point11_revolute.Inertia = [0,0,0,0,0,0];
Point11_revolute.CenterOfMass = [0,0,0];
Point11_revolute.Joint = joint_MP1O_P11O;

% 点11に蝶番関節を持つ点12を作成
Point12_revolute = rigidBody('Point12');
joint_P11O_P12O = rigidBodyJoint('joint_Point11_Origin_Point12_Origin', 'revolute');
joint_P11O_P12O.JointAxis = [0,1,0];
% joint_P1O_P2O.HomePosition = d_rad_tmp;
joint_P11O_P12O.HomePosition = 2/3 * pi;
Vec_From_P11O_To_P12O = trvec2tform([0,0,0]);
setFixedTransform(joint_P11O_P12O, Vec_From_P11O_To_P12O);
Point12_revolute.Mass = 0;
Point12_revolute.Inertia = [0,0,0,0,0,0];
Point12_revolute.CenterOfMass = [0,0,0];
Point12_revolute.Joint = joint_P11O_P12O;

% 点2の先に接続する質点2の作成
MassPoint2 = rigidBody('MassPoint2');
joint_P12O_MP2O = rigidBodyJoint('joint_Stick2_Origin_MassPoint12_Origin', 'fixed');
Vec_From_P12O_To_MP2O = trvec2tform([0, 0 ,1]);
setFixedTransform(joint_P12O_MP2O, Vec_From_P12O_To_MP2O);
MassPoint2.Mass = 1;
MassPoint2.Inertia = [0,0,0,0,0,0];
MassPoint2.CenterOfMass = [0, 0, 0];
MassPoint2.Joint = joint_P12O_MP2O;

% 原点から腕を伸ばす
Point21 = rigidBody('Point21');
joint_GO_P21O = rigidBodyJoint('joint_Global_Origin_Point21_Origin', 'fixed');
Vec_From_GO_To_P21O = trvec2tform([1, 0 ,0]);
setFixedTransform(joint_GO_P21O, Vec_From_GO_To_P21O);
Point21.Mass = 0;
Point21.Inertia = [0,0,0,0,0,0];
Point21.CenterOfMass = [0, 0, 0];
Point21.Joint = joint_GO_P21O;

% 原点から伸ばした腕の先に点22を作る
Point22 = rigidBody('Point22');
joint_P21O_P22O = rigidBodyJoint('joint_P21_Origin_Point22_Origin', 'fixed');
Vec_From_P21O_To_P22O = trvec2tform([0, 0 ,0]);
setFixedTransform(joint_GO_P21O, Vec_From_P21O_To_P22O);
Point22.Mass = 0;
Point22.Inertia = [0,0,0,0,0,0];
Point22.CenterOfMass = [0, 0, 0];
Point22.Joint = joint_P21O_P22O;



addBody(All_Bodies, Point1_revolute, 'Global_Origin') % 点1を原点につなげる
addBody(All_Bodies, Point2_revolute, 'Point1') % 点2を点1につなげる
addBody(All_Bodies, MassPoint1, 'Point2') % 質点1を点3につなげる
addBody(All_Bodies, Point11_revolute, 'MassPoint1') % 点11を質点につなげる
addBody(All_Bodies, Point12_revolute, 'Point11') % 点2を点1につなげる
addBody(All_Bodies, MassPoint2, 'Point12') % 質点2を点3につなげる
addBody(All_Bodies, Point21, 'Global_Origin') % 腕を原点から伸ばす
addBody(All_Bodies, Point22, 'Point21') % 腕の先に点22を作る
addBody(All_Bodies, Point22, 'MassPoint2') % 質点2の先にも点22を作る


wrench = [0, 0, 0, 0, 0, 0]; % 質点1に作用させる(正確には質点1のローカル座標原点, 方向もローカル座標系で表される)に作用させる力ベクトル [Tx Ty Tz Fx Fy Fz]

HomeConfig = homeConfiguration(All_Bodies); % ホームポジションの獲得, joint_GO_S1O.HomePosition = 1/4*pi; のおかげで 1/4*pi 出力される, 他にも変数がった場合 [変数1, 変数2. ...] と列ベクトルで出力される
VariableNum = size(HomeConfig,2);
fext = externalForce(All_Bodies, 'MassPoint1', wrench, HomeConfig); % qの表す状態で, 質点1に作用させるという宣言

G_Position = centerOfMass(All_Bodies, HomeConfig) % 重心の獲得
dockfig(1)
show(All_Bodies, 'PreservePlot', false); % 絶対座標系、ローカル座標系をそれぞれプロットしてくれる
view(2)
hold on
plot3(G_Position(1), G_Position(2), G_Position(3), 'or') % 重心のプロット
hold off
qddot = forwardDynamics(All_Bodies, HomeConfig, [], [], fext) % figure(1)に表示されている状態での 加速度










































