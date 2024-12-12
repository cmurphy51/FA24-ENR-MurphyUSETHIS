%Connor Murphy
%Assisted by Chatgpt

% processGearRatios.m
% This script reads gear teeth data from a CSV file, computes the gear ratio for
% each pair of gears using the gearRatioCalc function, and writes the updated
% data (including a new gearRatio column) to a new CSV file.

% Clear the workspace and command window
clear; clc;

% 1. File Input
% Read the data from gear_data.csv into a table for easy column access.
inputFile = 'gear_data.csv';
T = readtable(inputFile);

% Ensure the table has the expected columns
if ~all(ismember({'driverTeeth','drivenTeeth'}, T.Properties.VariableNames))
    error('Input file must contain "driverTeeth" and "drivenTeeth" columns.');
end

% 2. Computation
% Use gearRatioCalc function to compute the gear ratios for each gear pair.
% If gearRatioCalc is defined as taking scalars, we can apply it using arrayfun.
T.gearRatio = arrayfun(@gearRatioCalc, T.driverTeeth, T.drivenTeeth);

% 3. File Output
% Write the updated data (now including gearRatio) to a new CSV file.
outputFile = 'gear_ratios_output.csv';
writetable(T, outputFile);

fprintf('Gear ratios computed and written to %s.\n', outputFile);
