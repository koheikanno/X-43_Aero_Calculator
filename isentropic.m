% Isentropic Relations Calculator
%
% 12/6/2017
%
% Calculates isentropic relations. Pretty self explanatory.
%
% INPUTS:
% m1: mach number
%
% OUTPUTS:
% p0p: total pressure/static pressure
% rho0rho: total density/static density
% t0t: total temperature/static temperature

function [p0p, rho0rho, t0t] = isentropic(m1)
% Constant gamma. CPG.
gamma = 1.4;

p0p = (1 + (gamma - 1) / 2 * m1^2)^(gamma / (gamma - 1));
rho0rho = (1 + (gamma - 1) / 2 * m1^2)^(1 / (gamma - 1));
t0t = 1 + (gamma - 1) / 2 * m1^2;
end