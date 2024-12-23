%Connor Murphy
%Assisted by chatgpt

function tbl = struct2Table(structArray)
    % struct2Table Converts a structure array of components into a MATLAB table.

    requiredFields = {'ID','Name','Material','Weight'};
    nestedFields = {'Length','Width','Height'};

    if isempty(structArray)
        % Create an empty table with the required column names and no rows
        tbl = table('Size',[0,7], ...
                    'VariableNames', {'ID','Name','Length','Width','Height','Material','Weight'}, ...
                    'VariableTypes', {'double','string','double','double','double','string','double'});
        return;
    end

    % Check top-level fields
    for f = requiredFields
        if ~isfield(structArray, f{1})
            error('The structure array is missing the required field "%s".', f{1});
        end
    end

    % Check nested fields in Dimensions
    if ~isfield(structArray, 'Dimensions')
        error('The structure array is missing the "Dimensions" field.');
    end

    for f = nestedFields
        % Check if every element has Dimensions.<field>
        for i = 1:numel(structArray)
            if ~isfield(structArray(i).Dimensions, f{1})
                error('The structure array is missing the Dimensions field "%s" in one or more elements.', f{1});
            end
        end
    end

    % Extract the data
    % Preallocate arrays
    n = numel(structArray);
    IDs = zeros(n,1);
    Names = strings(n,1);
    Lengths = zeros(n,1);
    Widths = zeros(n,1);
    Heights = zeros(n,1);
    Materials = strings(n,1);
    Weights = zeros(n,1);

    for i = 1:n
        IDs(i) = structArray(i).ID;
        Names(i) = string(structArray(i).Name);
        Lengths(i) = structArray(i).Dimensions.Length;
        Widths(i) = structArray(i).Dimensions.Width;
        Heights(i) = structArray(i).Dimensions.Height;
        Materials(i) = string(structArray(i).Material);
        Weights(i) = structArray(i).Weight;
    end

    % Create the table
    tbl = table(IDs, Names, Lengths, Widths, Heights, Materials, Weights, ...
        'VariableNames', {'ID','Name','Length','Width','Height','Material','Weight'});
end
