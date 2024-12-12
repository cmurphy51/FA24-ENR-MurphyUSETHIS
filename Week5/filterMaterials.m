%Connor Murphy
%Assisted by chatgpt

function filteredTable = filterMaterials(filename, maxDensity, minTensileStrength, maxCost)
% filterMaterials Reads material data from a CSV and filters it based on given criteria.
%
% Inputs:
%   filename            - The name of the CSV file containing material data.
%   maxDensity          - The maximum allowable density.
%   minTensileStrength  - The minimum required tensile strength.
%   maxCost             - The maximum allowable cost per kg.
%
% Output:
%   filteredTable - A table containing only the materials that meet the specified criteria.
%
% The CSV file is assumed to have columns such as:
%   'Material', 'Density', 'TensileStrength', 'CostPerKg'
%

    % Read the data from the CSV file into a table
    T = readtable(filename);

    % Validate that the required columns exist
    requiredCols = {'Material','Density','TensileStrength','CostPerKg'};
    if ~all(ismember(requiredCols, T.Properties.VariableNames))
        error('The input file does not contain the required columns: %s', strjoin(requiredCols, ', '));
    end

    % Create logical filters for each condition:
    % Density <= maxDensity
    densityFilter = T.Density <= maxDensity;

    % TensileStrength >= minTensileStrength
    strengthFilter = T.TensileStrength >= minTensileStrength;

    % CostPerKg <= maxCost
    costFilter = T.CostPerKg <= maxCost;

    % Combine all filters using logical AND
    combinedFilter = densityFilter & strengthFilter & costFilter;

    % Apply the filter and return the filtered table
    filteredTable = T(combinedFilter, :);
end
