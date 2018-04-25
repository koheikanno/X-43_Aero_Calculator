% Normal Shock Relations Calculator
%
% 12/6/2017
%
% Calculates the Normal shock relations.
% Assumes CPG. Cp = 1004, R = 287. Calculates s2 - s1 first to find the
% total pressure ratio
%
% INPUTS:
% m1: mach number before the shock
%
% OUTPUTS:
% p2p1: pressure ratio across the NS
% rho2rho1: density ratio across the NS
% t2t1: temperature ratio across the NS
% p02p01: total pressure ratio across the NS
% p02p1: totalpressure after the NS/static pressure before the NS
% m2: mach number after the shocki

function [p2p1, rho2rho1, t2t1, p02p01, p02p1, m2] = normalshock(m1)
% Constants
gamma = 1.4;
cp = 1004;
R = 287;

m2 = ((1 + (gamma - 1)/ 2 * m1^2) / (gamma * m1^2 - (gamma - 1) / 2))^0.5;
rho2rho1 = (gamma + 1) * m1^2 / (2 + (gamma - 1) * m1^2);
p2p1 = 1 + 2 * gamma / (gamma + 1) * (m1^2 - 1);
t2t1 = p2p1 / rho2rho1;
s2_s1 = cp * log(t2t1) - R * log(p2p1);
p02p01 = exp(-s2_s1 / R);
p02p1 = p02p01 * (1 + (gamma - 1)/2 * m1^2)^(gamma / (gamma - 1));
end