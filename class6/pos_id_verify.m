%% pos_id_verify.m

%% 同定実験で求めたパラメータ
K=26.1;
T=0.152;

%% 離散時間制御対象モデル(=ディジタルモデル)
s=tf('s');
ts=1/50;
P=K/(T*s^2+s);
Pd=c2d(P,ts,'zoh');
[numd,dend]=tfdata(Pd,'v');

%% 実行時間と制御ゲイン
tfinal=16;
Kp=Kp_id;
Ki=0;
Kd=0;

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

