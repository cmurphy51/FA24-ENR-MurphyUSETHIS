%Connor Murphy
%Assisted by chatgpt

function structArray = addComponent(structArray, componentStruct)
% addComponent Adds a new component structure to an existing structure array.
%
% Inputs:
%   structArray    - Existing array of component structures.
%   componentStruct - A single structure representing the new component to add.
%
% Output:
%   structArray    - The updated structure array containing the new component.

    % If structArray is empty, initialize it with the new component
    if isempty(structArray)
        structArray = componentStruct;
    else
        % Append the new component to the structure array
        structArray(end+1) = componentStruct;
    end
end
