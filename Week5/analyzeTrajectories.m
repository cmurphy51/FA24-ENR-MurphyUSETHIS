%Connor Murphy
%Assisted by chatgpt

function [aboveAverageAngles, maxRange, optimalAngle] = analyzeTrajectories(angles, ranges)
% analyzeTrajectories Analyzes projectile trajectories to determine angles 
% that achieve above-average ranges, the maximum range, and the optimal angle.
%
% Inputs:
%   angles - A vector of launch angles in degrees
%   ranges - A vector of corresponding projectile ranges in meters
%
% Outputs:
%   aboveAverageAngles - A vector of angles that resulted in above-average ranges
%   maxRange           - The maximum range achieved (scalar)
%   optimalAngle       - The angle corresponding to the maximum range (scalar)

    % Ensure angles and ranges have the same length
    if length(angles) ~= length(ranges)
        error('angles and ranges must have the same length.');
    end

    % Calculate the average range
    avgRange = mean(ranges);

    % Find angles with above-average ranges
    aboveAverageMask = ranges > avgRange;
    aboveAverageAngles = angles(aboveAverageMask);

    % Identify the maximum range and corresponding angle
    [maxRange, idxMax] = max(ranges);
    optimalAngle = angles(idxMax);
end
