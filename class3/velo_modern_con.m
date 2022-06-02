%% velo_modern_con.m指定する場合
ts = 1/50;
K        = K_id;
T        = T_id;
u_offset = u_offset;

%%　状態空間モデル
A=-1/T;B=K/T;C=1;
A_bar=[A,0;-C,0];B_bar=[B;0];

%%　サーボ系設計
p1=-2;p2=-8;pole=[p1,p2];
F_bar=place(A_bar,B_bar,pole);
F=F_bar(1),Ki=-F_bar(2),

%% シミュレーションと実験の実行
open_system('velo_pi_modern_con_simu');
open_system('velo_pi_modern_con_simu/Output');
z = sim('velo_pi_modern_con_simu');

%% 描画

ref_vt = z.yout.signals(1).values(:,1);
real_vt = z.yout.signals(1).values(:,2);
model_vt = z.yout.signals(1).values(:,3);
t = z.yout.time;

figure(6);clf(6);
plot(t,ref_vt,'b--',t,real_vt,'k',t,model_vt,'r-','LineWidth',1.2)
grid on;
xlim([0, t_end]);
xlabel('Time [s]'),ylabel('Velocity [V]');
legend('Ref-vt','real Vt','Model Vt');
set(gcf,'color','w');
set(gca,'Fontname','Time New Roman','FontSize',14);

real_va = z.yout.signals(2).values(:,1);
model_va = z.yout.signals(2).values(:,2);
t = z.yout.time;

figure(7);clf(7);
plot(t,real_va,'k',t,model_va,'r-','LineWidth',1.2)
grid on;
xlim([0, t_end]);
xlabel('Time [s]'),ylabel('Driving Velocity [V]');
legend('real Va','Model Va');
set(gcf,'color','w');
set(gca,'Fontname','Time New Roman','FontSize',14);

save model_data K T u_offset

delete('*.slxc');

%% EOF of velo_modern_con.m
