% Supersonic Pressure Force Coefficients Calculator
%
% 12/5/2017
%
% This function calculates the lift and drag coefficients on one surface.
% theta is measured from the freestream here
% assumes a unit characteristic length (1)
% theta in degrees
%
% INPUTS:
% mach: free stream mach number. Used to nondimensionalize the lift and
% drag.
% p2p1: pressure ratio to the freestream (p1)
% theta: direction of the local flow, measured from the freestream (deg)
% n == 1: upper surface, n == 0: lower surface
%
% OUTPUTS:
% cl: coefficient of lift
% cd: coefficient of drag

function [cl, cd] = pressurecoeff(mach, p2p1, theta, n)
% returns infinity if the switch is not 0 or 1
if n ~= 0 && n~= 1
    cl = inf;
    cd = inf;
    return
end

theta = theta * pi / 180;

% Constant
gamma = 1.4;

% Calculates lift and drag with respect to free stream
lift = p2p1 * cos(theta);
drag = p2p1 * sin(theta);

% Absolute values are used. The signs will be set later.
lift = abs(lift);
drag = abs(drag);

% Nondimensionalizing...
cl = lift / (0.5*gamma*mach^2);
cd = drag / (0.5*gamma*mach^2);

% Whether it's on the top surface or bottom surface, if the angle is
% positive or negative...
if n == 1 && theta > 0
    cl = cl * -1;
    cd = cd * -1;
elseif n == 1 && theta <= 0
    cl = cl * -1;
elseif n == 0 && theta < 0
    cd = cd * -1;
end
    
end