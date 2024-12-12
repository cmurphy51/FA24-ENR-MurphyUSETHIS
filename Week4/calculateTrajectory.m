%Connor Murphy
%Assisted by chatgpt

function [x, y, time] = calculateTrajectory(v0, angle, g, y0, numValues)
    % Compute components of initial velocity
    vx = v0 * cosd(angle);
    vy = v0 * sind(angle);

    % Adjust discriminant and total flight time for initial height y0
    discriminant = vy^2 + 2 * g * y0;
    if discriminant < 0
        error('Invalid parameters: Projectile does not follow a real trajectory.');
    end
    total_time = (vy + sqrt(discriminant)) / g;

    % Generate time array
    time = linspace(0, total_time, numValues);

    % Compute positions with initial height y0
    x = vx * time;
    y = y0 + vy * time - 0.5 * g * time.^2;

    % Ensure non-negative vertical positions if needed
    y(y < 0) = 0;
end
