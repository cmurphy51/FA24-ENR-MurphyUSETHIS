%Connor Murphy
%Assisted by chatgpt

function avgVelocity = calculateAverageVelocity(particle)
    % calculateAverageVelocity - Calculates the average velocity of a particle over time
    %
    % Syntax:
    %   avgVelocity = calculateAverageVelocity(particle)
    %
    % Inputs:
    %   particle - Structure containing particle data.
    %              Required Fields:
    %                 - Position: Nx3 array of [x, y, z] positions.
    %                 - Time: Nx1 array of timestamps.
    %
    % Outputs:
    %   avgVelocity - Average velocity of the particle (scalar).
    %
    % Example:
    %   particle.Position = [0, 0, 0; 1, 1, 1; 2, 2, 2];
    %   particle.Time = [0; 1; 2];
    %   avgVel = calculateAverageVelocity(particle);
    %   disp(avgVel); % Output: 1.7321

    %% Input Validation
    if ~isstruct(particle)
        error('Input "particle" must be a structure.');
    end

    requiredFields = {'Position', 'Time'};
    for i = 1:length(requiredFields)
        if ~isfield(particle, requiredFields{i})
            error('Particle structure must contain the field "%s".', requiredFields{i});
        end
    end

    Positions = particle.Position;
    Times = particle.Time;

    % Check that Positions is an Nx3 array
    if ~ismatrix(Positions) || size(Positions, 2) ~= 3
        error('Field "Position" must be an Nx3 array representing [x, y, z] positions.');
    end

    % Check that Times is an Nx1 array
    if ~isvector(Times) || length(Times) ~= size(Positions, 1)
        error('Field "Time" must be an Nx1 array corresponding to each position.');
    end

    % Ensure that Times are in ascending order
    if any(diff(Times) <= 0)
        error('Timestamps in "Time" must be in strictly ascending order.');
    end

    %% Calculate Total Distance Traveled
    % Initialize total distance
    totalDistance = 0;

    % Iterate through each consecutive pair of positions to calculate distance
    for i = 2:length(Times)
        posPrev = Positions(i-1, :);
        posCurr = Positions(i, :);
        distance = norm(posCurr - posPrev); % Euclidean distance
        totalDistance = totalDistance + distance;
    end

    %% Calculate Total Time Elapsed
    totalTime = Times(end) - Times(1);

    if totalTime <= 0
        error('Total time elapsed must be positive.');
    end

    %% Compute Average Velocity
    avgVelocity = totalDistance / totalTime;

    %% (Optional) Display Information
    if isfield(particle, 'Name')
        fprintf('Average velocity for "%s": %.4f units/time\n', particle.Name, avgVelocity);
    else
        fprintf('Average velocity: %.4f units/time\n', avgVelocity);
    end
end
