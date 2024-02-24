clearvars ; clc ; close all

%%

Data1 = load('Data/guy.mat').AngularVelocity;
Data2 = load('Data/shir.mat').AngularVelocity;

time1  = seconds(Data1.Timestamp - Data1.Timestamp(1));
Omega1 = [Data1.X, Data1.Y, Data1.Z];

time2  = seconds(Data2.Timestamp - Data2.Timestamp(1));
Omega2 = [Data2.X, Data2.Y, Data2.Z];

clear Data1 Data2

bias_lrn_strt =  2;
bias_lrn_stop = 12;

bias1 = mean( Omega1( (time1 >= bias_lrn_strt) & ...
                      (time1 <= bias_lrn_stop), : ) );
bias2 = mean( Omega2( (time2 >= bias_lrn_strt) & ...
                      (time2 <= bias_lrn_stop), : ) );

rlvnt_strt = 33.2;
rlvnt_stop = 51;

Omega1 = Omega1( (time1 >= rlvnt_strt) & (time1 <= rlvnt_stop) ) - bias1;
Omega2 = Omega2( (time2 >= rlvnt_strt) & (time2 <= rlvnt_stop) ) - bias2;



