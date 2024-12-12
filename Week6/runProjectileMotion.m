%Connor Murphy
%Assisted by chatgpt

% runProjectileMotion.m
% This script prompts the user for the initial velocity, launch angle, and gravitational acceleration,
% then calls projectileMotionWithKeyPoints() with the provided inputs.

clear; clc;

% Prompt user for inputs
v0 = input('Enter the initial velocity (m/s): ');
angle = input('Enter the launch angle (degrees): ');
g = input('Enter gravitational acceleration (m/s^2): ');

% Call the function
projectileMotionWithKeyPoints(v0, angle, g);
