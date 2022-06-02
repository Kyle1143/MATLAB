%% pos_id_step.
clear all;clc;

%% Initialize
% load sim_param

%% Parameters for identification
ts = 1/50;
r = 60;
r_cyc = 8;
Kp_id = 0.2;
Ncyc = 4;
tfinal = r_cyc*Ncyc;

%% ID Experiment
open_system('pos_id_step_simu');
z = sim('pos_id_step_simu');
y=z.yout.signals(1).values(:,2);
t=z.yout.time;

%% データの整理
clc;
NN=length(y);
N=r_cyc/ts;
yy=reshape(y(2:NN),N,(NN-1)/N);
yf=yy(1:N/2,2:end);
ym=mean(yf')';
y0=yf(1);
yN=yf(end);
ym=(ym-y0)/(yN-y0);

%% 描画
t=(0:N/2-1)*ts;
figure(1);clf(1);
subplot(2,1,1);
plot(t,yf,'LineWidth',1.2);
grid;
xlabel('Time[s]');
ylabel('Theta-pot[deg]');
set(gca,'FontName','Time New Roman','FontSize',14);
subplot(2,1,2);
plot(t,ym,'LineWidth',1.2);
grid;
xlabel('Time[s]');
ylabel('Ave-Theta-pot[deg]');
set(gcf,'color','w');
set(gca,'FontName','Time New Roman','FontSize',14);

