%% pos_id_step_fit.m
% fminsearchを用いた角度制御系の同定実験

clc;
Lt=2.5;        %値を変えて実験
ts=1/50;
L=Lt/ts;
y_fit=ym(1:L);
t_fit=(0:L-1)*ts;
x0=[500,0.5];

%% 最適化計算の実施
xmin=fminsearch(@(x) myfunc(x,y_fit,t_fit,ts,Kp_id),x0);

%% シミュレーションデータの作成
K_id=xmin(1);
T_id=xmin(2);
P=tf([0,0,K_id],[T_id,1,0]);
Pd=c2d(P,ts,'zoh');
Ld=Pd*Kp_id;
Gd=feedback(Ld,1);
ymodel = step(Gd,t);

%% 描画＆表示
figure(2);clf(2);
plot(t,ym,'k--',t_fit,y_fit,'b*',t,ymodel,'r-');
grid on;
xlabel('Time [s]');ylabel('Angle [deg]');
legend('Real angle','Fitted angle','Model angle');
set(gcf,'color','w');
set(gca,'Fontname','Times New Roman','FontSize',14);

fprintf('K=%3.1f\n',K_id)
fprintf('T=%3.3f\n',T_id)

