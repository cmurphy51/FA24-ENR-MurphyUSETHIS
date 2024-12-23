%Connor Murphy
%assisted by chatgpt

function [time, sensorReadings, motorSpeeds] = simulateLineFollowerPololu(kP, kI, kD, setpoint)
    % simulateLineFollowerPololu Simulates a PID-controlled line-following robot
    %
    %   [time, sensorReadings, motorSpeeds] = simulateLineFollowerPololu(kP, kI, kD, setpoint)
    %
    %   Inputs:
    %       kP       - Proportional gain
    %       kI       - Integral gain
    %       kD       - Derivative gain
    %       setpoint - Desired sensor reading
    %
    %   Outputs:
    %       time          - Time vector (s)
    %       sensorReadings - Simulated sensor readings over time
    %       motorSpeeds    - Simulated motor speeds over time

    % Simulation parameters
    simulation_time = 10; % seconds
    dt = 0.01;            % time step
    time = 0:dt:simulation_time;
    n = length(time);
    
    % Initialize variables
    sensorReadings = zeros(1, n);
    motorSpeeds = zeros(1, n);
    error = zeros(1, n);
    integral = 0;
    derivative = 0;
    previous_error = 0;
    
    % Simulate sensor noise
    noise = randn(1, n) * 50; % Adjust noise level as needed
    
    for i = 2:n
        % Simulate sensor reading with noise
        sensorReadings(i) = setpoint + noise(i);
        
        % Calculate error
        error(i) = setpoint - sensorReadings(i);
        
        % Integrate the error
        integral = integral + error(i) * dt;
        
        % Derivative of error
        derivative = (error(i) - previous_error) / dt;
        
        % PID output
        motorSpeed = kP * error(i) + kI * integral + kD * derivative;
        
        % Clamp motor speed to reasonable values (e.g., -100 to 100)
        motorSpeed = max(min(motorSpeed, 100), -100);
        
        motorSpeeds(i) = motorSpeed;
        
        % Update previous error
        previous_error = error(i);
    end
end
