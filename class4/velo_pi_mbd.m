%% velo_pi_mbd.m指定する場合

%% Initialize & load data
close all
clear all
K        = K_id;
T        = T_id;
u_offset = u_offset;
delta = 0;
p_const  = 1.0;
s_time = 5;
t_end = 15;

% Pi design by pole placement;
p1 = -2;
p2 = -3; 
% p2 = input('p2 ='); %p2も指定する場合

Kp = -((p1+p2)*T + 1)/K;
Ki = p1*p2*T/K;


%% Display PI paramenters
% disp('>>> PI parameters <<<')
% fprintf('Kp  =%f\n',Kp);
% fprintf('Ki  =%f\n',Ki);

%% Open simulink model
open_system('velo_pi_mbd_simu');
open_system('velo_pi_mbd_simu/Output');

%% Experiment
ts = 1/50;
z = sim('velo_pi_mbd_simu');

ref_vt = z.yout.signals(1).values(:,1);
real_vt = z.yout.signals(1).values(:,2);
model_vt = z.yout.signals(1).values(:,3);
t = z.yout.time;

figure(4);clf(4);
plot(t,ref_vt,'b--',t,real_vt,'ko',t,model_vt,'r-','LineWidth',1.2)
grid on;
xlim([0, w_end]);
xlabel('Time [s]'),ylabel('Velocity [V]');
legend('Ref-vt','real','Model Vt');
set(gcf,'color','w');
set(gca,'Fontname','Time New Roman','FontSize',14);

savemodel_data K T u_offset

delete('*.slxc');

%% EOF of velo_pi_mbd.m
