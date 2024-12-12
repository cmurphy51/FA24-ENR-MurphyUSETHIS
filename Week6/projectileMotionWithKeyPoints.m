%Connor Murphy
%Assisted by chatgpt

function projectileMotionWithKeyPoints(v0, angle, g)
% projectileMotionWithKeyPoints Plots the trajectory of a projectile and key points.
%
% Inputs:
%   v0    - Initial velocity (m/s)
%   angle - Launch angle (degrees)
%   g     - Gravitational acceleration (m/s^2)
%
% Outputs:
%   A plot of the projectile trajectory with apex and range marked,
%   and a second plot of kinetic and potential energy vs. time.

    % Convert angle to radians
    theta = deg2rad(angle);

    % Calculate time of flight
    t_flight = (2 * v0 * sin(theta)) / g;

    % Create time vector
    t = linspace(0, t_flight, 200);

    % Compute positions over time
    x = v0 * cos(theta) * t;
    y = v0 * sin(theta) * t - 0.5 * g * t.^2;

    % Apex (highest altitude)
    % Occurs at t_apex = v0*sin(theta)/g
    t_apex = (v0 * sin(theta)) / g;
    x_apex = v0 * cos(theta) * t_apex;
    y_apex = y(find(t >= t_apex, 1)); % or directly (v0*sin(theta))^2/(2*g)

    % Maximum range: R = (v0^2 * sin(2*theta)) / g
    R = (v0^2 * sin(2*theta)) / g;
    % The projectile lands at t = t_flight, so x(end) should be approximately R
    % We'll use the formula R for accuracy

    % Plot the trajectory
    figure;
    plot(x, y, 'b-', 'LineWidth', 2);
    hold on;
    % Mark the apex
    plot(x_apex, y_apex, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Apex');
    % Mark the landing point (maximum range)
    plot(R, 0, 'gx', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Max Range');
    hold off;
    xlabel('Horizontal Distance (m)');
    ylabel('Vertical Height (m)');
    title(sprintf('Projectile Trajectory (v0=%.1f m/s, angle=%.1f°)', v0, angle));
    legend('Trajectory', 'Apex', 'Max Range', 'Location', 'best');
    grid on;

    % Energy calculations
    % Assume mass m = 1 kg
    m = 1; 
    vx = v0 * cos(theta);    % constant horizontal velocity component
    vy = v0 * sin(theta) - g * t; % vertical velocity changes with time
    KE = 0.5 * m * (vx.^2 + vy.^2);  % Kinetic Energy = 1/2 m(vx^2 + vy^2)
    PE = m * g * y;                % Potential Energy = m g y

    % Plot kinetic and potential energy over time
    figure;
    area(t, KE, 'FaceColor', 'r', 'FaceAlpha', 0.3, 'DisplayName', 'Kinetic Energy');
    hold on;
    area(t, PE, 'FaceColor', 'b', 'FaceAlpha', 0.3, 'DisplayName', 'Potential Energy');
    hold off;
    xlabel('Time (s)');
    ylabel('Energy (J)');
    title('Kinetic and Potential Energy over Time');
    legend('Location', 'best');
    grid on;

end
