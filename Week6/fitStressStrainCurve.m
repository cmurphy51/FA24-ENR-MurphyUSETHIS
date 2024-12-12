%Connor Murphy
%Assisted by chatgpt

function [p, R_squared] = fitStressStrainCurve(materialName, degree, showPlot)
% fitStressStrainCurve Fits a polynomial to stress-strain data and computes the R-squared value.
%
% Syntax:
%   [p, R_squared] = fitStressStrainCurve(materialName)
%   [p, R_squared] = fitStressStrainCurve(materialName, degree)
%   [p, R_squared] = fitStressStrainCurve(materialName, degree, showPlot)
%
% Inputs:
%   materialName (string/char) - Name of the material, the function will look for <materialName>.csv
%   degree (optional, integer) - The degree of the polynomial fit. Default = 2.
%   showPlot (optional, logical) - Whether to display the plot. Default = true.
%
% Outputs:
%   p (vector) - Coefficients of the fitted polynomial (highest power first).
%   R_squared (scalar) - Coefficient of determination (R²) for the fit.
%
% The CSV file should contain 'Strain' and 'Stress' columns.

    % Check the number of input arguments and set defaults
    if nargin < 1
        error('You must provide at least the materialName as an input argument.');
    end
    if nargin < 2 || isempty(degree)
        degree = 2;
    end
    if nargin < 3 || isempty(showPlot)
        showPlot = true;
    end

    % Ensure materialName is a character array
    if ~ischar(materialName) && ~isstring(materialName)
        error('materialName must be a string or character array.');
    end
    materialName = char(materialName);

    % Construct the filename and check if it exists
    filename = sprintf('%s.csv', materialName);
    if ~exist(filename, 'file')
        error('The file "%s" does not exist.', filename);
    end

    % Read data from CSV
    T = readtable(filename);

    % Check for required columns
    if ~all(ismember({'Strain','Stress'}, T.Properties.VariableNames))
        error('The file %s must contain "Strain" and "Stress" columns.', filename);
    end

    Strain = T.Strain;
    Stress = T.Stress;

    % Fit a polynomial of the specified degree
    p = polyfit(Strain, Stress, degree);

    % Evaluate the polynomial fit at the given Strain values
    Stress_fit = polyval(p, Strain);

    % Calculate R-squared
    SS_res = sum((Stress - Stress_fit).^2);
    SS_tot = sum((Stress - mean(Stress)).^2);
    R_squared = 1 - (SS_res/SS_tot);

    % Optional plotting
    if showPlot
        figure;
        scatter(Strain, Stress, 'filled');
        hold on;

        % Plot a smoother curve for the fitted polynomial
        Strain_fine = linspace(min(Strain), max(Strain), 200);
        Stress_fit_fine = polyval(p, Strain_fine);
        plot(Strain_fine, Stress_fit_fine, 'r-', 'LineWidth', 2);

        xlabel('Strain');
        ylabel('Stress');
        title(sprintf('%s: Polynomial Fit (deg=%d, R^{2}=%.4f)', materialName, degree, R_squared));
        legend('Data', 'Fitted Curve', 'Location', 'best');
        grid on;
        hold off;
    end
end
