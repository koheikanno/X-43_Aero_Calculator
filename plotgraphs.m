%% X-43 Final Project Graphs Plotter
%
%
% 12/8/2017

%% Viscosity effect
[cl_v400, cd_v400, q400, a_vec] = x43_dragpolar(8, 20000, 400, -10, 10, 1, 1);
[cl_v800, cd_v800, q800, ~] = x43_dragpolar(8, 20000, 800, -10, 10, 1, 1);
[cl_v1200, cd_v1200, q1200, ~] = x43_dragpolar(8, 20000, 1200, -10, 10, 1, 1);
[cl_v1600, cd_v1600, q1600, ~] = x43_dragpolar(8, 20000, 1600, -10, 10, 1, 1);
[cl_v2000, cd_v2000, q2000, ~] = x43_dragpolar(8, 20000, 2000, -10, 10, 1, 1);
[cl_i, cd_i, qinv, ~] = x43_dragpolar(8, 20000, 200, -10, 10, 1, 0);

q400 = q400 / 1000;
q800 = q800 / 1000;
q1200 = q1200 / 1000;
q1600 = q1600 / 1000;
q2000 = q2000 / 1000;

plot(a_vec, cd_i)
hold on,
plot(a_vec, cd_v400)
hold on,
plot(a_vec, cd_v2000)
grid on,
title('Viscosity Effect on Drag Measured at Mach = 8, Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('CD')
legend('Inviscid', 'Viscous, T(wall) = 400K', 'Viscous, T(wall) = 2000K')

figure,
plot(a_vec, qinv)
hold on,
plot(a_vec, q400)
hold on,
plot(a_vec, q800)
hold on,
plot(a_vec, q1200)
hold on,
plot(a_vec, q1600)
hold on,
plot(a_vec, q2000)
grid on,
title('Heat Transfer on the Surface at Mach = 8, Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('Q dot (kW)')
legend('Inviscid', 'Viscous, T(wall) = 400K', 'Viscous, T(wall) = 800K', 'Viscous, T(wall) = 1200K', 'Viscous, T(wall) = 1600K', 'Viscous, T(wall) = 2000K')

%% Mach effect
[cl_m2, cd_m2, qm2, a_vec] = x43_dragpolar(2, 20000, 1200, -10, 10, 1, 1);
[cl_m4, cd_m4, qm4] = x43_dragpolar(4, 20000, 1200, -10, 10, 1, 1);
[cl_m6, cd_m6, qm6] = x43_dragpolar(6, 20000, 1200, -10, 10, 1, 1);
[cl_m8, cd_m8, qm8] = x43_dragpolar(8, 20000, 1200, -10, 10, 1, 1);
[cl_m10, cd_m10, qm10] = x43_dragpolar(10, 20000, 1200, -10, 10, 1, 1);

[cl_m3, cd_m3, qm3] = x43_dragpolar(3, 20000, 1200, -10, 10, 1, 1);
[cl_m5, cd_m5, qm5] = x43_dragpolar(5, 20000, 1200, -10, 10, 1, 1);
[cl_m7, cd_m7, qm7] = x43_dragpolar(7, 20000, 1200, -10, 10, 1, 1);
[cl_m9, cd_m9, qm9] = x43_dragpolar(9, 20000, 1200, -10, 10, 1, 1);

[~,~,p20k] = atmosisa(20000);
l_m2 = cl_m2 * 0.5 * 1.4 * p20k * 2^2 * 3.65;
l_m4 = cl_m4 * 0.5 * 1.4 * p20k * 4^2 * 3.65;
l_m6 = cl_m6 * 0.5 * 1.4 * p20k * 6^2 * 3.65;
l_m8 = cl_m8 * 0.5 * 1.4 * p20k * 8^2 * 3.65;
l_m10 = cl_m10 * 0.5 * 1.4 * p20k * 10^2 * 3.65;
l_m3 = cl_m3 * 0.5 * 1.4 * p20k * 3^2 * 3.65;
l_m5 = cl_m5 * 0.5 * 1.4 * p20k * 5^2 * 3.65;
l_m7 = cl_m7 * 0.5 * 1.4 * p20k * 7^2 * 3.65;
l_m9 = cl_m9 * 0.5 * 1.4 * p20k * 9^2 * 3.65;

d_m2 = cd_m2 * 0.5 * 1.4 * p20k * 2^2 * 3.65;
d_m4 = cd_m4 * 0.5 * 1.4 * p20k * 4^2 * 3.65;
d_m6 = cd_m6 * 0.5 * 1.4 * p20k * 6^2 * 3.65;
d_m8 = cd_m8 * 0.5 * 1.4 * p20k * 8^2 * 3.65;
d_m10 = cd_m10 * 0.5 * 1.4 * p20k * 10^2 * 3.65;
d_m3 = cd_m3 * 0.5 * 1.4 * p20k * 3^2 * 3.65;
d_m5 = cd_m5 * 0.5 * 1.4 * p20k * 5^2 * 3.65;
d_m7 = cd_m7 * 0.5 * 1.4 * p20k * 7^2 * 3.65;
d_m9 = cd_m9 * 0.5 * 1.4 * p20k * 9^2 * 3.65;

% plot Cl
figure,
plot(a_vec, cl_m2)
hold on,
plot(a_vec, cl_m4)
hold on,
plot(a_vec, cl_m6)
hold on,
plot(a_vec, cl_m8)
hold on,
plot(a_vec, cl_m10)
grid on,
title('Effect of Mach Number on Lift Coefficient Measured at Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('CL')
legend('M2.0', 'M4.0', 'M6.0', 'M8.0', 'M10.0')

% plot LIFT
figure,
plot(a_vec, l_m2)
hold on,
plot(a_vec, l_m4)
hold on,
plot(a_vec, l_m6)
hold on,
plot(a_vec, l_m8)
hold on,
plot(a_vec, l_m10)
grid on,
title('Effect of Mach Number on Lift Measured at Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('Lift (N)')
legend('M2.0', 'M4.0', 'M6.0', 'M8.0', 'M10.0')

% plot Cd
figure,
plot(a_vec, cd_m2)
hold on,
plot(a_vec, cd_m4)
hold on,
plot(a_vec, cd_m6)
hold on,
plot(a_vec, cd_m8)
hold on,
plot(a_vec, cd_m10)
grid on,
title('Effect of Mach Number on Drag Coefficient Measured at Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('CD')
legend('M2.0', 'M4.0', 'M6.0', 'M8.0', 'M10.0')

% plot DRAG
figure,
plot(a_vec, d_m2)
hold on,
plot(a_vec, d_m4)
hold on,
plot(a_vec, d_m6)
hold on,
plot(a_vec, d_m8)
hold on,
plot(a_vec, d_m10)
grid on,
title('Effect of Mach Number on Drag Measured at Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('Drag (N)')
legend('M2.0', 'M4.0', 'M6.0', 'M8.0', 'M10.0')

% plot Cd vs mach
mach_vec = [2 3 4 5 6 7 8 9 10];
cd_mach_vec = [cd_m2(16), cd_m3(16), cd_m4(16), cd_m5(16), cd_m6(16), cd_m7(16), cd_m8(16), cd_m9(16), cd_m10(16)];
figure,
plot(mach_vec, cd_mach_vec)
grid on,
title('Effect of Mach Number on Drag Measured at Altitude = 20,000 m, and Angle of Attack = 0 deg')
xlabel('Mach Number')
ylabel('CD')

% plot Clalpha vs mach
mach_vec = [2 3 4 5 6 7 8 9 10];
clalpha_mach_vec = [(cl_m2(12) - cl_m2(10))/2, (cl_m3(12) - cl_m3(10))/2,...
    (cl_m4(12) - cl_m4(10))/2, (cl_m5(12) - cl_m5(10))/2, (cl_m6(12) - cl_m6(10))/2,...
    (cl_m7(12) - cl_m7(10))/2, (cl_m8(12) - cl_m8(10))/2, (cl_m9(12) - cl_m9(10))/2,...
    (cl_m10(12) - cl_m10(10))/2];
figure,
plot(mach_vec, clalpha_mach_vec)
grid on,
title('Effect of Mach Number on CL alpha Measured at Altitude = 20,000 m')
xlabel('Mach Number')
ylabel('CL_(alpha)')

% plot Cdalpha vs mach
mach_vec = [2 3 4 5 6 7 8 9 10];
cdalpha_mach_vec = [(cd_m2(12) - cd_m2(10))/2, (cd_m3(12) - cd_m3(10))/2,...
    (cd_m4(12) - cd_m4(10))/2, (cd_m5(12) - cd_m5(10))/2, (cd_m6(12) - cd_m6(10))/2,...
    (cd_m7(12) - cd_m7(10))/2, (cd_m8(12) - cd_m8(10))/2, (cd_m9(12) - cd_m9(10))/2,...
    (cd_m10(12) - cd_m10(10))/2];
figure,
plot(mach_vec, cdalpha_mach_vec)
grid on,
title('Effect of Mach Number on CD alpha Measured at Altitude = 20,000 m')
xlabel('Mach Number')
ylabel('CD_(alpha)')

% plot q vs mach
mach_vec = [2 3 4 5 6 7 8 9 10];
q_mach_vec = [qm2(11)/1000, qm3(11)/1000, qm4(11)/1000, qm5(11)/1000,...
    qm6(11)/1000, qm7(11)/1000, qm8(11)/1000, qm9(11)/1000, qm10(11)/1000];
figure,
plot(mach_vec, q_mach_vec)
grid on,
title('Effect of Mach Number on Heat Transfer Measured at Altitude 20000 m, Alpha = 0 deg, T wall = 1200 K')
xlabel('Mach Number')
ylabel('Q dot (kW)')

% clcd vs alpha
figure,
plot(a_vec, cl_m2./cd_m2)
hold on,
plot(a_vec, cl_m4./cd_m4)
hold on,
plot(a_vec, cl_m6./cd_m6)
hold on,
plot(a_vec, cl_m8./cd_m8)
hold on,
plot(a_vec, cl_m10./cd_m10)
grid on,
title('Effect of Mach Number on Lift/Drag Ratio Measured at Altitude = 20,000 m')
xlabel('Angle of Attack (deg)')
ylabel('CL/CD')
legend('M2.0', 'M4.0', 'M6.0', 'M8.0', 'M10.0')

% plot drag polar
figure,
plot(cd_m2, cl_m2)
hold on,
plot(cd_m4, cl_m4)
hold on,
plot(cd_m6, cl_m6)
hold on,
plot(cd_m8, cl_m8)
hold on,
plot(cd_m10, cl_m10)
grid on,
title('Effect of Mach Number on Drag Polar Measured at Altitude = 20,000 m')
xlabel('CD')
ylabel('CL')
legend('M2.0', 'M4.0', 'M6.0', 'M8.0', 'M10.0')

%% Altitude effect at M8.0
[cl_a0, cd_a0, ~, a_vec] = x43_dragpolar(8, 0, 800, -10, 10, 1, 1);
[cl_a5k, cd_a5k, ~] = x43_dragpolar(8, 5000, 800, -10, 10, 1, 1);
[cl_a10k, cd_a10k, ~] = x43_dragpolar(8, 100000, 800, -10, 10, 1, 1);
[cl_a15k, cd_a15k, ~] = x43_dragpolar(8, 15000, 800, -10, 10, 1, 1);
[cl_a20k, cd_a20k, ~] = x43_dragpolar(8, 20000, 800, -10, 10, 1, 1);

[~,~,p0] = atmosisa(0);
[~,~,p5k] = atmosisa(5000);
[~,~,p10k] = atmosisa(10000);
[~,~,p15k] = atmosisa(15000);
[~,~,p20k] = atmosisa(20000);

l_a0 = cl_a0 * 0.5 * 1.4 * p0 * 8^2 * 3.65;
l_a5k = cl_a5k * 0.5 * 1.4 * p5k * 8^2 * 3.65;
l_a10k = cl_a10k * 0.5 * 1.4 * p10k * 8^2 * 3.65;
l_a15k = cl_a15k * 0.5 * 1.4 * p15k * 8^2 * 3.65;
l_a20k = cl_a20k * 0.5 * 1.4 * p20k * 8^2 * 3.65;

d_a0 = cd_a0 * 0.5 * 1.4 * p0 * 8^2 * 3.65;
d_a5k = cd_a5k * 0.5 * 1.4 * p5k * 8^2 * 3.65;
d_a10k = cd_a10k * 0.5 * 1.4 * p10k * 8^2 * 3.65;
d_a15k = cd_a15k * 0.5 * 1.4 * p15k * 8^2 * 3.65;
d_a20k = cd_a20k * 0.5 * 1.4 * p20k * 8^2 * 3.65;

% plot Cl
figure,
plot(a_vec, cl_a0)
hold on,
plot(a_vec, cl_a5k)
hold on,
plot(a_vec, cl_a10k)
hold on,
plot(a_vec, cl_a15k)
hold on,
plot(a_vec, cl_a20k)
grid on,
title('Effect of Altitude on Lift Coefficient Measured at Mach = 8.0')
xlabel('Angle of Attack (deg)')
ylabel('CL')
legend('0 m', '5,000 m', '10,000 m', '15,000 m', '20,000 m')

% plot LIFT
figure,
plot(a_vec, l_a0)
hold on,
plot(a_vec, l_a5k)
hold on,
plot(a_vec, l_a10k)
hold on,
plot(a_vec, l_a15k)
hold on,
plot(a_vec, l_a20k)
grid on,
title('Effect of Altitude on Lift Measured at Mach = 8.0')
xlabel('Angle of Attack (deg)')
ylabel('Lift (N)')
legend('0 m', '5,000 m', '10,000 m', '15,000 m', '20,000 m')

% plot Cd
figure,
plot(a_vec, cd_a0)
hold on,
plot(a_vec, cd_a5k)
hold on,
plot(a_vec, cd_a10k)
hold on,
plot(a_vec, cd_a15k)
hold on,
plot(a_vec, cd_a20k)
grid on,
title('Effect of Altitude on Drag Measured at Mach = 8.0')
xlabel('Angle of Attack (deg)')
ylabel('CD')
legend('0 m', '5,000 m', '10,000 m', '15,000 m', '20,000 m')

% plot DRAG
figure,
plot(a_vec, d_a0)
hold on,
plot(a_vec, d_a5k)
hold on,
plot(a_vec, d_a10k)
hold on,
plot(a_vec, d_a15k)
hold on,
plot(a_vec, d_a20k)
grid on,
title('Effect of Altitude on Drag Measured at Mach = 8.0')
xlabel('Angle of Attack (deg)')
ylabel('Drag (N)')
legend('0 m', '5,000 m', '10,000 m', '15,000 m', '20,000 m')

% plot DRAG vs alt
alt_vec = [0 5 10 15 20];
d_alt_vec = [d_a0(11), d_a5k(11), d_a10k(11), d_a15k(11), d_a20k(11)];
figure,
plot(alt_vec, d_alt_vec)
grid on,
title('Effect of Altitude on Drag Measured at M8.0, Angle of Attack = 0 deg')
xlabel('Altitude (km)')
ylabel('Drag (N)')

% plot drag polar
figure,
plot(cd_a0, cl_a0)
hold on,
plot(cd_a5k, cl_a5k)
hold on,
plot(cd_a10k, cl_a10k)
hold on,
plot(cd_a15k, cl_a15k)
hold on,
plot(cd_a20k, cl_a20k)
grid on,
title('Effect of Altitude on Drag Polar Measured at Mach = 8')
xlabel('CD')
ylabel('CL')
legend('0 m', '5,000 m', '10,000 m', '15,000 m', '20,000 m')

% plot Cd vs alt
alt_vec = [0 5 10 15 20];
cd_alt_vec = [cd_a0(11), cd_a5k(11), cd_a10k(11), cd_a15k(11), cd_a20k(11)];
figure,
plot(alt_vec, cd_alt_vec)
grid on,
title('Effect of Altitude on Drag Coefficient Measured at M8.0, Angle of Attack = 0 deg')
xlabel('Altitude (km)')
ylabel('CD')