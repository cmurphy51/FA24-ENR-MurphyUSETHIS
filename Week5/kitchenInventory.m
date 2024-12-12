%Connor Murphy
%Assisted by chatgpt

% kitchenInventory.m (Updated)
% This script displays a menu to the user and handles interactions with the inventory.
% New feature: Check for low-stock items.

clear; clc;

filename = 'inventory.csv';  % The inventory file

while true
    % Display main menu
    fprintf('----------------------------------\n');
    fprintf('| Welcome to the Kitchen Inventory Manager!\n|\n');
    fprintf('| Please select an option:\n');
    fprintf('| 1. Add an ingredient\n');
    fprintf('| 2. Print inventory list\n');
    fprintf('| 3. Check ingredient quantity by UPC\n');
    fprintf('| 4. Check for low-stock items\n');
    fprintf('| 0. Exit\n');
    fprintf('> ');
    
    choice = input('', 's');
    
    switch choice
        case '1'
            % Add an ingredient
            upc = input('Enter the UPC: ', 's');
            ingredient = input('Enter the ingredient name: ', 's');
            qty = input('Enter the quantity: ');
            addItemToStock(filename, upc, ingredient, qty);
            fprintf('Ingredient added successfully.\n');
            
        case '2'
            % Print the inventory list
            invTable = getInventoryList(filename);
            if isempty(invTable)
                fprintf('No inventory data found.\n');
            else
                disp(invTable);
            end
            
        case '3'
            % Check the quantity by UPC
            upc = input('Enter the UPC: ', 's');
            quantity = getStockQty(filename, upc);
            if quantity == -1
                fprintf('UPC not found in the inventory.\n');
            else
                fprintf('Quantity for UPC %s: %d\n', upc, quantity);
            end
            
        case '4'
            % Check for low-stock items
            threshold = input('Enter the low-stock threshold: ');
            lowStockItems = getLowStockItems(filename, threshold);
            if isempty(lowStockItems)
                fprintf('No items are at or below the low-stock threshold.\n');
            else
                fprintf('Low-stock items (qty <= %d):\n', threshold);
                disp(lowStockItems);
            end
            
        case '0'
            % Exit the script
            fprintf('Exiting...\n');
            break;
            
        otherwise
            fprintf('Invalid choice. Please try again.\n');
    end
end
