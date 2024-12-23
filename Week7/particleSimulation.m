%Connor Murphy
%Assisted by chatgpt

% particleSimulation.m
% MATLAB Script to Simulate Particle Motion, Analyze Average Velocities, and Plot Trajectories
% Utilizes simulateParticleMotion and calculateAverageVelocity functions
% Saves and loads data using particleData.mat

%% 1. Clear Workspace and Command Window
clc;        % Clear command window
clear;      % Remove all variables from workspace
close all;  % Close all figure windows

%% 2. Define Simulation Parameters
numParticles = 5;       % Number of particles to simulate
numTimeSteps = 100;     % Number of time steps in the simulation

%% 3. Simulate Particle Motion
% Generate simulated particle data
particles = simulateParticleMotion(numParticles, numTimeSteps);

%% 4. Save Simulated Data to MAT-file
saveFileName = 'particleData.mat';
save(saveFileName, 'particles');
fprintf('Simulated particle data saved to %s.\n', saveFileName);

%% 5. Load Data from MAT-file
if isfile(saveFileName)
    loadedData = load(saveFileName, 'particles');
    particles = loadedData.particles;
    fprintf('Particle data loaded from %s.\n', saveFileName);
else
    error('File %s does not exist. Ensure simulation data is saved correctly.', saveFileName);
end

% 6. Calculate Average Velocities for Each Particle
% Initialize array to store average velocities
averageVelocities = zeros(numParticles, 1);

% Iterate through each particle and calculate average velocity
for i = 1:numParticles
    particle = particles(i);
    averageVelocities(i) = calculateAverageVelocity(particle);
end

% 7. Store Results in a Table
% Create a table to display particle IDs and their average velocities
particleIDs = [particles.ID]';
velocityUnits = 'units/time'; % Replace with actual units if known (e.g., m/s)

% Create the table
resultsTable = table(particleIDs, averageVelocities, ...
                     'VariableNames', {'ParticleID', 'AverageVelocity'});

% Display the results table
disp('Average Velocities of Particles:');
disp(resultsTable);

%% 8. Plot 3D Trajectories of All Particles
figure;
hold on;
grid on;
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
title('3D Trajectories of Simulated Particles');

% Define colors for different particles
colors = lines(numParticles); % Generates distinct colors

% Plot each particle's trajectory
for i = 1:numParticles
    particle = particles(i);
    positions = particle.Position; % Access 'Position' field
    plot3(positions(:,1), positions(:,2), positions(:,3), 'Color', colors(i,:), ...
          'LineWidth', 2, 'DisplayName', sprintf('Particle %d', particle.ID));
end

% Add legend
legend('show', 'Location', 'best');

% Adjust view angle for better visualization
view(45, 30);

% Hold off to prevent further plotting on the same figure
hold off;

% 9. (Optional) Save the Plot as an Image
% Uncomment the following lines to save the plot as a PNG image
% saveas(gcf, 'particleTrajectories.png');
% fprintf('3D trajectories plot saved as particleTrajectories.png.\n');

% End of Script


