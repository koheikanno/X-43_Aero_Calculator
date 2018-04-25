% Viscous Drag Calculator
%
% 12/7/2017
%
% Assumes a constant Prantdl number of 0.71. Valid up to approx. 800 K
% Uses Meador-Smart equation for both laminar and turbulent boundar
% layers.
%
% TODO:
% Fix?: SI units and freedom units mixed in this function
% Fix: There might be a discontinuity in viscous drag vs alpha?
%
% INPUTS:
% mach: mach number
% origin: length to the origin of the surface from the nose of the
% aircraft (in.)
% l: length of the surface (in.)
% p: pressure of the pressure(Pa)
% t: temperature of the flow (K)
% tw: temperature of the wall
%
% OUTPUTS:
% cd: coefficient of drag due to the viscosity
% h_bar: convection coefficient

function [cd, h_bar] = viscous(mach, origin, l, p, t, tw)
% Converts the lengths to meters. This part is a bit awkward so I might
% change it later.
origin = origin * 0.0254;
l = l * 0.0254;

% Constants
mu_ref = 1.716 * 10^-5; % Pa-s
t_ref = 273.15; % K
s = 110.4; % K
r_gas = 287; % J/(kg K)
gamma = 1.4;
u = mach * (gamma * r_gas * t)^0.5; % m/s
cp = 1004;
pr = 0.71;

% Reference Temperature Method
r = pr^0.5;
taw_te = tw / t;
% Meador-Smart equation for laminar flow and turbulent flow
tstar_te = 0.45 + 0.55 * taw_te + 0.16 * r * ((gamma - 1) / 2) * mach^2;
tstar_te_turb = 0.5 * (1 + taw_te) + 0.16 * r * ((gamma - 1) / 2) * mach^2;
tstar = tstar_te * t;
tstar_turb = tstar_te_turb * t;

% Define length as a vector and calculate local Reynold's numbers at each
% points. Sutherland's Law is incorporated in the equations.
length_vec = linspace(origin, l + origin);
re = (p / (r_gas * tstar) * u * length_vec) / (mu_ref * (tstar / t_ref)^1.5 * (t_ref + s) / (tstar + s));
re_turb = (p / (r_gas * tstar_turb) * u * length_vec) / (mu_ref * (tstar_turb / t_ref)^1.5 * (t_ref + s) / (tstar_turb + s));

% Cf breaks when Re == 0, i.e. when the length is zero, so pop the element
% if re == 0
length_vec = length_vec(re~=0);
re = re(re~=0);
re_turb = re_turb(re_turb~=0);

cf = zeros(1,length(length_vec));
h = zeros(1,length(length_vec));

% Calculate Cf and integrate over the surface
for ii = 1:length(re_turb)
    % If the Reynolds number for turbulent flow is greater than 5 * 10^5
    % at this point, turbulent BL exists because the turbulent Re is always
    % greater than laminar Re. Otherwise, use the laminar Re.
    if re_turb >= 5 * 10^5
        cf(ii) = 0.02296 / (re_turb(ii) ^ 0.139);
        h(ii) = (p / (r_gas * tstar_turb)) * u * cp * 0.074 / (2 * re_turb(ii)^0.2 * (1 + 5 * (0.037 / re_turb(ii)^0.2)^0.5 * ((pr - 1) + log((5 * pr + 1) / 6))));
    % Otherwise, laminar BL exists
    else
        cf(ii) = 0.664 / (re(ii) ^ 0.5);
        h(ii) = 0.332 / (re(ii) ^ 0.5) / pr^(2/3) * (p / (r_gas * tstar)) * u * cp;
    end
end

% Integrate to calculate Cd
cd = trapz(length_vec, cf);
h_bar = trapz(length_vec, h);
end