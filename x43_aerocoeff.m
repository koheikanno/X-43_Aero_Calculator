% X-43 Aerodynamic Coefficients and Heat Transfer Calculator
%
% 12/7/2017
%
% TODO:
% Fix?: SI units and freedom units mixed becuase of viscous() and
% atmosisa(). The A/C geometry in inches.
%
% Flow regions as defined in the report
% Pressure + Viscous (Laminar + Turbulent) Drag (Meador-Smart Eqns.)
% characteristic length: 143.5"
% Theta is local deflection angle
% assumes an uniform span length
% assumes the standard atmospheric condition
%
% INPUTS:
% alpha: angle of attack of the aircraft (deg)
% mach: mach number
% altitude: altitude (m)
% tw: temperature of the wall (K)
% v: v == 1 turns on the viscosity effect, v == 0 turns it off
% 
% OUTPUTS:
% cl: coefficient of lift
% cd: coefficient of drag
% qdot: Heat transfer between the flow and the wall (W)

function [cl, cd, qdot, cd_v] = x43_aerocoeff(alpha, mach, altitude, tw, v)
[t1, ~, p1, ~] = atmosisa(altitude);   
c = 143.5;
% Return inf if v is not 1 or 0, also if mach is less than one
if (v ~= 1 && v~= 0) || mach <= 1
    cl = Inf;
    cd = Inf;
    return
end

%% Upper surface - Region 2: oblique shock at alpha < 4.14
% theta = 4.14 deg, length: 103.5"

% If alpha < 4.14, oblique shock, else if alpha > 4.14, expansion, else
% nothing happens.
if alpha < 4.14
    theta_1 = alpha - 4.14;
    [m2, ~, p2p1, t2t1, ~]= obliqueshock(mach, abs(theta_1));
elseif alpha > 4.14
    theta_1 = alpha - 4.14;
    [m2, p2p1, t2t1] = expansion(mach, abs(theta_1));
else
    theta_1 = 0;
    m2 = mach;
    p2p1 = 1;
    t2t1 = 1;
end

% Set up lengths and angles used to calculate the aero coefficients
s_length2 = 103.5 / cosd(4.14);
sum_length = 0;
sum_angle = theta_1;

% Calls pressurecoeff() to find the cl and cd due to pressure difference,
[cl_1, cd_1] = pressurecoeff(mach, p2p1, sum_angle, 1);

% Viscous drag. Calls viscous() to find teh cd due to viscosity
if v == 1
    p2 = p1 * p2p1;
    t2 = t1 * t2t1;
    [cd_v1, h_bar_1] = viscous(m2, sum_length, s_length2, p2, t2, tw);
    cd_v1 = cd_v1 * cosd(sum_angle);
    q_1 = h_bar_1 * (tw - t2);
else
    cd_v1 = 0;
    q_1 = 0;
end

%% Upper surface - Region 3: expansion wave
% theta = 4.14 deg, length: 40"
theta_2 = 4.14;
[m3, p3p2, t3t2] = expansion(m2, theta_2);
p3p1 = p2p1 * p3p2;
t3t1 = t2t1 * t3t2;

% Lengths and angles
s_length3 = 40;
sum_length = sum_length + s_length2;
sum_angle = sum_angle + theta_2;

% Pressure
[cl_2, cd_2] = pressurecoeff(mach, p3p1, sum_angle, 1);

% Viscous drag
if v == 1
    p3 = p1 * p3p1;
    t3 = t1 * t3t1;
    [cd_v2, h_bar_2] = viscous(m3, sum_length, s_length3, p3, t3, tw);
    cd_v2 = cd_v2 * cosd(sum_angle);
    q_2 = h_bar_2 * (tw - t3);
else
    cd_v2 = 0;
    q_2 = 0;
end

%% Total upper surface aerodynamic coefficients
% cl and cd weighted using the chord length so that it adds up to c.
cl_up = (103.5/c) * cl_1 + (40/c) * cl_2;
cd_up = (103.5/c) * (cd_1 + cd_v1) + (40/c) * (cd_2 + cd_v2);
cd_v_up = (103.5/c) * cd_v1 + (40/c) * cd_v2;

%% Lower surface - Region 4: oblique shock at alpha > -6.36
% theta = 6.36 degrees, length: 35.875"
% Similar to the first region of the upper surface.
if alpha > -6.36
    theta_3 = 6.36 + alpha;
    [m4, ~, p4p1, t4t1, ~]= obliqueshock(mach, abs(theta_3));
elseif alpha < -6.36
    theta_3 = 6.36 + alpha;
    [m4, p4p1, t4t1] = expansion(mach, abs(theta_3));
