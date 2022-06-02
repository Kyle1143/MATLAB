%% velo_pi_mbd.m指定する場合

ts = 1/50;
K        = K_id;
T        = T_id;
u_offset = u_offset;
delta = 0;
p_const  = 1.0;
s_time = 5;t_end = 15;

% Pi design by pole placement;
p1 = -2;
p2 = -4; 

Kp = -((p1+p2)*T+1)/K;
Ki = p1*p2/K;

%% Open simulink model
open_system('velo_pi_mbd_simu');
open_system('velo_pi_mbd_simu/Output');

%% Experiment
z = sim('velo_pi_mbd_simu');

ref_vt = z.yout.signals(1).values(:,1);
real_vt = z.yout.signals(1).values(:,2);
model_vt = z.yout.signals(1).values(:,3);
t = z.yout.time;

figure(4);clf(4);
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

figure(5);clf(5);
plot(t,real_va,'k',t,model_va,'r-','LineWidth',1.2)
grid on;
xlim([0, t_end]);
xlabel('Time [s]'),ylabel('Driving Velocity [V]');
legend('real Va','Model Va');
set(gcf,'color','w');
set(gca,'Fontname','Time New Roman','FontSize',14);

save model_data K T u_offset

delete('*.slxc');

%% EOF of velo_pi_mbd.m
