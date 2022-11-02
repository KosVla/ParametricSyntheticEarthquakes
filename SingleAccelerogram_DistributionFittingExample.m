%% Main Script - Distribution fitting example
% Runpad that creates the proper distribution for each parameter extracted
% from the PEED database (see Runpad_Compute_Parameters_PEER) and then
% exemplifies the use of the distributions for an accelerogram not included
% in the PEER set (ElCentro earthquake)
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

clear,clc
addpath(genpath("SourceCode"));
local_dir = [pwd,'\'];
cd(local_dir)

write_dir = [local_dir,'Figures\'];
% pictype = '-depsc2'; resolution = '-r300';

%% Load workspaces & Preprocessing

% Load frequency-domain parameters of database (zeta - interpolation)
load('PEER_ALL/PEER_Nleq10000_ZETAinterp.mat','RSSref','zeta_ref');
minRSS = min(RSSref,[],2);
RSSindx_IRF = find(minRSS > 0 & minRSS < 1.93);
minRSS = minRSS(minRSS > 0 & minRSS < 1.93);

% Load modulating function parameters of database
load('PEER_ALL/PEER_ALL_MODopt_Arias.mat','RSS','Ia','D545s','D595s');
RSSindx_MOD = find(RSS < 1.93);
EQindx = intersect(RSSindx_IRF,RSSindx_MOD);

% Load frequency-domain parameters of database (omega - interpolation)
load('PEER_ALL/PEER_ALL_IRFinterp.mat');

wmid = theta(EQindx,1); wdot = theta(EQindx,2);
zeta = zeta_ref(EQindx); Ia = sqrt(Ia(EQindx))';   
D545s = D545s(EQindx)'; D595s = D595s(EQindx)';

%% Distribution fitting for each parameter
%
% For every parameter, estimate the maximum likelihood estimates and
% construct a distribution with the respective values. Visualization of the
% distributions is also provided.

%% ------------------------------------------------------------------------
% Parameter: omega_mid
%--------------------------------------------------------------------------

xindx = 0:0.001:20;
[phat] = mle(wmid,'distribution','loglogistic');
% %Older MATLAB releases:
% PD_wmid = ProbDistUnivParam('loglogistic',phat);
% %MATLAB 2018 and onward:
PD_wmid = makedist('loglogistic','mu',phat(1),'sigma',phat(2));

figure(1)
set(gca,'Fontname','TimesNewRoman')
subplot(9,3,[1 4 7]),set(gca,'Fontname','TimesNewRoman','Fontsize',8)
histfit(wmid,15,'loglogistic')
h = get(gca,'Children');
set(h(2),'FaceColor',[.6 .6 0.8])
xlabel('$\omega_{\mbox{mid}}$ (Hz)','Fontname','TimesNewRoman','Interpreter','Latex','Fontsize',11)
ylabel('Frequency','Fontname','TimesNewRoman','Fontsize',11)
text(10,370,'Log-Logistic(1.64,0.238)','Fontname','TimesNewRoman','Fontsize',11,'HorizontalAlignment','Center')
xlim([0 20])

%% ------------------------------------------------------------------------
% Parameter: omega'
%--------------------------------------------------------------------------

xindx = -0.4:0.001:0.4;
[phat] = mle(wdot,'distribution','logistic');
% %Older MATLAB releases:
% PD_wdot = ProbDistUnivParam('logistic',phat);
% %MATLAB 2018 and onward:
PD_wdot = makedist('logistic','mu',phat(1),'sigma',phat(2));

subplot(9,3,[2 5 8]),set(gca,'Fontname','TimesNewRoman','Fontsize',8)
histfit(wdot,15,'logistic')
h = get(gca,'Children');
set(h(2),'FaceColor',[.6 .6 0.8])
xlabel('$\omega''$ (Hz/s)','Fontname','TimesNewRoman','Interpreter','Latex','Fontsize',11)
ylabel('Frequency','Fontname','TimesNewRoman','Fontsize',11)
text(0,840,'Logistic(-0.0516,0.0336)','Fontname','TimesNewRoman','Fontsize',11,'HorizontalAlignment','Center') 
axis([-0.5 0.5 0 900])

%% ------------------------------------------------------------------------
% Parameter: zeta
%--------------------------------------------------------------------------

xindx = 0:0.01:1;
[phat] = mle(zeta,'distribution','beta');
% %Older MATLAB releases:
% PD_zeta = ProbDistUnivParam('beta',phat);
% %MATLAB 2018 and onward:
PD_zeta = makedist('beta','a',phat(1),'b',phat(2));

subplot(9,3,[3 6 9]),set(gca,'Fontname','TimesNewRoman','Fontsize',8)
histfit(zeta,15,'beta')
h = get(gca,'Children');
set(h(2),'FaceColor',[.6 .6 0.8])
xlabel('$\zeta_f$','Fontname','TimesNewRoman','Interpreter','Latex','Fontsize',11)
ylabel('Frequency','Fontname','TimesNewRoman','Fontsize',11)
text(0.5,235,'Beta(1.38,3.70)','Fontname','TimesNewRoman','Fontsize',11,'HorizontalAlignment','Center') 
xlim([0 1])

%% ------------------------------------------------------------------------
% Parameter: Ia
%--------------------------------------------------------------------------
xindx = [0:1e-4:0.05]';
[phat] = mle(Ia,'distribution','exponential');
% %Older MATLAB releases:
% PD_Ia = ProbDistUnivParam('exponential',phat);
% %MATLAB 2018 and onward:
PD_Ia = makedist('exponential','mu',phat(1));

subplot(9,3,[13 16 19]),set(gca,'Fontname','TimesNewRoman','Fontsize',8)
histfit(Ia,15,'exponential')
h = get(gca,'Children');
set(h(2),'FaceColor',[.6 .6 0.8])
xlabel('$\sqrt{I_a}$','Interpreter','Latex','Fontsize',11)
ylabel('Frequency','Fontname','TimesNewRoman','Fontsize',11)
text(0.025,750,'Exp(0.00551)','Fontname','TimesNewRoman','Fontsize',11,'HorizontalAlignment','Center') 
xlim([0 0.05])

%% ------------------------------------------------------------------------
% Parameter: D5-45
%--------------------------------------------------------------------------

Nbins = 1000;
xindx = linspace(0,0.5,Nbins)';
options = statset('Display','final','Maxiter',1000);
[phat] = mle(D545s,'distribution','beta');
% %Older MATLAB releases:
% PD_D545s = ProbDistUnivParam('beta',phat);
% %MATLAB 2018 and onward:
PD_D545s = makedist('beta','a',phat(1),'b',phat(2));


subplot(9,3,[14 17 20]),set(gca,'Fontname','TimesNewRoman','Fontsize',8)
histfit(D545s,15,'beta')
h = get(gca,'Children');
set(h(2),'FaceColor',[.6 .6 0.8])
xlabel('$t_{\mbox{mid}}$','Interpreter','Latex','Fontsize',11)
ylabel('Frequency','Fontname','TimesNewRoman','Fontsize',11)
text(0.25,150,'Beta(3.79,24.23)','Fontname','TimesNewRoman','Fontsize',11,'HorizontalAlignment','Center') 
axis([min(xindx) max(xindx) 0 160])

%% ------------------------------------------------------------------------
% Parameter: D5-95
%--------------------------------------------------------------------------

xindx = linspace(0,1,Nbins)';
options = statset('Display','final','Maxiter',1000);
phat = mle(D595s,'distribution','beta');
% %Older MATLAB releases:
% PD_D595s = ProbDistUnivParam('beta',phat);
% %MATLAB 2018 and onward:
PD_D595s = makedist('beta','a',phat(1),'b',phat(2));


subplot(9,3,[15 18 21]),set(gca,'Fontname','TimesNewRoman','Fontsize',8)
histfit(D595s,15,'beta')
h = get(gca,'Children');
set(h(2),'FaceColor',[.6 .6 0.8])
xlabel('$D_{5-95}$','Interpreter','Latex','Fontsize',11)
ylabel('Frequency','Fontname','TimesNewRoman','Fontsize',11)
text(0.5,160,'Beta(4.15,5.15)','Fontname','TimesNewRoman','Fontsize',11,'HorizontalAlignment','Center') 
axis([min(xindx) max(xindx) 0 170])

clear theta *RSS* extflg zeta_ref EQindx

%% ------------------------------------------------------------------------
% Visualize fit
% -------------------------------------------------------------------------

figure(3),
subplot(221),set(gca,'Fontname','TimesNewRoman')
hold on
plot(D595s,D545s,'+')
coef = D545s/D595s;
plot([0 1],[0 coef],'-r','Linewidth',1.5)
plot([0 1],[0 min(D545s./D595s)],'--r')
plot([0 1],[0 max(D545s./D595s)],'--r')
xlabel('$D_{5-95}$','Interpreter','Latex')
ylabel('$t_{\mbox{mid}}$','Interpreter','Latex')
legend({'Samples','Least Square fit','Min and Max ratio'},'Fontname','TimesNewRoman',...
    'Location','NorthWest')
grid on 
box on

% save('PEER_ALL/PDFs.mat','PD*')


%% ========================================================================
% El Centro earthquake example
%==========================================================================

load('ElCentro.mat');
EQ = ElCentro(:,2);  N = length(EQ); time = 1:N;
% save('validEQ.txt','EQ','-ascii')

%Load fitted distributions
load('PEER_ALL/PDFs.mat')

% Set sampling period
Ts = 0.025;

% Evaluate characteristics of El Centro accelerogram
[Ia,t5,t45,t95,Iat,D5_45,D5_95] = EQarias(EQ/9.81,Ts);
options.points = 9;
omegas = spectralINTERP(EQ/9.81,Ts,options);
Qtrans = [omegas(1) omegas(2) sqrt(Ia) D5_95 200e9];
Q(:,1) = cdf(PD_wmid,Qtrans(:,1));
Q(:,2) = cdf(PD_wdot,Qtrans(:,2));
Q(:,3) = cdf(PD_Ia,Qtrans(:,3));
Q(:,4) = cdf(PD_D595s,Qtrans(:,4));
Q(:,5) = 0.5;
% Q = -1+2*Q;