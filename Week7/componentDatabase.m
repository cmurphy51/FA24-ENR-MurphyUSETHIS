%Connor Murphy
%Assisted by chatgpt

% componentDatabase.m
% This script manages a database of engineering components using structures and tables.

clear; clc;

% 1. Define the structure for components
% Fields: ID (int), Name (string), Dimensions (struct with Length, Width, Height), Material (string), Weight (double)
% We will initialize an empty structure array:
components = struct('ID', {}, 'Name', {}, 'Dimensions', {}, 'Material', {}, 'Weight', {});

% 2. Create three components and add them using addComponent
% Component 1
comp1.ID = 1;
comp1.Name = "Beam";
comp1.Dimensions.Length = 2.5;  % meters
comp1.Dimensions.Width = 0.3;   % meters
comp1.Dimensions.Height = 0.5;  % meters
comp1.Material = "Steel";
comp1.Weight = 150.0;           % kg

components = addComponent(components, comp1);

% Component 2
comp2.ID = 2;
comp2.Name = "Column";
comp2.Dimensions.Length = 3.0;  % meters
comp2.Dimensions.Width = 0.4;   % meters
comp2.Dimensions.Height = 0.4;  % meters
comp2.Material = "Concrete";
comp2.Weight = 200.0;           % kg

components = addComponent(components, comp2);

% Component 3
comp3.ID = 3;
comp3.Name = "Bolt";
comp3.Dimensions.Length = 0.1;  % meters
comp3.Dimensions.Width = 0.02;  % meters
comp3.Dimensions.Height = 0.02; % meters
comp3.Material = "Alloy";
comp3.Weight = 0.5;             % kg

components = addComponent(components, comp3);

% Convert struct array to table
tbl = struct2Table(components);

% 3. Save the table to componentsDatabase.csv
writetable(tbl, 'componentsDatabase.csv');

% Load the table back from componentsDatabase.csv
loadedTbl = readtable('componentsDatabase.csv');

% Display the contents in a readable format with units
% Print header
fprintf('ID\tName\tLength (m)\tWidth (m)\tHeight (m)\tMaterial\tWeight (kg)\n');

% Print each row
for i = 1:height(loadedTbl)
    fprintf('%d\t%s\t%.2f\t\t%.2f\t\t%.2f\t\t%s\t\t%.1f\n', ...
        loadedTbl.ID(i), ...
        loadedTbl.Name{i}, ...
        loadedTbl.Length(i), ...
        loadedTbl.Width(i), ...
        loadedTbl.Height(i), ...
        loadedTbl.Material{i}, ...
        loadedTbl.Weight(i));
end
