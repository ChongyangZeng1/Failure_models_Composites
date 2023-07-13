% Linear elastic material properties
E = 1e9; % Young's modulus
nu = 0.3; % Poisson's ratio

% Function to calculate the strain energy release rate for matrix cracking
function SERR = calculate_SERR_matrix_crack(sigma_x, sigma_y, sigma_z)
    % Calculate the strain components
    epsilon_x = sigma_x / E;
    epsilon_y = sigma_y / E;
    epsilon_z = sigma_z / E;

    % Calculate the strain energy release rate for matrix cracking
    SERR = 0.5 * (epsilon_x^2 + epsilon_y^2 - epsilon_x * epsilon_y + epsilon_z^2) / (1 - nu^2);
end

% Generate stress values for plotting
sigma_x = linspace(-1000, 1000, 100); % Range of stress values along X-axis
sigma_y = linspace(-1000, 1000, 100); % Range of stress values along Y-axis
sigma_z = linspace(-1000, 1000, 100); % Range of stress values along Z-axis

% Create a grid of stress values
[Sigma_X, Sigma_Y, Sigma_Z] = meshgrid(sigma_x, sigma_y, sigma_z);

% Calculate strain energy release rate (SERR) for matrix cracking
SERR_matrix_crack = calculate_SERR_matrix_crack(Sigma_X, Sigma_Y, Sigma_Z);

% Rest of the code for plotting the failure envelope remains the same


