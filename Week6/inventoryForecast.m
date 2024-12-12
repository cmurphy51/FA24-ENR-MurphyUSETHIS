%Connor Murphy
%Assisted by chatgpt

function [inventoryOverTime, y_future] = inventoryForecast(upc, totalDays, futureDays, inventoryFile, usageFile)
% inventoryForecast Forecasts future inventory levels of a specified ingredient.
%
% Inputs:
%   upc (string or numeric): UPC code of the ingredient to analyze.
%   totalDays (integer): Number of days over which inventory history is analyzed.
%   futureDays (integer): Number of days to forecast into the future.
%   inventoryFile (string): CSV file with initial inventory data (upc, ingredient, qty).
%   usageFile (string): CSV file with usage log (day, upc, qty), negative = usage, positive = purchase.
%
% Outputs:
%   inventoryOverTime (vector): Inventory levels for each of the totalDays.
%   y_future (vector): Forecasted inventory levels for the next futureDays.

    % Validate input arguments
    if nargin < 5
        error('Not enough input arguments. Provide upc, totalDays, futureDays, inventoryFile, and usageFile.');
    end
    if ~isnumeric(totalDays) || totalDays <= 0 || mod(totalDays,1)~=0
        error('totalDays must be a positive integer.');
    end
    if ~isnumeric(futureDays) || futureDays < 0 || mod(futureDays,1)~=0
        error('futureDays must be a non-negative integer.');
    end
    if ~exist(inventoryFile, 'file')
        error('Inventory file "%s" does not exist.', inventoryFile);
    end
    if ~exist(usageFile, 'file')
        error('Usage file "%s" does not exist.', usageFile);
    end

    % Convert UPC to string
    if isnumeric(upc)
        upc_str = num2str(upc);
    else
        upc_str = char(upc);
    end

    % Read the inventory data
    Tinv = readtable(inventoryFile);
    requiredColsInv = {'upc','ingredient','qty'};
    if ~all(ismember(requiredColsInv, Tinv.Properties.VariableNames))
        error('Inventory file must contain columns: %s', strjoin(requiredColsInv, ', '));
    end

    % Find the initial quantity for the given UPC
    matchInv = strcmp(Tinv.upc, upc_str);
    if ~any(matchInv)
        error('UPC %s not found in the inventory file.', upc_str);
    end
    initialQty = Tinv.qty(matchInv);
    if length(initialQty) > 1
        warning('Multiple entries found for UPC %s in the inventory. Using the first entry.', upc_str);
        initialQty = initialQty(1);
    end

    % Read the usage data
    Tuse = readtable(usageFile);
    requiredColsUse = {'day','upc','qty'};
    if ~all(ismember(requiredColsUse, Tuse.Properties.VariableNames))
        error('Usage file must contain columns: %s', strjoin(requiredColsUse, ', '));
    end

    % Filter usage data for the given UPC and valid days
    usageForUPC = Tuse(strcmp(Tuse.upc, upc_str) & Tuse.day >= 1 & Tuse.day <= totalDays, :);

    % Initialize inventory tracking
    inventoryOverTime = zeros(totalDays,1);
    % Set the first day inventory to initialQty directly
    inventoryOverTime(1) = initialQty;

    % Apply daily usage/purchase changes starting from Day 2
    for d = 2:totalDays
        dayUsage = usageForUPC.qty(usageForUPC.day == d);
        if isempty(dayUsage)
            dailyChange = 0;
        else
            dailyChange = sum(dayUsage);
        end
        inventoryOverTime(d) = inventoryOverTime(d-1) + dailyChange;
    end

    % Forecast future inventory using a linear fit (degree 1 polynomial)
    x = (1:totalDays)';
    y = inventoryOverTime;
    if totalDays == 1
        % If only one data point, no slope can be determined reliably
        % Assume no change over time
        p = [0, y(end)];
    else
        p = polyfit(x, y, 1);
    end

    x_future = (totalDays+1:totalDays+futureDays)';
    y_future = polyval(p, x_future);
    y_future(y_future < 0) = 0;  % Clamp negative forecasts to zero

end
