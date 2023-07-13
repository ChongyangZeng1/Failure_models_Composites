clear
close all
clc
% Maximum Stress Criterion Failure Plot
% Define the range of stress values
sigma_11 = linspace(-500, 400, 100);
sigma_22 = linspace(-500, 400, 100);
sigma_12 = linspace(-85, 85, 100);

% Define the strength limits
Xt = 400;
Xc = -500;
Yt = 400;
Yc = -500;
S = 85;

% Create a meshgrid for the stress variables
[sigma_11, sigma_22, sigma_12] = meshgrid(sigma_11, sigma_22, sigma_12);

% Compute the failure criterion
failure_index = (sigma_11 >= Xt) + (abs(sigma_11) >= abs(Xc)) + (sigma_22 >= Yt) + (abs(sigma_22) >= abs(Yc)) + (sigma_12 >= S);

% Plot the failure criterion in 3D
figure;
scatter3(sigma_11(:), sigma_22(:), sigma_12(:), 10, failure_index(:), 'filled',...
    'MarkerEdgeColor','g','MarkerFaceColor','b');
% colorbar('Limits',[-100 100])

xlim([-500, 500]);
ylim([-500, 500]);
zlim([-100, 100]);

xlabel('\sigma_{11}');
ylabel('\sigma_{22}');
zlabel('\sigma_{12}');
% axis equal;
grid on;
view(3);
set(gca,'xcolor','k','ycolor','k','zcolor','k','linewidth',1.5,'FontSize',14,'GridColor',...
    [0 0 1])
legend off

print(gcf,'-dtiffn','Maximum_Stress_Criterion_1')
% title('Maximum_Stress_Criterion_1');