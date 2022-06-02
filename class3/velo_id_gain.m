%%velo_id_gain.m

%% Initialize
clear all
close all

%%Parameters
ts = 1/50;
u_ini 1.0;r_const = 0.7;p_const = 0.7;s_time = 10;w_time = 4;

%% Define input voltage list
u_ref_list = 1:0.125:2.5;
t_end = s_time + w_time;

%% Open simulink model
open_system('velo_id_gain');
open_system('velo_id_gain/Output');

%% Start experiment
y_mean_list = [];
for i=1:length(u_ref_list)
    u_ref = u_ref_list(i);
    z = sim('velo_id_gain');
    t = z.yout.time;
    y = z.yout.signals.values;
    y_mean = mean(y(250:end));
    fprintf('y_mean = %f\n',y_mean);
    y_mean_list(i) = y_mean;
    % Plot figure
    figure(1)
    plot(t,y,t,ones(size(y))*y_mean,'r');
    xlabel('Time [s]'),ylabel('Velocity {V]')
    axis([0 10 0 3])
    drawnow
end

%% Plot data
figure(2)
plot(u_ref_list,y_mean_list,'bo')
xlabel('Input voltage [V]')
ylabel('Velocity [V]')
axis([0 3 0 3])

%% Calculate parameters
While(1)
    disp('Please input Umit and Umax for fit')
    umin = input('Umin = ');
    umax = input('Umax = ');
    sidx = min(find(u_ref_list >= umin));
    eidx = max(find(u_ref_list <= umax));
    P = polyfit(u_ref_list(sidx:eidx),y_mean_list(sidx:eidx),1);
    Pin = 0:3;
    Pout = P(1)*Pin + P(2);
    u_offset = -P(2)/P(1);
    fprintf('*** Motor paramters ***\n')
    fprintf('K       =%f\n',P(1));
    fprintf('u_offset = %f\n',u_offset);
    
    figure(2)
    plot(u_ref_list,y_mean_list,'o',u_ref_list(sidx:eidx),y_mean_list(sidx:eidx),'ro',Pin,Pout,'r-')
    Xlabel('Input voltage [V]')
    ylabel('Velocity [V]')
    axis([0 3 0 3])
    
    sw = input('OK? (1:Quit,2:Retry) = ');
    switch sw
        case 1;
            break;
        case 2;
            continue;
    end
    end

%% EOF of velo_id_gain.m
    
    