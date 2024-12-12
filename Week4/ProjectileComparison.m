%Connor Murphy
%Assisted By chatgpt

% projectileComparison.m
% Script to compare user-guessed and optimal launch angles for projectile motion

% Clear the workspace and command window
clear;
clc;

% Constants
g = 9.81; % Gravitational acceleration (m/s^2)
numValues = 100; % Number of time intervals for trajectory computation

% User Inputs
v0 = input('Enter the initial velocity (in m/s): ');
y0 = input('Enter the initial height (in meters): ');
userGuess = input('Enter your guess for the optimal angle (in degrees): ');

% Compute the optimal angle and maximum range
[optimalAngle, maxRange] = getOptimalTrajectoryAngle(v0, y0, g);

% Display results in the command window
fprintf('Optimal launch angle: %.2f degrees\n', optimalAngle);
fprintf('Maximum range: %.2f meters\n', maxRange);
fprintf('Your guess was off by %.2f degrees.\n', abs(optimalAngle - userGuess));

% Compute trajectories
[optX, optY, ~] = calculateTrajectory(v0, optimalAngle, g, y0, numValues);
[guessX, guessY, ~] = calculateTrajectory(v0, userGuess, g, y0, numValues);

% Plotting
figure;
plot(optX, optY, 'DisplayName', sprintf('Optimal Angle (%.2f°)', optimalAngle));
hold on;
plot(guessX, guessY, 'DisplayName', sprintf('Guessed Angle (%.2f°)', userGuess));
hold off;

% Configure the plot
xlabel('Horizontal Distance (m)');
ylabel('Vertical Height (m)');
title('Projectile Motion Comparison');
legend('Location', 'best');
grid on;