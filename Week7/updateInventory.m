%Connor Murphy
%Assisted by chatgpt

function inventoryTable = updateInventory(inventoryTable, recipeCell)
    % updateInventory - Updates inventory based on a recipe
    %
    % Inputs:
    %   inventoryTable - Table containing the current inventory.
    %                    Columns: 'Name', 'Quantity', 'Unit'
    %   recipeCell - Cell array representing a recipe.
    %                Format: {'RecipeName', {struct('Name', ..., 'Quantity', ..., 'Unit', ...), ...}}
    %
    % Outputs:
    %   inventoryTable - Updated inventory table with reduced quantities.

    %% Validate inventoryTable structure
    requiredColumns = {'Name', 'Quantity', 'Unit'};
    if ~istable(inventoryTable) || ~all(ismember(requiredColumns, inventoryTable.Properties.VariableNames))
        error('inventoryTable must be a table with columns: ''Name'', ''Quantity'', and ''Unit''.');
    end

    % Ensure 'Quantity' is numeric and non-negative
    if ~isnumeric(inventoryTable.Quantity) || any(inventoryTable.Quantity < 0)
        error('The ''Quantity'' column in inventoryTable must be numeric and non-negative.');
    end

    %% Validate recipeCell format
    if ~iscell(recipeCell) || size(recipeCell, 1) ~= 1 || size(recipeCell, 2) ~= 2
        error('recipeCell must be a 1x2 cell array: {''RecipeName'', {ingredientStructs}}.');
    end

    % Extract recipe name and ingredients
    recipeName = recipeCell{1, 1};
    ingredientList = recipeCell{1, 2};

    % Validate ingredientList
    if ~iscell(ingredientList)
        error('The second element of recipeCell must be a cell array of ingredient structs.');
    end

    %% Loop through each ingredient in the recipe
    for i = 1:length(ingredientList)
        ingredient = ingredientList{i};

        % Validate ingredient structure
        if ~isstruct(ingredient) || ~all(isfield(ingredient, {'Name', 'Quantity', 'Unit'}))
            error('Each ingredient must be a struct with fields ''Name'', ''Quantity'', and ''Unit''.');
        end

        itemName = ingredient.Name;
        itemQuantity = ingredient.Quantity;
        % Unit is present but not utilized in this function

        % Validate itemName and itemQuantity
        if ~ischar(itemName) && ~isstring(itemName)
            error('Ingredient ''Name'' must be a string or character array.');
        end
        if ~isnumeric(itemQuantity) || itemQuantity < 0
            error('Ingredient ''Quantity'' must be a non-negative number.');
        end

        %% Find the item in the inventory table
        itemIndex = find(strcmpi(inventoryTable.Name, itemName));

        if isempty(itemIndex)
            error('Item "%s" not found in inventory.', itemName);
        elseif length(itemIndex) > 1
            error('Duplicate entries for "%s" found in inventory.', itemName);
        end

        %% Check if sufficient quantity exists
        if inventoryTable.Quantity(itemIndex) < itemQuantity
            error('Insufficient quantity for "%s" in inventory.', itemName);
        end

        %% Update inventory
        inventoryTable.Quantity(itemIndex) = inventoryTable.Quantity(itemIndex) - itemQuantity;
    end
end
