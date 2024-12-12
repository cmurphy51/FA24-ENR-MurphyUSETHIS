function invTable = getInventoryList(filename)
% getInventoryList Returns the entire inventory as a table.
%
% Input:
%   filename - Name of the CSV file (string), e.g. 'inventory.csv'
%
% Output:
%   invTable - A table containing the entire inventory list.

    % Check if the file exists
    if ~exist(filename, 'file')
        warning('File %s does not exist. Returning empty table.', filename);
        invTable = table();
        return;
    end

    % Read the file into a table
    invTable = readtable(filename);

    % Check if required columns exist
    if ~all(ismember({'upc','ingredient','qty'}, invTable.Properties.VariableNames))
        error('The file %s does not have the required columns (upc, ingredient, qty).', filename);
    end
end
