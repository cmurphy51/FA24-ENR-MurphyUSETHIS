%Connor Murphy
%assisted by chatgpt

function [sortedArray, comparisons] = bubbleSort(array)
    n = length(array);
    sortedArray = array;
    comparisons = 0;
    for i = 1:n
        for j = 1:n-i
            comparisons = comparisons + 1;
            if sortedArray(j) > sortedArray(j+1)
                % Swap
                temp = sortedArray(j);
                sortedArray(j) = sortedArray(j+1);
                sortedArray(j+1) = temp;
            end
        end
    end
end
