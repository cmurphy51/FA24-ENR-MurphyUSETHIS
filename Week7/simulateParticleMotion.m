%Connor Murphy 
%Assisted by chatgpt

function particles = simulateParticleMotion(numParticles, numTimeSteps)
    % simulateParticleMotion - Simulates motion of particles in 3D space
    %
    % Syntax:
    %   particles = simulateParticleMotion(numParticles, numTimeSteps)
    %
    % Inputs:
    %   numParticles  - Number of particles to simulate (positive integer)
    %   numTimeSteps  - Number of time steps in the simulation (positive integer)
    %
    % Outputs:
    %   particles      - Structure array containing simulated particle data
    %                    Each structure has fields:
    %                       ID        - Particle identifier (integer)
    %                       Positions - numTimeSteps x 3 matrix of [X, Y, Z] positions
    %                       Times     - numTimeSteps x 1 vector of time points

    %% Input Validation
    if ~isscalar(numParticles) || numParticles <= 0 || floor(numParticles) ~= numParticles
        error('numParticles must be a positive integer scalar.');
    end
    if ~isscalar(numTimeSteps) || numTimeSteps <= 0 || floor(numTimeSteps) ~= numTimeSteps
        error('numTimeSteps must be a positive integer scalar.');
    end

    %% Initialize the Structure Array
    % Preallocate for efficiency
    particles(numParticles) = struct('ID', [], 'Positions', [], 'Times', []);

    % Define the standard deviation for step size (controls randomness)
    stepStdDev = 1; % Adjust as needed for different motion randomness

    %% Simulate Motion for Each Particle
    for p = 1:numParticles
        % Assign a unique ID to each particle
        particles(p).ID = p;

        % Preallocate positions matrix
        % Each row corresponds to a time step, columns correspond to x, y, z
        positions = zeros(numTimeSteps, 3);

        % Define time points (e.g., 1 second intervals)
        timeStepDuration = 1; % You can adjust this as needed
        times = (0:numTimeSteps-1)' * timeStepDuration; % numTimeSteps x 1 vector

        % Initialize the first position randomly within a specified range
        initialPosition = 20 * rand(1, 3) - 10; % Positions between -10 and 10
        positions(1, :) = initialPosition;

        % Generate positions for subsequent time steps
        for t = 2:numTimeSteps
            % Generate random displacement for each axis using Gaussian distribution
            delta = stepStdDev * randn(1, 3);

            % Update position based on the previous position and displacement
            positions(t, :) = positions(t-1, :) + delta;
        end

        % Assign the positions matrix and times vector to the particle structure
        particles(p).Positions = positions;
        particles(p).Times = times;
    end
end
