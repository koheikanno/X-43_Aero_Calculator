% Prandtl-Meyer Expansion Relations Calculator
%
% 12/6/2017
%
% theta in degrees
% Updated to use matlab's built-in prandtl meyer function to avoid errors
% related to the equation solver. Affected portion has been commented out.
%
% INPUTS:
% m1: mach number before the expansion fan
% theta: flow deflection angle
%
% OUTPUTS:
% m2: mach number after the expansion fan
% p2p1: pressure ratio across the expansion fan
% t2t1: temperature ratio across the expansion fan


function [m2, p2p1, t2t1] = expansion(m1, theta)
% Constants
gamma = 1.4;
theta = theta * pi / 180;
nu_m1 = ((gamma + 1)/(gamma -1))^0.5 * atan(((gamma - 1)/(gamma + 1)*(m1^2 - 1))^0.5) - atan((m1^2 - 1)^0.5);
nu_m2 = theta + nu_m1;

% syms m
% func = ((gamma + 1)/(gamma -1))^0.5 * atan(((gamma - 1)/(gamma + 1)*(m^2 - 1))^0.5) - atan((m^2 - 1)^.5) == nu_m2;
% m2 = solve(func, m, 'Real', true);
% 
% if m2 < 0
%     m2 = m2 * -1;
% end

nu_m2 = nu_m2 * 180 / pi;
[m2, ~, ~] = flowprandtlmeyer(gamma, nu_m2, 'nu');

% Calls isentropic() to calculate the pressure and temperature ratio.
[p01p1, ~, t01t1] = isentropic(m1);
[p02p2, ~, t02t2] = isentropic(m2);
p2p1 = p01p1 / p02p2;
t2t1 = t01t1 / t02t2;
end