%Connor Murphy
%Assisted by Chatgpt

function gearRatio = gearRatioCalc(driverTeeth, drivenTeeth)
    % gearRatioCalc computes the gear ratio given the driver and driven teeth counts.
    %
    % Inputs:
    %   driverTeeth - Number of teeth on the driver gear (scalar)
    %   drivenTeeth - Number of teeth on the driven gear (scalar)
    %
    % Output:
    %   gearRatio   - The computed gear ratio (scalar)
    %
    % Formula:
    %   gearRatio = drivenTeeth / driverTeeth
    
    % Compute the gear ratio
    gearRatio = drivenTeeth / driverTeeth;
end
