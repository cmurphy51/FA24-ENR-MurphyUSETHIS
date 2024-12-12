%Connor Murphy
%Assisted by chatgpt

% trajectoryAnalysis.m
% This script:
% 1. Generates projectile ranges for angles from 0 to 90 degrees using calculateTrajectory().
% 2. Uses analyzeTrajectories() to determine which angles are above-average, the max range, and the optimal angle.
% 3. Displays the average range, maximum range, optimal angle, and above-average angles.

clear; clc;

% Parameters (adjust as needed)
v0 = 50;              % Initial velocity in m/s
y0 = 0;               % Initial height in meters
g = 9.81;             % Acceleration due to gravity (m/s^2)
numValues = 100;      % Number of time points in the trajectory
angles = 0:90;        % Angles from 0 to 90 degrees (inclusive)

% 1. Data Generation
ranges = zeros(size(angles));
for i = 1:length(angles)
    angle = angles(i);
    [x, y, time] = calculateTrajectory(v0, angle, g, y0, numValues);
    % The range is typically the horizontal distance at impact (last value of x)
    % Assuming the last value in x corresponds to the projectile hitting the ground again.
    ranges(i) = x(end);
end

% 2. Data Analysis
[aboveAverageAngles, maxRange, optimalAngle] = analyzeTrajectories(angles, ranges);

% Compute average range directly
avgRange = mean(ranges);

% 3. Output
fprintf('Average Range: %.2f m\n', avgRange);
fprintf('Maximum Range: %.2f m\n', maxRange);
fprintf('Optimal Angle: %.2f degrees\n', optimalAngle);

fprintf('Angles with above-average ranges:\n');
if isempty(aboveAverageAngles)
    fprintf('None\n');
else
    disp(aboveAverageAngles);
end
