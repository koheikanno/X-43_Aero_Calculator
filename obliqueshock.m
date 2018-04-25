% Oblique Shock Relations Calculator
%
% Theta Beta Mach Analytic Relation by W. Ethan Eagle
%
% 12/6/2017
%
% INPUTS:
% m1: mach number before the oblique shock
% theta: flow deflection angle (deg)
%
% OUTPUTS:
% m2: mach number after the oblique shock
% p02p01: total pressure ratio across the shock
% p2p1: pressure ratio across the shock
% t2t1: temperature ratio across the shock
% b: beta angle (deg)

function [m2, p02p01, p2p1, t2t1, b] = obliqueshock(m1, theta)
% Constants
gamma = 1.4;
cp = 1004;
b = beta(m1,theta,gamma,0);
theta = theta * pi / 180;
b = b * pi / 180;

% Calculate normal mach number then calls normalshock() to calculate ratio
% and other properties
mn1 = m1 * sin(b);
[p2p1, ~, t2t1, p02p01, ~, mn2] = normalshock(mn1);
m2 = mn2 / sin(b - theta);
b = b * 180 / pi;
end