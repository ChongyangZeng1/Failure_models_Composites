clear
close all
clc
% Tsai_Wu model
% http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
% In the stress state plane

ft1 = 400;
ft2 = 200;
fc1 = 500;
fc2 = 300;
fv4 = 85;

F1=1/ft1-1/fc1;
F2=1/ft2-1/fc2;
F11=1/(ft1.*fc1);
F22=1/(ft2.*fc2);
F44=1/(fv4.^2);
% -sqrt(F11.*F22) < F12 < sqrt(F11.*F22)
F12=sqrt(F11.*F22)/4;

% Range of stress components
sigma1_range = linspace(-600, 600, 100);
sigma2_range = linspace(-600, 600, 100);
tau12_range = linspace(-200, 200, 100);


% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
Tsai_Wu = F1.*sigma1 + F2.*sigma2 + F11.*(sigma1.^2) + F22.*(sigma2.^2) +...
    2*F12.*sigma1.*sigma2 + F44.*(tau12.^2);


isosurface_threshold = 1;

h1 = patch(isosurface(sigma1, sigma2, tau12, Tsai_Wu, isosurface_threshold));
% set(h1, 'FaceColor', 'b', 'EdgeColor', 'none', 'FaceAlpha', 0.3);
hold on;

isonormals(sigma1, sigma2, tau12,Tsai_Wu,h1)
isocolors(sigma1, sigma2, tau12,tau12,h1)
h1.FaceColor = 'interp';
h1.EdgeColor = 'none';
colorbar('Limits',[-100 100])
set(h1, 'FaceAlpha', 0.9);

xlim([-600 600])
xticks(-600:200:600)
ylim([-600 600])
yticks(-600:200:600)
zlim([-200 200])
zticks(-200:100:200)

xlabel('\sigma_{11}','Rotation',20);
ylabel('\sigma_{22}','Rotation',-25);
zlabel('\tau_{12}');

axis equal;
grid on;
view(3);

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
% Plot the experimental point on the 3D surface
hold on;
plot3(SH_sigma1, SH_sigma2, SH_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot3(T0_sigma1, T0_sigma2, T0_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot3(T90_sigma1, T90_sigma2, T90_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

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
print(gcf,'-dtiffn','Tasi_Wu_1')
view([0 90]);
print(gcf,'-dtiffn','Tasi_Wu_2')
view([0 0]);
colorbar off
print(gcf,'-dtiffn','Tasi_Wu_3')