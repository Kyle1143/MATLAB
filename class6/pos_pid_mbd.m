%% pos_pid_mbd.m

%% 同定実験で求めたパラメータ
K=37.5;
T=0.107;

%% 離散時間制御対象モデル(=ディジタルモデル)
s=tf('s');
ts=1/50;
P=K/(T*s^2+s);
Pd=c2d(P,ts,'zoh');
[numd,dend]=tfdata(Pd,'v');

%% 実行時間と制御ゲイン
tfinal=16;
omega_n=10;
zeta=0.95;
alpha=1.5;
%
p1=(-zeta+j*sqrt(1-zeta^2))*omega_n;
p2=(-zeta-j*sqrt(1-zeta^2))*omega_n;
p3=-alpha;
%
Kp=(p1*p2+p2*p3+p3*p1)*T/K;
Kd=-((p1+p2+p3)*T+1)/K;
Ki=-p1*p2*p3*T/K;

%% 実験検証
open_system('pos_pid_simu');
z=sim('pos_pid_simu');

%% 描画
ref=z.yout.signals(1).values(:,1);
y=z.yout.signals(1).values(:,2);
y_model=z.yout.signals(1).values(:,3);
t=z.yout.time;
figure(3);clf(3);
plot(t,ref,'k--',t,y,'r',t,y_model,'b-.');
grid on;
legend('Angle_ref','Real Angle','Model Angle');
axis([0,tfinal,-80,80]);
xlabel('Time [s]');ylabel('Angle [deg]');

set(gcf,'color','w');
set(gca,'Fontname','Times New Roman','FontSize',14);
