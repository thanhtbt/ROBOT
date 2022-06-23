%% DEMO: Adaptive TT for streaming 4-order tensors
clear;clc; close all

run_path;

n_exp        = 5;
tt_dim       = [10 15 20 1000];
tt_rank      = [5 5 5];
outlier_den  = 0.2;
outlier_fac  = 0;
fac_noise    = 1e-3;
time_varying = 1e-3;
epsilon      = time_varying*ones(1,tt_dim(end));
epsilon(600) = 1; %Aim to create a significant change

SAMPLING     = [0.1 0.5 0.9];


PER_ATT  = zeros(length(SAMPLING),tt_dim(end));

for ll = 1 : length(SAMPLING)
    
    sampling_ll = SAMPLING(ll);
    fprintf('Sampling %f \n',sampling_ll);
    
    for ii = 1 : n_exp
        fprintf(' run %d/%d \n',ii,n_exp);
        %% Generate Data
        [Xtrue,tt_core] = tt_generate_tensor(tt_dim,tt_rank,epsilon);
        
        OPTS_PER.Xtrue         = Xtrue;
        OPTS_PER.forget_factor = 0.5;
        PER1                   = zeros(1,tt_dim(end));
        N = fac_noise*randn(tt_dim);
        
        % Outliers
       
        O   = zeros(tt_dim(1:end));
        NN  = prod(tt_dim(1:end));
        p   = randperm(NN);
        L   = round(outlier_den * NN);
        O(p(1:L))   = outlier_fac * rand(L,1);
                            
        % Missing
        Omega   = rand(tt_dim);
        Omega   = 1.*(Omega <= sampling_ll);
        
        X_full  = Xtrue +  O  +  N;

        X_miss  = Omega .* X_full;
        
        % Algorithm
        
        [per,~,~] = RATT(X_miss,Omega,tt_rank,OPTS_PER);
        
        PER1 = PER1 + per;
    end
    PER_ATT(ll,:) = PER1 / n_exp;
end

%% Plot

makerSize = 20;
numbMarkers = 500;
LineWidth = 2;

color   = get(groot,'DefaultAxesColorOrder');
red_o   = [1,0,0];
blue_o  = [0, 0, 1];
mag_o   = [1 0 1];
gree_o  = [0, 0.5, 0];
black_o = [0.25, 0.25, 0.25];

blue_n  = color(1,:);
oran_n  = color(2,:);
yell_n  = color(3,:);
viol_n  = color(4,:);
gree_n  = color(5,:);
lblu_n  = color(6,:);
brow_n  = color(7,:);
lbrow_n = [0.5350    0.580    0.2840];

% %% SEP
T = tt_dim(end);
fig = figure;
hold on;
k = 2;


d1 = semilogy(1:k:T,PER_ATT(1,1:k:end),...
    'linestyle','-','color',red_o,'LineWidth',LineWidth);
d11 = plot(1:100:T,PER_ATT(1,1:100:end),...
    'marker','p','markersize',makerSize,...
    'linestyle','none','color',red_o,'LineWidth',LineWidth);
d12 = semilogy(1:1,PER_ATT(1,1:1),...
    'marker','p','markersize',makerSize,...
    'linestyle','-','color',red_o,'LineWidth',LineWidth);


d2 = semilogy(1:k:T,PER_ATT(2,1:k:end),...
    'linestyle','-','color',blue_o,'LineWidth',LineWidth);
hold on;
d21 = plot(1:100:T,PER_ATT(2,1:100:end),...
    'marker','^','markersize',makerSize,...
    'linestyle','none','color',blue_o,'LineWidth',LineWidth);
d22 = semilogy(1:1,PER_ATT(2,1:1),...
    'marker','^','markersize',makerSize,...
    'linestyle','-','color',blue_o,'LineWidth',LineWidth);

d3 = semilogy(1:k:T,PER_ATT(3,1:k:end),...
    'linestyle','-','color','k','LineWidth',LineWidth);
hold on;
d31 = plot(1:100:T,PER_ATT(3,1:100:end),...
    'marker','h','markersize',makerSize,...
    'linestyle','none','color','k','LineWidth',LineWidth);
d32 = semilogy(1:1,PER_ATT(3,1:1),...
    'marker','h','markersize',makerSize,...
    'linestyle','-','color','k','LineWidth',LineWidth);


% d4 = semilogy(1:k:T,PER_ATT(4,1:k:end),...
%     'linestyle','-','color','k','LineWidth',LineWidth);
% hold on;
% d41 = plot(1:100:T,PER_ATT(4,1:100:end),...
%     'marker','d','markersize',makerSize,...
%     'linestyle','none','color','k','LineWidth',LineWidth);
% d42 = semilogy(1:1,PER_ATT(4,1:1),...
%     'marker','d','markersize',makerSize,...
%     'linestyle','-','color','k','LineWidth',LineWidth);
% 
% 


lgd = legend([d12,d22,d32],'$\omega_{miss} = 90\%$','$\omega_{miss} = 50\%$','$\omega_{miss} = 10\%$');
lgd.FontSize = 24;
set(lgd, 'Interpreter', 'latex', 'Color', [0.95, 0.95, 0.95]);

xlabel('Time Index','interpreter','latex','FontSize',13,'FontName','Times New Roman');
ylabel('RE$(\mathcal{X}_{tr},\mathcal{X}_{es})$','interpreter','latex','FontSize',13,'FontName','Times New Roman');

set(fig, 'units', 'inches', 'position', [0.5 0.5 7.5 6.5]);
h=gca;
set(h,'FontSize',16,'XGrid','on','YGrid','on','GridLineStyle',':','MinorGridLineStyle',':','FontName','Times New Roman');
set(h,'FontSize', 28);
% axis([0 T 1*1e-4 1e1]);
grid on;
set(h, 'YScale', 'log','box','on')


