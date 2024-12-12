%Connor Murphy
%Assisted By ChatGPT

function [optimal_angle, max_range] = getOptimalTrajectoryAngle(v0, y0, gravity)
% GETOPTIMALTRAJECTORYANGLE Computes the optimal launch angle and maximum range.
%
% [optimal_angle, max_range] = GETOPTIMALTRAJECTORYANGLE(v0, y0, gravity)
% calculates the angle (in degrees) that maximizes the projectile's range
% and the corresponding maximum range.
%
% Inputs:
%   v0      - Initial velocity in m/s (scalar)
%   y0      - Initial height in meters (scalar)
%   gravity - Gravitational acceleration in m/s^2 (scalar)
%
% Outputs:
%   optimal_angle - Launch angle (in degrees) that gives the maximum range (scalar)
%   max_range     - Maximum range (in meters) at the optimal angle (scalar)

    % Initialize variables
    max_range = 0;         % To track the maximum range
    optimal_angle = 0;     % To track the optimal angle

    % Loop through angles from 0 to 90 degrees
    for angle = 0:1:90
        % Convert angle to radians
        theta = deg2rad(angle);
        
        % Compute the range using the given formula
        range = (v0 * cos(theta) / gravity) * ...
                (v0 * sin(theta) + sqrt((v0 * sin(theta))^2 + 2 * gravity * y0));
        
        % Update maximum range and angle if the current range is larger
        if range > max_range
            max_range = range;
            optimal_angle = angle;
        end
    end
end