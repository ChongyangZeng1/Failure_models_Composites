clear
close all
clc
% LaRC03 model
% In the plan stress state 

ft1 = 400;
ft2 = 400;
fc1 = 500;
fc2 = 500;
fv4 = 85;

Xt = 400;
Yt = 400;
Xc = 300;
Yc = 300;
Sc = 85;
gamma12=0.1;
%% fiber 1 tensile
% Range of stress components
sigma1_range = linspace(0, 600, 100);
sigma2_range = linspace(-600, 600, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
LaRC03_fiber1 = (sigma1-gamma12*sigma2)/Xt;

isosurface_threshold = 1;
%
h1 = patch(isosurface(sigma1, sigma2, tau12, LaRC03_fiber1, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,LaRC03_fiber1,h1)
isocolors(sigma1, sigma2, tau12,tau12,h1)
% h1.FaceColor = 'interp';
h1.FaceColor = 'r';
h1.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h1, 'FaceAlpha', 0.2);
grid on;
view(3);
%% fiber2 compression 1
% Range of stress components
sigma1_range = linspace(-600, 0, 100);
sigma2_range = linspace(-600, 0, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

% equastion from Paper: doi:10.1016/j.compositesb.2011.06.018

alpha_0=53/90; % 90°
G12=1850; % Shear modulus MPa
GIIc_L=5; % exact value need to check 75 N/mm -> https://doi.org/10.1016/j.engfracmech.2016.11.027
t=0.5; %t ply thickness
Lambda44_0=1/G12;
Sis_L= sqrt(8*GIIc_L/(pi*t*Lambda44_0));

eta_L=-(Sis_L*cos(alpha_0))/(Yc*((cos(alpha_0)).^2));
Phi_C=atan((1-sqrt(1-4.*((Sis_L/Xc)+eta_L)*(Sis_L/Xc)))/(2.*(Sis_L/Xc+eta_L)));

phi=(abs(tau12)+(G12-Xc)*Phi_C)./(G12+sigma1-sigma2);
tau12_m=-cos(phi).*sin(phi).*sigma1+cos(phi).*sin(phi).*sigma2+cos(2.*phi).*tau12;
sigma2_m=((sin(phi)).^2).*sigma1+((cos(phi)).^2).*sigma2-sin(2.*phi).*tau12;

LaRC03_fiber2_1 = (abs(tau12_m)+eta_L.*(sigma2_m))./Sis_L;

isosurface_threshold = 1;
%
h2 = patch(isosurface(sigma1, sigma2, tau12, LaRC03_fiber2_1, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,LaRC03_fiber2_1,h2)
isocolors(sigma1, sigma2, tau12,tau12,h2)
% h2.FaceColor = 'interp';
h2.FaceColor = 'b';
h2.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h2, 'FaceAlpha', 0.5);
grid on;
xlim([-600 600])
xticks(-600:200:600)
ylim([-600 600])
yticks(-600:200:600)
zlim([-200 200])
zticks(-200:100:200)
xlabel('\sigma_{11}','Rotation',20);
ylabel('\sigma_{22}','Rotation',-25);
zlabel('\tau_{12}');
view(3);
%% fiber3 compression2
% Range of stress components
sigma1_range = linspace(-600, 0, 100);
sigma2_range = linspace(0, 600, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

alpha_0=53/90; % 90°
G12=1851; % Shear modulus MPa
GIc_L=5; % exact value need to check
GIIc_L=5; % exact value need to check
t=0.5; %t ply thickness
v21=0.06; % exact value need to check
E1=22400; % MPa
E2=22400; % MPa
Lambda22_0=2.*(1/E2-(v21.^2/E1));
Lambda44_0=1/G12;

Yis_T= sqrt(8.*GIc_L/(pi*t*Lambda22_0));
Sis_L= sqrt(8.*GIIc_L/(pi*t*Lambda44_0));

eta_L=-(Sis_L*cos(alpha_0))./(Yc*((cos(alpha_0)).^2));
Phi_C=atan((1-sqrt(1-4.*((Sis_L/Xc)+eta_L)*(Sis_L/Xc)))/(2.*(Sis_L/Xc+eta_L)));
phi=(abs(tau12)+(G12-Xc)*Phi_C)./(G12+sigma1-sigma2);

% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
g=(1.12.^2).*(Lambda22_0./Lambda44_0).*((Yt./Sc).^2);
tau12_m=-cos(phi).*sin(phi).*sigma1+cos(phi).*sin(phi).*sigma2+cos(2.*phi).*tau12;
sigma2_m=((sin(phi)).^2).*sigma1+((cos(phi)).^2).*sigma2-sin(2.*phi).*tau12;

LaRC03_fiber2_2 = (1-g).*(sigma2_m./Yis_T)+g.*((sigma2_m./Yis_T).^2)+...
    (tau12_m./Sis_L).^2;

isosurface_threshold = 1;
%
h3 = patch(isosurface(sigma1, sigma2, tau12, LaRC03_fiber2_2, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,LaRC03_fiber2_2,h3)
isocolors(sigma1, sigma2, tau12,tau12,h3)
% h2.FaceColor = 'interp';
h3.FaceColor = 'm';
h3.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h3, 'FaceAlpha', 0.5);
grid on;
view(3);
xlabel('\sigma_{11}','Rotation',20);
ylabel('\sigma_{22}','Rotation',-25);
zlabel('\tau_{12}');
%%
%% matrix1
% Range of stress components
sigma1_range = linspace(-600, 600, 100);
sigma2_range = linspace(0, 600, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

G12=1851; % Shear modulus MPa
GIc_L=5; % exact value need to check
GIIc_L=5; % exact value need to check
t=0.5; %t ply thickness
v21=0.06; % exact value need to check
E1=22400; % MPa
E2=22400; % MPa
Lambda22_0=2.*(1/E2-(v21.^2/E1));
Lambda44_0=1/G12;
Yis_T= sqrt(8.*GIc_L/(pi*t*Lambda22_0));
Sis_L= sqrt(8.*GIIc_L/(pi*t*Lambda44_0));
% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
g=1.12.^2.*(Lambda22_0/Lambda44_0).*((Yt/Sc).^2);

LaRC03_Matrix1 = (1-g).*(sigma2./Yis_T)+g.*(sigma2./Yis_T).^2+...
    (tau12./Sis_L).^2;

isosurface_threshold = 1;
%
h4 = patch(isosurface(sigma1, sigma2, tau12, LaRC03_Matrix1, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,LaRC03_Matrix1,h4)
isocolors(sigma1, sigma2, tau12,tau12,h4)
% h2.FaceColor = 'interp';
h4.FaceColor = 'g';
h4.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h4, 'FaceAlpha', 0.5);
grid on;
view(3);
%% matrix2_1
% Range of stress components
sigma1_range = linspace(-600, -Yc, 100);
sigma2_range = linspace(-600, 0, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

alpha_0=53/90; % 90°
G12=1851; % Shear modulus MPa
GIIc_L=5; % exact value need to check
t=0.5; %t ply thickness
v21=0.06; % exact value need to check
E1=22400; % MPa
E2=22400; % MPa
Lambda22_0=2.*(1/E2-(v21.^2/E1));
Lambda44_0=1/G12;

Sis_L= sqrt(8.*GIIc_L/(pi*t*Lambda44_0));
% S_L=Sc; % need check
% Sis_L= sqrt(2)*S_L;
eta_L=-(Sis_L*cos(alpha_0))/(Yc*((cos(alpha_0)).^2));
eta_T=-1./tan(2.*alpha_0);
Phi_C=atan((1-sqrt(1-4.*((Sis_L/Xc)+eta_L)*(Sis_L/Xc)))/(2.*(Sis_L/Xc+eta_L)));
phi=(abs(tau12)+(G12-Xc)*Phi_C)./(G12+sigma1-sigma2);
% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
g=1.12.^2.*Lambda22_0/Lambda44_0.*(Yt/Sc).^2;
tau12_m=-cos(phi).*sin(phi).*sigma1+cos(phi).*sin(phi).*sigma2+cos(2.*phi).*tau12;
sigma2_m=((sin(phi)).^2).*sigma1+((cos(phi)).^2).*sigma2-sin(2.*phi).*tau12;

taueff_mT=-sigma2_m.*cos(alpha_0).*(sin(alpha_0)-eta_T.*cos(alpha_0));
taueff_mL=cos(alpha_0).*(abs(tau12_m)+eta_L.*sigma2_m.*cos(alpha_0));

LaRC03_Matrix2_1 = (taueff_mT/Sc).^2+(taueff_mL/Sis_L).^2;

isosurface_threshold = 1;
%
h5 = patch(isosurface(sigma1, sigma2, tau12, LaRC03_Matrix2_1, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,LaRC03_Matrix2_1,h5)
isocolors(sigma1, sigma2, tau12,tau12,h5)
% h2.FaceColor = 'interp';
h5.FaceColor = 'r';
h5.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h5, 'FaceAlpha', 0.5);
grid on;
view(3);
xlabel('\sigma_{11}','Rotation',20);
ylabel('\sigma_{22}','Rotation',-25);
zlabel('\tau_{12}');
%% matrix2_2
% Range of stress components
sigma1_range = linspace(-Yc, 600, 100);
sigma2_range = linspace(-600, 0, 100);
tau12_range = linspace(-200, 200, 100);

% Create a meshgrid for stress components
[sigma1, sigma2, tau12] = meshgrid(sigma1_range, sigma2_range, tau12_range);

alpha_0=53/90; % 90°
G12=1851; % Shear modulus MPa
GIc_L=5; % exact value need to check
GIIc_L=5; % exact value need to check
t=0.5; %t ply thickness
v21=0.06; % exact value need to check
E1=22.4;
E2=22.4;
Lambda22_0=2.*(1/E2-(v21.^2/E1));
Lambda44_0=1/G12;

Yis_T= sqrt(8.*GIc_L/(pi*t*Lambda22_0));
Sis_L= sqrt(8.*GIIc_L/(pi*t*Lambda44_0));
% S_L=Sc; % need check
% Sis_L= sqrt(2)*S_L;
eta_L=-(Sis_L*cos(alpha_0))/(Yc*((cos(alpha_0)).^2));
eta_T=-1./tan(2.*alpha_0);
Phi_C=atan((1-sqrt(1-4.*((Sis_L/Xc)+eta_L)*(Sis_L/Xc)))/(2.*(Sis_L/Xc+eta_L)));
phi=(abs(tau12)+(G12-Xc)*Phi_C)./(G12+sigma1-sigma2);
% equastion from Paper: http://dx.doi.org/10.1016/j.engfailanal.2013.07.001
g=1.12.^2.*Lambda22_0/Lambda44_0.*(Yt/Sc).^2;
tau12_m=-cos(phi).*sin(phi).*sigma1+cos(phi).*sin(phi).*sigma2+cos(2.*phi).*tau12;
sigma2_m=((sin(phi)).^2).*sigma1+((cos(phi)).^2).*sigma2-sin(2.*phi).*tau12;

taueff_T=-sigma2.*cos(alpha_0).*(sin(alpha_0)-eta_T.*cos(alpha_0));
taueff_L=cos(alpha_0).*(abs(tau12)+eta_L.*sigma2.*cos(alpha_0));

LaRC03_Matrix2_2 = (taueff_T/Sc).^2+(taueff_L/Sis_L).^2;

isosurface_threshold = 1;
%
h6 = patch(isosurface(sigma1, sigma2, tau12, LaRC03_Matrix2_2, isosurface_threshold));
hold on;
isonormals(sigma1, sigma2, tau12,LaRC03_Matrix2_2,h6)
isocolors(sigma1, sigma2, tau12,tau12,h6)
% h2.FaceColor = 'interp';
h6.FaceColor = 'r';
h6.EdgeColor = 'none';
% colorbar('Limits',[-100 100])
set(h6, 'FaceAlpha', 0.5);
grid on;
view(3);
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
% Experimental results from the 90° tension
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
% plot3(SH_sigma1, SH_sigma2, SH_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
% plot3(T0_sigma1, T0_sigma2, T0_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
% plot3(T90_sigma1, T90_sigma2, T90_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
% plot3(C0_sigma1, C0_sigma2, C0_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
% plot3(C90_sigma1, C90_sigma2, C90_tau12, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
set(gca,'xcolor','k','ycolor','k','zcolor','k','linewidth',1.5,'FontSize',14,'GridColor',...
    [0 0 1])
% legend('Hill48 Yield Surface', 'von Mises Yield Surface', 'Experimental Result');
% l = legend({'Mon Mises','Hill 48','Experimental'}...
%     ,'FontSize',12,'Position',[0.54804762405015 0.766269845740191 0.258928566426039 0.161904757434413]);
% hold off;
legend off
% legend boxoff
% grid off
view([-42.2171352195544 38.1524574658655]);
print(gcf,'-dtiffn','LaRC03_combine_1')
view([0 90]);
print(gcf,'-dtiffn','LaRC03_combine_2')
view([0 1]);
colorbar off
print(gcf,'-dtiffn','LaRC03_combine_3')
view([-90 1]);
colorbar off
print(gcf,'-dtiffn','LaRC03_combine_4')