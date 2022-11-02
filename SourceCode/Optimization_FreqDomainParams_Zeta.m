%% Frequency-domain parameters optimization (zeta - interpolation)
%Routine to perform optimization and spectral interpolation to compute the
% frequency domain parameters of the accelerogram. The
% respective data are saved to 'PEER_ZETAinterp.mat'.
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

options.iter = 10;

Zinit_indx = 0.1:0.1:0.9;
Zindx = zeros(length(EQ),19);
RSSref = zeros(length(EQ),19);

for j = 1:length(EQ)
    disp(j)
    Y = EQ{j};
    Y = Y(~isnan(Y));
    Ts = DT(j);
    p=0;
    if N(j)<10000
        RSS = zeros(length(Zinit_indx),1);
        for i = Zinit_indx
            p = p+1;
            zeta = i;
            TH = [IRFth.theta(j,:) zeta, qth.theta(j,1:3)];
            [RSS(p),PN,PNs] = bandwidthERRinterp(TH,Y,Ts,tmid(j),options);
            if p>2 && (RSS(p)>RSS(p-1)) && (RSS(p-1)>RSS(p-2))
                break
            end
        end
        RSS(RSS == 0) = NaN;
        [minRSS,J] = min(RSS);
        Zindx(j,:) = Zinit_indx(J)-0.09:0.01:Zinit_indx(J)+0.09;
        q = 0;
        for i = Zindx(j,:)
            q = q+1;
            zeta = i;
            TH = [IRFth.theta(j,:) zeta, qth.theta(j,1:3)];
            [RSSref(j,q),PN,PNs] = bandwidthERRinterp(TH,Y,Ts,tmid(j),options);
        end
        [minRSSref,K] = min(RSSref(j,:));
        zeta_ref(j) = Zindx(j,K);
    end
    save('PEERexamples/PEER_ZETAinterp.mat','RSSref','zeta_ref')
end