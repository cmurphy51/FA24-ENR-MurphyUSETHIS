%Connor Murphy
%Assisted by Chatgpt

% materialSelector.m
% This script prompts the user for material criteria (density, tensile strength, cost),
% calls the filterMaterials function, and displays the filtered results.

clear; clc;

% 1. User Inputs
maxDensity = input('Enter the maximum acceptable density (kg/m^3): ');
minTensileStrength = input('Enter the minimum required tensile strength (MPa): ');
maxCost = input('Enter the maximum acceptable cost per kg (USD): ');

% File containing the materials data
filename = 'materials_data.csv';  % Replace with the actual filename

% 2. Manipulation: Call filterMaterials
filteredTable = filterMaterials(filename, maxDensity, minTensileStrength, maxCost);

% 3. Output
if isempty(filteredTable)
    fprintf('No materials meet the specified criteria.\n');
else
    fprintf('Materials that meet your criteria:\n');
    disp(filteredTable);
end
