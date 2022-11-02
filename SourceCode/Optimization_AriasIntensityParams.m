%% Modulating function parameters optimization (Arias Intensity)
%Routine to perform PSO optimization to compute the modulating function
%parameters and the Arias Intensity factors for each accelerogram. The
%respective data are saved to 'PEER_MODopt_Arias.mat'.
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

%Initialize optimization options
PSOoptions.StallGenLimit = 20; 
PSOoptions.PopulationSize = 100;
PSOoptions.InitialPopulationSize = 100;
PSOoptions.Generations = 500;
PSOoptions.TolFun = 1e-6;
PSOoptions.SocialAttraction = 1.45;
PSOoptions.CognitiveAttraction = 1.45;
PSOoptions.Display = 'off';
PSOoptions.Vectorized = 'on';
PSOoptions.PlotFcns = {};%{@psoplotbestf,@psoplotswarm,@psoplotscorediversity}; 
PSOoptions.ConstrBoundary = 'soft';

NLoptions = optimset('Algorithm','interior-point',...
    'MaxFunEvals',20000,'MaxIter',20000,'Display','off',...
    'TolFun',1e-4,'TolX',1e-8,'TolCon',1e-6);


nvar = 2;   
theta = zeros(length(EQ),4);
th0 = [1.01 0.5];           % a2 and a3 initial values
lb = [1+eps eps];           % a2 and a3 lower bound
ub = [inf 1];               % a2 and a3 upper bound
[RSS, extflg, Ia, D5_45, D5_95, IAs, D545s, D595s] = deal(zeros(length(EQ),1)); 
plotfigs = 'n';

for j = 1:length(EQ)
    disp(j)
    Y = EQ{j};
    Y = Y(~isnan(Y));
    N = length(Y);
    Ts = DT(j);
    % PSO optimization
    thPSO = pso(@(theta0) Qoptimization(theta0,Y,Ts),nvar,[],[],[],[],lb,ub,[],PSOoptions);
    % Nonlinear optimization
    [thNL,~,extflg(j)] = fmincon(@(theta0) Qoptimization(theta0,Y,Ts),thPSO,[],[],[],[],lb,ub,[],NLoptions);
    % Arias intensity calculation
    [Ia(j),t5,t45,t95,Iat,D5_45(j),D5_95(j)] = EQarias(Y,Ts);
    % Normalized Arias intensity as a function of time
    Iaindx = Iat./Ia(j);
    [RSS(j),theta(j,:),IAs(j),t5s,t45s,t95s,IATs,D545s(j),D595s(j)] = Qoptimization(thNL,Y,Ts);
    T = 0:Ts:Ts*(N-1);
    T0 = theta(j,4);
    if strcmp(plotfigs,'y');
        figure(j)
        plot(T/(Ts*(N-1)),Iaindx),hold on
        plot([t5 t5 t5],[0 0.5 1],'-or',[t45 t45 t45],[0 0.5 1],'-^r',[t95 t95 t95],[0 0.5 1],'-sr')
        plot(T0+T/(Ts*(N-1)),IATs,'-c')
        plot(T0+[t5s t5s t5s],[0 0.5 1],'-om',T0+[t45s t45s t45s],[0 0.5 1],'-^m')
        plot(T0+[t95s t95s t95s],[0 0.5 1],'-sm')
        hold off
        xlabel('Sample')
        ylabel('Normalized Arias intensity')
    end
end
save('PEERexamples/PEER_MODopt_Arias.mat','theta*','RSS*','ext*','IAs','Ia','D5*')