else
    theta_3 = 0;
    m4 = mach;
    p4p1 = 1;
    t4t1 = 1;
end

% Lengths and angles...
s_length4 = 35.875 / cosd(6.36);
sum_length = 0;
sum_angle = theta_3;

% Pressure...
[cl_3, cd_3] = pressurecoeff(mach, p4p1, sum_angle, 0);

% Viscous drag
if v == 1
    p4 = p1 * p4p1;
    t4 = t1 * t4t1;
    [cd_v3, h_bar_3] = viscous(m4, sum_length, s_length4, p4, t4, tw);
    cd_v3 = cd_v3 * cosd(sum_angle);
    q_3 = h_bar_3 * (tw - t4);
else
    cd_v3 = 0;
    q_3 = 0;
end

%% Lower surface - Region 5: oblique shock
% theta = 6.21 deg, length: 35.875"
theta_4 = 6.21;
[m5, ~, p5p4, t5t4, ~]= obliqueshock(m4, theta_4);
p5p1 = p4p1 * p5p4;
t5t1 = t4t1 * t5t4;

% Lengths and angles
s_length5 = 35.875 / cosd(6.21 + 6.36);
sum_length = sum_length + s_length4;
sum_angle = sum_angle + theta_4;

% Pressure forces
[cl_4, cd_4] = pressurecoeff(mach, p5p1, sum_angle, 0);

% Viscous drag
if v == 1
    p5 = p1 * p5p1;
    t5 = t1 * t5t1;
    [cd_v4, h_bar_4] = viscous(m5, sum_length, s_length5, p5, t5, tw);
    cd_v4 = cd_v4 * cosd(sum_angle);
    q_4 = h_bar_4 * (tw - t5);    
else
    cd_v4 = 0;
    q_4 = 0;
end

%% Lower surface - Region 6: expansion wave (Inside the engine)
% theta = 12.57 deg, length: 30.4"
theta_5 = 12.57;
[m6, p6p5, t6t5] = expansion(m5, theta_5);
p6p1 = p5p1 * p6p5;
t6t1 = t5t1 * t6t5;

% Lengths and angles
s_length6 = 30.4;
sum_length = sum_length + s_length6;
sum_angle = sum_angle - theta_5;

% Pressure forces
[cl_5, cd_5] = pressurecoeff(mach, p6p1, sum_angle, 0);

% Viscous drag
if v == 1
    p6 = p1 * p6p1;
    t6 = t1 * t6t1;
    [cd_v5, h_bar_5] = viscous(m6, sum_length, s_length6, p6, t6, tw);
    cd_v5 = cd_v5 * cosd(sum_angle);
    q_5 = h_bar_5 * (tw - t6);      
else
    cd_v5 = 0;
    q_5 = 0;
end

%% Lower surface - Region 7: expansion wave (After the outlet)
% theta = 8.9335 deg, length: 41.35"
theta_6 = 8.9355;
[m7, p7p6, t7t6] = expansion(m6, theta_6);
p7p1 = p6p1 * p7p6;
t7t1 = t6t1 * t7t6;

% Lengths and angles
s_length7 = 41.35 / cosd(8.9335);
sum_length = sum_length + s_length7;
sum_angle = sum_angle - theta_6;

% Pressure forces
[cl_6, cd_6] = pressurecoeff(mach, p7p1, sum_angle, 0);

% viscous drag
if v == 1
    p7 = p1 * p7p1;
    t7 = t1 * t7t1;
    [cd_v6, h_bar_6] = viscous(m7, sum_length, s_length7, p7, t7, tw);
    cd_v6 = cd_v6 * cosd(sum_angle);
    q_6 = h_bar_6 * (tw - t7); 
else
    cd_v6 = 0;
    q_6 = 0;
end

%% Total lower surface aerodynamic coefficients
cl_dn = (35.875/c) * cl_3 + (35.875/c) * cl_4 + (30.4/c) * cl_5 + (41.35/c) * cl_6;
cd_dn = (35.875/c) * (cd_3 + cd_v3) + (35.875/c) * (cd_4 + cd_v4)+ (30.4/c) * (cd_5 + cd_v5) + (41.35/c) * (cd_6 + cd_v6);
cd_v_dn = (35.875/c) * cd_v3 + (35.875/c) * cd_v4+ (30.4/c) * cd_v5 + (41.35/c) * cd_v6;

%% Total aerodynamic coefficients
% Adds the upper surface contribution and the lower surface contribution.
cl = cl_up + cl_dn;
cd = cd_up + cd_dn;
cd_v = cd_v_up + cd_v_dn;
qdot = q_1 + q_2 + q_3 + q_4 + q_5 + q_6;

end