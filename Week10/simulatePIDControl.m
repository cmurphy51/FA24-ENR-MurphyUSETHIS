%Connor Murphy
%Assisted by chatgpt

function [time, position] = simulatePIDControl(m, c, k, kP, kI, kD, setpoint)
    % simulatePIDControl Simulates a PID-controlled spring-damping system
    %
    %   [time, position] = simulatePIDControl(m, c, k, kP, kI, kD, setpoint)
    %
    %   Inputs:
    %       m        - Mass (kg)
    %       c        - Damping coefficient (N·s/m)
    %       k        - Spring constant (N/m)
    %       kP       - Proportional gain
    %       kI       - Integral gain
    %       kD       - Derivative gain
    %       setpoint - Desired position (m)
    %
    %   Outputs:
    %       time     - Time vector (s)
    %       position - Position vector (m)

    % Define the transfer function of the spring-damping system
    sys = tf([1], [m, c, k]);

    % Define PID controller
    pid_controller = pid(kP, kI, kD);

    % Closed-loop system with unity feedback
    closed_sys = feedback(pid_controller * sys, 1);

    % Simulation time
    simulation_time = 10; % seconds
    num_points = 1000;
    time = linspace(0, simulation_time, num_points);

    % Step response to the setpoint
    [y, ~] = step(closed_sys * setpoint, time);

    position = y;
end
