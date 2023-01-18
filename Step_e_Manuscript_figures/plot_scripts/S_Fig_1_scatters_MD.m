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
    
    CD_lims  = 1;
    MD_lims = 1.5;
    m_size = 20;
    m_size2 = 5;
    
    CD = process_map(sCDA_raw{sample},sROI_ver2{sample},CD_lims,1);
    MD = process_map(sMR{sample}.MD,sROI_ver2{sample},MD_lims,0);
    
    MD_pred1 = predict_map(CD,MD,sROI_ver2{sample},sample,91); %linear
    MD_pred1 = process_map(MD_pred1,sROI_ver2{sample},MD_lims,0);
    R2_1 = calc_R2(MD,MD_pred1,sROI_ver2{sample});
    
    MD_pred2 = predict_map(CD,MD,sROI_ver2{sample},sample,11); %quadratic
    MD_pred2 = process_map(MD_pred2,sROI_ver2{sample},MD_lims,0);
    R2_2 = calc_R2(MD,MD_pred2,sROI_ver2{sample});
    
    MD_pred3 = predict_map(CD,MD,sROI_ver2{sample},sample,93); %cubic
    MD_pred3 = process_map(MD_pred3,sROI_ver2{sample},MD_lims,0);
    R2_3 = calc_R2(MD,MD_pred3,sROI_ver2{sample});
    
    MD_pred4 = predict_map(CD,MD,sROI_ver2{sample},sample,99); %special: constrained quadratic
    MD_pred4 = process_map(MD_pred4,sROI_ver2{sample},MD_lims,0);
    R2_4 = calc_R2(MD,MD_pred4,sROI_ver2{sample});
    
    axes(ha(axs));
    dscatter(CD(sROI_ver2{sample} > 0),MD(sROI_ver2{sample} > 0),'msize',m_size,'SMOOTHING',30,'BINS',[200,200],'PLOTTYPE','scatter')
    hold on;
    h(1) = plot(CD(sROI_ver2{sample} > 0),MD_pred1(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    h(2) = plot(CD(sROI_ver2{sample} > 0),MD_pred2(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    h(3) = plot(CD(sROI_ver2{sample} > 0),MD_pred3(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    h(4) = plot(CD(sROI_ver2{sample} > 0),MD_pred4(sROI_ver2{sample} > 0),'.','Markersize',m_size2); pbaspect([1 1 1]);
    
    text(0.6,1.5,['R^2 = ', num2str(R2_1)]);
    text(0.6,1.3,['R^2 = ', num2str(R2_2)]);
    text(0.6,1.1,['R^2 = ', num2str(R2_3)]);
    text(0.6,0.9,['R^2 = ', num2str(R2_4)]);

    xlim([0 CD_lims]);
    ylim([0 MD_lims]);
    
    
    if id == 1
        xticks([0 CD_lims]); xticklabels({'0','1'});
        yticks([0 MD_lims]); yticklabels({'0','1.5'});
    end
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 1;
end

print(sprintf('Scatters_MD.png'),'-dpng','-r500')
