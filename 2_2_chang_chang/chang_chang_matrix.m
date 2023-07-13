clear
close all
clc
% chang-chang model
% In the plan stress state 

ft1 = 400;
ft2 = 400;
fc1 = 500;
fc2 = 500;
fv4 = 85;
% beta = 0.5;

Xt = 400;
Yt = 400;
Xc = 500;
Yc = 500;
Sc = 85;
beta = 0.5;
%%
% Range of stress components
sigma1_range = linspace(-500, 500, 100);
sigma2_range = linspace(0, 500, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
chang_matrix1 = (sigma2.^2)/(Yt.^2) + (tau12.^2)/(Sc.^2);

isosurface_threshold = 1;
%
h1 = patch(isosurface(sigma1, sigma2, tau12, chang_matrix1, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,chang_matrix1,h1)
isocolors(sigma1, sigma2, tau12,tau12,h1)
% h1.FaceColor = 'interp';
h1.FaceColor = 'r';
h1.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h1, 'FaceAlpha', 0.2);
grid on;
view(3);
%%
% Range of stress components
sigma1_range = linspace(-500, 500, 100);
sigma2_range = linspace(-500, 0, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
chang_matrix2 = (sigma2.^2)/((2*Sc).^2) + ((Yc./(2.*Sc).^2)-1).*(sigma2./Yc)...
    + (tau12.^2)/(Sc.^2);

isosurface_threshold = 1;
%
h2 = patch(isosurface(sigma1, sigma2, tau12, chang_matrix2, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,chang_matrix2,h2)
isocolors(sigma1, sigma2, tau12,tau12,h2)
% h2.FaceColor = 'interp';
h2.FaceColor = 'b';
h2.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h2, 'FaceAlpha', 0.2);
%%
xlim([-600 600])
xticks(-600:200:600)
ylim([-600 600])
yticks(-600:200:600)
zlim([-200 200])
zticks(-200:100:200)

xlabel('\sigma_{11}','Rotation',20);
ylabel('\sigma_{22}','Rotation',-25);
zlabel('\tau_{12}');

% axis equal;
grid on;
view(3);
%%
% Experimental results from the pure shear test
SH_sigma1 = 0; % Replace with your experimental value
SH_sigma2 = 0; % Replace with your experimental value
SH_tau12 = fv4; % Replace with your experimental value
% Experimental results from the 0° tension
T0_sigma1 = ft1; 
T0_sigma2 = 0; 
T0_tau12 = 0; 
% Experimental results from the 90°
T90_sigma1 = 0; 
T90_sigma2 = ft2; 
T90_tau12 = 0;
% Experimental results from the 0° compression
C0_sigma1 = -fc1; 
C0_sigma2 = 0; 
C0_tau12 = 0; 
% Experimental results from the 90° compression
C90_sigma1 = 0; 
C90_sigma2 = -2*Sc+30; % it dependes on the Sc and Yc
C90_tau12 = 0;
% Plot the experimental point on the 3D surface
hold on;
plot3(SH_sigma1, SH_sigma2, SH_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
% plot3(T0_sigma1, T0_sigma2, T0_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot3(T90_sigma1, T90_sigma2, T90_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
% plot3(C0_sigma1, C0_sigma2, C0_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot3(C90_sigma1, C90_sigma2, C90_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
set(gca,'xcolor','k','ycolor','k','zcolor','k','linewidth',1.5,'FontSize',14,'GridColor',...
    [0 0 1])
% legend('Hill48 Yield Surface', 'von Mises Yield Surface', 'Experimental Result');
% l = legend({'Mon Mises','Hill 48','Experimental'}...
%     ,'FontSize',12,'Position',[0.54804762405015 0.766269845740191 0.258928566426039 0.161904757434413]);
% hold off;
legend off
% legend boxoff
% grid off
view([-8.06540462663144 21.0564963843214]);
print(gcf,'-dtiffn','chang_matrix_1')
view([0 90]);
print(gcf,'-dtiffn','chang_matrix_2')
view([0 1]);
colorbar off
print(gcf,'-dtiffn','chang_matrix_3')
view([-90 1]);
colorbar off
print(gcf,'-dtiffn','chang_matrix_4')