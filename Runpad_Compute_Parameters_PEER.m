%% Main Script 
% Runpad for the parametrization of the accelerograms of the PEER database
% Each section performs a dedicated computation and stores the respective
% results. The framework is exemplified using the PEER database.
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

addpath(genpath("SourceCode"));

%% Preprocessing
% Load individual earthquake accelerograms and save them in one file
clear,clc
Read_and_Save


%% PEER Database criteria computation
% Visualization of peak ground acceleration & Root-mean-square acceleration
clear,clc
local_dir = [pwd,'\'];
%Load file contatining accelerograms (from Read_and_Save)
load([local_dir,'PEERexamples\PEER_ALL'],'EQ','N','DT');

for j = 1:length(EQ)
    disp(j)
    Y = EQ{j};
    Y = Y(~isnan(Y));
    N = length(Y);
    Ts = DT(j);
    % a) Peak ground acceleration
    PGA(j) = max(abs(Y));
    % b) Root-mean-square acceleration
    RMSA(j) = sqrt((1/N)*sum(Y.^2));
end
figure(j)
subplot(211),plot(sort(PGA))
subplot(212),plot(sort(RMSA))


%% Modulating function parameters optimization (Arias Intensity)

clear,clc
local_dir = [pwd,'\'];
%Load file contatining accelerograms (from Read_and_Save)
load([local_dir,'PEERexamples\PEER_ALL'],'EQ','N','DT');

Optimization_AriasIntensityParams

%% Frequency-domain parameters optimization (omega - interpolation)

clear,clc
local_dir = [pwd,'\'];
%Load file contatining accelerograms (from Read_and_Save)
load([local_dir,'PEERexamples\PEER_ALL'],'EQ','N','DT');

Optimization_FreqDomainParams_Omega

%% Frequency-domain parameters optimization (zeta - interpolation)

local_dir = [pwd,'\'];
%Load file contatining accelerograms (from Read_and_Save)
load([local_dir,'PEERexamples\PEER_ALL'],'EQ','N','DT');

%Load frequency-domain parameters
IRFth = load('PEERexamples/PEER_IRFinterp.mat','theta*');
load('PEERexamples/PEER_IRFinterp.mat','tmid');
%Load modulating function parameters
qth = load('PEERexamples/PEER_MODopt_Arias.mat','theta*');

Optimization_FreqDomainParams_Zeta

