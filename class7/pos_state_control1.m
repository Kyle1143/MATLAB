%% pos_state_control1.m
%% 現代制御理論を用いた角度制御
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

%% シミュレーション
open_system('pos_state_control_simu');
set_param('pos_state_control_simu','WideLines','on'); %非スカラライン
set_param('pos_state_control_simu','ShowLineDimensions','on'); %次元表示
theta0=0;
omega0=0;
x0=[theta0;omega0]; %初期値
z=sim('pos_state_control_simu');

