%%velo_id_tc.m

%% Initialize
clear all
close all

%%Parameters
ts = 1/50;
u_ini=1.5;r_const = 1.3;p_const = 0.5;
s_time = 10;w_time = 4;
t_end = s_time + w_time*2;

%% Open simulink model
open_system('velo_id_tc_simu');
open_system('velo_id_tc_simu/Output');
z = sim('velo_id_tc_simu');

y = z.yout.signals.values;
t = z.yout.time;
c1=mean(y(w_time/ts:s_time/ts));
c2=mean(y((s_time+w_time)/ts:end));

figure(1);clf(1);
plot(t,y,t,ones(size(t))*c1,'r--',t,ones(size(t))*c2,'r--');
grid on;
xlabel('Time [s]'),ylabel('Velocity {V]')

%% システム同定の実行
K_id = (c2-c1)/p_const;
u_offset = (K_id*r_const-c1)/K_id;

%%描画と表示
y2 = y(s_time/ts:end)-c1;
t2 = t(s_time/ts:end);
t2=t2-t2(1);

tc_idx = min(find(y2 > (c2 - c1)*0.632));
T_id = t2(tc_idx);

figure(2);clf(2);
plot(t2,y2,'.',T_id,(c2-c1)*0.632,'ro',t2,ones(size(t2))*(c2-c1),'r--')
grid on;
xlim([0, w_time])
xlabel('Time [s]'),ylabel('Velocity [V]')

fprintf('-- Results == \n')
fprintf('K       =  %f\n',K_id)
fprintf('T       =  %f\n',T_id)
fprintf('u_offset = %f\n',u_offset)
    
delete('*,slxc');

