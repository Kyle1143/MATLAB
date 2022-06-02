%% velo_modern_con.m指定する場合

ts = 1/50;
K        = K_id;
T        = T_id;
u_offset = u_offset;


%%状態空間モデル
A=-1/T;B=K/T;C=1;
A_bar=[A,0;-C,0];B_bar=[B;0];
p1=-2;p2=-4;pole=[p1,p2];
F_bar=place(A_bar,B_bar,pole);
F=F_bar(1),Ki=-F_bar(2),








