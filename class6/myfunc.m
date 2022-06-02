function J=myfunc(x,y,t,ts,Kp_id)
%
K=x(1);
T=x(2);
P=tf([0,0,K],[T,1,0]);
Pd=c2d(P,ts,'zoh');
Ld=Pd*Kp_id;
Gd=feedback(Ld,1);
ysim=step(Gd,t);
J=norm(y-ysim,2);
