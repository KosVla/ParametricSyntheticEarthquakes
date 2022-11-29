%% Main Script 
% Example runpad for the forward process of the parametrization framework.
% The runpad assembles synthetic ground motions given the necessary
% parametric inputs for the filtering and modulation frequency.
%
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

addpath(genpath("SourceCode"));
%% Define input parameter
clc;clear;

% Filtering parameters
theta(1) = 39.7;    % omega_0 or omega_mid
theta(2) = 4.68;    % omega_n or omega_dot
theta(3) = 0.3;     % zeta_f

% Modulation function parameters
theta(4) = 0.0004;  % T0
theta(5) = 12.2;    % T1
theta(6) = 12.2;    % T2
theta(7) = 0.413;   % alpha
theta(8) = 0.552;   % beta
theta(9) = 0.0744;  % sigma_max

Ts = 0.02;          %Timestep
N = 2000;           %Number of points 
T = Ts*(0:N-1);
SimulatedAccelerograms = 100;      %Number of simulated samples

%Initialization to store properties of accelerograms (Peak Ground Acceleration etc.)
[PGAs,RMSAs] = deal(zeros(SimulatedAccelerograms,1));
[NCEs,ERMSAs] = deal(zeros(N,SimulatedAccelerograms));
SyntheticEarthsRepo = zeros(SimulatedAccelerograms,N);

for i=1:SimulatedAccelerograms
    %Set random seed
    RandStream.setGlobalStream(RandStream('mt19937ar','seed',i));
    %Evaluate noise
    u = randn(N,1);
    %Forward process
    tic
    [z,x,q,h] = syntheticEQ(theta,u,Ts,0.25);
    SyntheticEarthsRepo(i,:)=z;
    toc
    %Store properies
    [PGAs(i),RMSAs(i),NCEs(:,i),ERMSAs(:,i), ZCs(:,i)] = EQcrit(z);
end

%Plot last sample
figure(1)
plot(T,z,'r')
xlabel('Time (s)')
ylabel('Acceleration (g)')

