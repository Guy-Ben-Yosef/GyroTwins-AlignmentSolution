clearvars ; clc ; close all

%%

Data1 = load('Data/guy.mat').AngularVelocity;
Data2 = load('Data/shir.mat').AngularVelocity;

time1  = seconds(Data1.Timestamp - Data1.Timestamp(1));
Omega1 = [Data1.X, Data1.Y, Data1.Z];

dt = 0.04;
time2  = seconds(Data2.Timestamp - Data2.Timestamp(1)) + dt;
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

rlvnt_mask1 = (time1 >= rlvnt_strt) & (time1 <= rlvnt_stop);
rlvnt_mask2 = (time2 >= rlvnt_strt) & (time2 <= rlvnt_stop);

time1 = time1( rlvnt_mask1 );
time1 = time1 - time1(1);
time2 = time2( rlvnt_mask2 );
time2 = time2 - time2(1);

Omega1 = Omega1( rlvnt_mask1, : ) - bias1;
Omega2 = Omega2( rlvnt_mask2, : ) - bias2;

[mutual_time, interp_Omega1, interp_Omega2] = interpolateOmega(time1, Omega1, time2, Omega2);
C = calculateRelativeScaleFactor(interp_Omega1, interp_Omega2);
calib_Omega1 = interp_Omega1 * C;
T = calculateRotationMatrix(calib_Omega1, interp_Omega1);
rot_Omega1 = calib_Omega1 * T;

%%
figure
subplot(3,1,1)
title('$x$', 'Interpreter', 'latex')
hold on
plot(mutual_time, rot_Omega1(:, 1), 'LineWidth', 1.5)
plot(mutual_time, interp_Omega2(:, 1), 'LineWidth', 1.5)

grid on

subplot(3,1,2)
title('$y$', 'Interpreter', 'latex')
hold on
plot(mutual_time, rot_Omega1(:, 2), 'LineWidth', 1.5)
plot(mutual_time, interp_Omega2(:, 2), 'LineWidth', 1.5)
grid on

subplot(3,1,3)
title('$z$', 'Interpreter', 'latex')
hold on
plot(mutual_time, rot_Omega1(:, 3), 'LineWidth', 1.5, 'DisplayNam', 'Rotated $\Omega_{1}$')
plot(mutual_time, interp_Omega2(:, 3), 'LineWidth', 1.5, 'DisplayNam', '$\Omega_{2}$')
grid on

legend('Interpreter', 'latex')