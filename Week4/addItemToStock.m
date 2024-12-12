%Connor Murphy
%Assisted by Chatgpt

function addItemToStock(filename, upc, ingredient, qty)
% addItemToStock Adds a new item to the inventory CSV file.
%
% Inputs:
%   filename   - Name of the CSV file (string), e.g. 'inventory.csv'
%   upc        - UPC code of the item (string)
%   ingredient - Name of the ingredient (string)
%   qty        - Quantity of the item (integer)
%
% Output: None. Appends a new row to the CSV file. If the file does not
%         exist, creates it and adds headers.

    % Check if file exists
    fileExists = exist(filename, 'file');

    if ~fileExists
        % If the file doesn't exist, create and write headers first
        fid = fopen(filename, 'w');
        if fid == -1
            error('Could not create the file %s.', filename);
        end
        % Write headers
        fprintf(fid, 'upc,ingredient,qty\n');
        % Write the new item
        fprintf(fid, '%s,%s,%d\n', upc, ingredient, qty);
        fclose(fid);
    else
        % If file exists, append the new line
        fid = fopen(filename, 'a');
        if fid == -1
            error('Could not open the file %s for appending.', filename);
        end
        fprintf(fid, '%s,%s,%d\n', upc, ingredient, qty);
        fclose(fid);
    end
end
