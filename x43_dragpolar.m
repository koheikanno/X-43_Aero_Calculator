% X-43 Drag Polar Plotter
%
% 12/7/2017
%
% Calculates and plots CL vs alpha, CD vs alpha, and drag polar at a given
% condition.
%
% INPUTS:
% mach: mach number
% altitude: altitude (m)
% tw: wall temperature (K)
% a_min: minimum angle of attack for the analysis (deg)
% a_max: maximum angle of attack for the analysis (deg)
% incr: increment between AOAs. (deg)
% v: v == 1 turns on the viscosity effect, v == 0 turns it off
%
% OUTPUTS:
% cl: array of lift coefficients over the given AOA range, incr degree
% increments.
% cd: array of drag coefficients over the given AOA range, incr degree
% increments.
% q: array of heat transferred between the flow and the temperature (W)

function [cl, cd, q, a_vec, cd_v] = x43_dragpolar(mach, altitude, tw, a_min, a_max, incr, v)
a_vec = a_min:incr:a_max;
cl = zeros(1, length(a_vec));
cd = zeros(1, length(a_vec));

for ii=1:length(a_vec)
[cl(ii), cd(ii), q(ii), cd_v(ii)] = x43_aerocoeff(a_vec(ii), mach, altitude, tw, v);
end

% figure,
% plot(a_vec, cl)
% title(['X-43 Lift at Mach ' num2str(mach) ', altitude = ' num2str(altitude) ' m'])
% xlabel('alpha (degrees)')
% ylabel('CL')
% grid on,
% 
% figure,
% plot(a_vec, cd)
% title(['X-43 Drag at Mach ' num2str(mach) ', altitude = ' num2str(altitude) ' m' ])
% xlabel('alpha (degrees)')
% ylabel('CD')
% grid on,
% 
% figure,
% plot(cd, cl)
% title(['X-43 Drag Polar at Mach ' num2str(mach) ', altitude = ' num2str(altitude) ' m'])
% xlabel('CD')
% ylabel('CL')
% grid on,
end