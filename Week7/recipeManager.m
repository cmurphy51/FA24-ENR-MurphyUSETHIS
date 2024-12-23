%Connor Murphy 
%Assisted by chatgpt

% recipeManager.m
% A script to manage recipes and an ingredient inventory

% Clear workspace
clear;
clc;

%% Step 1: Initialize Recipes and Inventory

% Define recipes as a cell array
recipes = {
    'Pancakes', {struct('Name', 'Flour', 'Quantity', 2, 'Unit', 'cups'), ...
                 struct('Name', 'Eggs', 'Quantity', 2, 'Unit', 'pieces'), ...
                 struct('Name', 'Milk', 'Quantity', 1.5, 'Unit', 'cups')};
    'Omelette', {struct('Name', 'Eggs', 'Quantity', 3, 'Unit', 'pieces'), ...
                 struct('Name', 'Cheese', 'Quantity', 0.5, 'Unit', 'cups'), ...
                 struct('Name', 'Milk', 'Quantity', 0.25, 'Unit', 'cups')}
};

% Display recipes
disp('Available Recipes:');
for i = 1:size(recipes, 1)
    fprintf('%d. %s\n', i, recipes{i, 1});
    ingredients = recipes{i, 2};
    for j = 1:numel(ingredients)
        fprintf('   - %s: %.2f %s\n', ingredients{j}.Name, ingredients{j}.Quantity, ingredients{j}.Unit);
    end
end

% Create an ingredient inventory table
inventoryTable = table({'Flour'; 'Eggs'; 'Milk'; 'Cheese'}, ...
                       [10; 12; 5; 2], ...
                       {'cups'; 'pieces'; 'cups'; 'cups'}, ...
                       'VariableNames', {'Name', 'Quantity', 'Unit'});

disp('Initial Inventory:');
disp(inventoryTable);

%% Step 2: Save and Load Inventory

% Save inventory to CSV
csvFileName = 'ingredientInventory.csv';
writetable(inventoryTable, csvFileName);
disp(['Inventory saved to ', csvFileName]);

% Load inventory from CSV
loadedInventoryTable = readtable(csvFileName);
disp('Loaded Inventory:');
disp(loadedInventoryTable);

%% Step 3: Select a Recipe and Update Inventory

% Prompt the user to select a recipe
recipeIndex = input('Select a recipe by number: ');

if recipeIndex < 1 || recipeIndex > size(recipes, 1)
    error('Invalid recipe selection.');
end

selectedRecipe = recipes{recipeIndex, 2};
disp(['Selected Recipe: ', recipes{recipeIndex, 1}]);

% Update inventory based on the selected recipe
for i = 1:numel(selectedRecipe)
    ingredient = selectedRecipe{i};
    % Find the ingredient in the inventory
    idx = find(strcmp(inventoryTable.Name, ingredient.Name));
    if isempty(idx)
        error('Ingredient "%s" is not available in inventory.', ingredient.Name);
    elseif inventoryTable.Quantity(idx) < ingredient.Quantity
        error('Insufficient "%s" in inventory. Required: %.2f, Available: %.2f', ...
              ingredient.Name, ingredient.Quantity, inventoryTable.Quantity(idx));
    end
    % Deduct the ingredient quantity from the inventory
    inventoryTable.Quantity(idx) = inventoryTable.Quantity(idx) - ingredient.Quantity;
end

disp('Updated Inventory:');
disp(inventoryTable);

% Save the updated inventory
writetable(inventoryTable, csvFileName);
disp(['Updated inventory saved to ', csvFileName]);
