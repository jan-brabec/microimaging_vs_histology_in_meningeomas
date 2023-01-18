clear; clf; clc; load(fullfile('..','..','local_data','summary.mat'))
addpath(genpath('../M_functions'))

ha = tight_subplot(4,4,[.04,.02],[.05,.05],[.01,.01]);

%decrease in MD % 1 2 3 7 13
%no correlation % 12 8 15
%no correlation but systematic problems % 9 10 5 6
%coregistration errors % 4 13 14 16

%      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
% idx = [1 2 3 7 13 12 8 15 9 10 5 6 4 14 11 16];

idx = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
axs = 1;

for id = 1:numel(idx)
    
    sample = idx(id);
    disp(sample)
    
    addpath('../zAnalyze_FA2D')
    
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);
    
    m_size = 20;
    m_size2 = 5;
    
    IA   = process_map(sHd{sample}.dIA,sROI_ver2{sample},lims_dir_IA,1);
    FA2D = process_map(sMR{sample}.FA2D,sROI_ver2{sample},lims_dir_FA2D,0);
    
    FA2D_pred1 = predict_map(IA,FA2D,sROI_ver2{sample},sample,91);  %linear 
    FA2D_pred1 = process_map(FA2D_pred1,sROI_ver2{sample},lims_dir_FA2D,0);
    R2_1 = calc_R2(FA2D,FA2D_pred1,sROI_ver2{sample});
    
    FA2D_pred2 = predict_map(IA,FA2D,sROI_ver2{sample},sample,11); %quadratic 
    FA2D_pred2 = process_map(FA2D_pred2,sROI_ver2{sample},lims_dir_FA2D,0);
    R2_2 = calc_R2(FA2D,FA2D_pred2,sROI_ver2{sample});
    
    FA2D_pred3 = predict_map(IA,FA2D,sROI_ver2{sample},sample,93); %cubic
    FA2D_pred3 = process_map(FA2D_pred3,sROI_ver2{sample},lims_dir_FA2D,0);
    R2_3 = calc_R2(FA2D,FA2D_pred3,sROI_ver2{sample});
    
    FA2D_pred4 = predict_map(IA,FA2D,sROI_ver2{sample},sample,98); %special: linear with no (0,0)
    FA2D_pred4 = process_map(FA2D_pred4,sROI_ver2{sample},lims_dir_FA2D,0);
    R2_4 = calc_R2(FA2D,FA2D_pred4,sROI_ver2{sample});
    
    axes(ha(axs));
    dscatter(IA(sROI_ver2{sample} > 0),FA2D(sROI_ver2{sample} > 0),'msize',m_size,'SMOOTHING',30,'BINS',[200,200],'PLOTTYPE','scatter')
    hold on;
    h(1) = plot(IA(sROI_ver2{sample} > 0),FA2D_pred1(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    h(2) = plot(IA(sROI_ver2{sample} > 0),FA2D_pred2(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    h(3) = plot(IA(sROI_ver2{sample} > 0),FA2D_pred3(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    h(4) = plot(IA(sROI_ver2{sample} > 0),FA2D_pred4(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    
    text(0.6,1,['R^2 = ', num2str(R2_1)]);
    text(0.6,0.87,['R^2 = ', num2str(R2_2)]);
    text(0.6,0.74,['R^2 = ', num2str(R2_3)]);
    text(0.6,0.61,['R^2 = ', num2str(R2_4)]);
    
    xlim([0 lims_scatter])
    ylim([0 lims_scatter])
    
    if id == 1
        xticks([0 lims_scatter]); xticklabels({'0','1'});
        yticks([0 lims_scatter]); yticklabels({'0','1'});
    end
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 1;
end

print(sprintf('Scatters_IA.png'),'-dpng','-r500')
