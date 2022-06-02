%% pos_state_control.m
%% 現代制御理論を用いた角度制御実験
clear all;clc;

%% 物理パラメータと基本設定
K=37.5;   
T=0.107;

ts = 1/50;
r = 60;
r_cyc = 8;
Ncyc = 4;
tfinal = r_cyc*Ncyc;

%% 状態空間モデル
A=[0,1;0,-1/T];
B=[0;K/T];
C=[1,0];
D=0;

%% サーボ系設計
A_bar=[A,zeros(2,1);-C,0];
B_bar=[B;0];

% 極指定法(極配置法)
% p1=-3;
% p2=-4;
% p3=-5;
% pole=[p1,p2,p3];
% F_bar=place(A_bar,B_bar,pole);

% 最適制御法(LQ法)
Q=diag([1e2,1e1,2e2]);
R=1;
F_bar=lqr(A_bar,B_bar,Q,R);

EIG=eig(A_bar-B_bar*F_bar);   %eigenvalue=固有値の頭文字
F=F_bar(1:2);
Ki=-F_bar(3);

%% サーボ系シミュレーション
open_system('exp_pos_servo_control_simu');
set_param('exp_pos_servo_control_simu','WideLines','on'); %非スカラライン
set_param('exp_pos_servo_control_simu','ShowLineDimensions','on'); %次元表示
theta0=0;
omega0=0;
x0=[theta0;omega0]; %初期値
z=sim('pos_servo_control_simu');

