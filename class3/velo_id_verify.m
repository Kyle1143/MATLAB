%% velo_id_verify.m

%% Set indentified parameters
K        = K_id; %0.815858;
T        = T_id; %0.480000;

%u_offset = 0.009725;
p_const  = 1.0;r_const = 0.75;
s_time = 10;
t_end = 20;

%% Open simulink model
open_system('velo_id_verify_simu');
open_system('velo_id_verify_simu/Output');

%% Start experiment
z = sim('velo_id_verify_simu');

ref_vt =z.yout.signals(1).values(:,1);
real_vt=z.yout.signals.values(:,1);
model_vt=z.yout.signals.values(:,2);
t = z.yout.time;

figure(3);clf(3);
plot(t,real_vt,t,model_vt,'r--');
grid on;
xlabel('Time [s]'),ylabel('Velocity [V]')

%% Save Parament
save model_data K T u_offset

delete('*,slxc');

