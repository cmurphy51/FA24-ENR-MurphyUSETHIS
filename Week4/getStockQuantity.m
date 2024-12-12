%Connor Murphy
%Assisted by chatgpt

function quantity = getStockQty(filename, upc)
% getStockQty Returns the quantity of the specified UPC from the inventory file.
%
% Inputs:
%   filename - Name of the CSV file (string), e.g. 'inventory.csv'
%   upc      - UPC code of the item to check (string)
%
% Output:
%   quantity - The quantity of the item (integer)
%              Returns -1 if the UPC is not found or the file does not exist.

    % Check if the file exists
    if ~exist(filename, 'file')
        quantity = -1;
        return;
    end

    % Read the CSV file into a table
    T = readtable(filename);

    % Check if required columns exist
    if ~all(ismember({'upc','ingredient','qty'}, T.Properties.VariableNames))
        error('The file %s does not have the required columns (upc, ingredient, qty).', filename);
    end

    % Find the index of the row with the matching UPC
    idx = find(strcmp(T.upc, upc), 1); % first match

    if isempty(idx)
        % UPC not found
        quantity = -1;
    else
        % Return the quantity from the matching row
        quantity = T.qty(idx);
    end
end
