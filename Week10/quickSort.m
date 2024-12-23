%Connor Murphy
%Assisted by chatgpt

function [sortedArray, comparisons] = quickSort(array)
    [sortedArray, comparisons] = quickSortHelper(array, 1, length(array), 0);
end

function [array, comparisons] = quickSortHelper(array, low, high, comparisons)
    if low < high
        [array, pi, comps] = partition(array, low, high);
        comparisons = comparisons + comps;
        [array, comparisons] = quickSortHelper(array, low, pi-1, comparisons);
        [array, comparisons] = quickSortHelper(array, pi+1, high, comparisons);
    end
end

function [array, pi, comparisons] = partition(array, low, high)
    pivot = array(high);
    i = low - 1;
    comparisons = 0;
    for j = low:high-1
        comparisons = comparisons + 1;
        if array(j) < pivot
            i = i + 1;
            % Swap
            temp = array(i);
            array(i) = array(j);
            array(j) = temp;
        end
    end
    % Swap pivot
    temp = array(i+1);
    array(i+1) = array(high);
    array(high) = temp;
    pi = i + 1;
end
