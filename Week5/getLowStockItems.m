%Connor Murphy 
%Assisted by chatgpt

function lowStockItems = getLowStockItems(filename, threshold)
% getLowStockItems Returns a table of items from the inventory whose quantity
% is less than or equal to the specified threshold.
%
% Inputs:
%   filename  - Name of the inventory CSV file (e.g., 'inventory.csv').
%   threshold - Quantity threshold (scalar).
%
% Output:
%   lowStockItems - A table containing items with qty <= threshold.
%
% The CSV file is expected to have 'upc', 'ingredient', and 'qty' columns.

    % Check if file exists
    if ~exist(filename, 'file')
        error('The file %s does not exist.', filename);
    end

    % Read the data from the CSV file
    T = readtable(filename);

    % Ensure required columns are present
    requiredCols = {'upc', 'ingredient', 'qty'};
    if ~all(ismember(requiredCols, T.Properties.VariableNames))
        error('The file %s does not contain the required columns: %s', filename, strjoin(requiredCols, ', '));
    end

    % Identify items with qty <= threshold
    lowStockFilter = T.qty <= threshold;

    % Return the filtered table
    lowStockItems = T(lowStockFilter, :);
end
