%% Frequency-domain parameters optimization (omega - interpolation)
%Routine to perform optimization and spectral interpolation to compute the
% frequency domain parameters of the accelerogram. The
% respective data are saved to 'PEER_IRFinterp.mat'.
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

options.points = 9;
for j = 1:length(EQ)
    disp(j)
    Y = EQ{j};
    Y = Y(~isnan(Y));
    N(j) = length(Y);
    Ts = DT(j);
    [theta(j,:),tmid(j)] = spectralINTERP(Y,Ts,options);
    theta(j,:) = theta(j,:);
end
save('PEERexamples/PEER_IRFinterp.mat','theta*','tmid')