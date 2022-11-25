clear; clf; clc; load(fullfile('..','..','local_data','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    dif_lims = 0.5;
    [lims_dir_FAIP, lims_dir_IA] = get_dir_lims(sample,0.6);
    
    IA   = process_map(sHd{sample}.dIA,sROI_ver2{sample},lims_dir_IA,1);
    FA2D_meas = process_map(sMR{sample}.FA2D,sROI_ver2{sample},lims_dir_FAIP,0);
    
    FAIP_pred_ML = process_map(sFA2D_ML{sample}.I_pred,sROI_ver2{sample},lims_dir_FAIP,0);
    
    for i = 1:1000
        [FA2D_pred,test_set_measured,test_set_predicted,test_set_usedforpred] = ...
            predict_map(IA,FA2D_meas,sROI_ver2{sample},sample,1101);
        
        R2_FAIP_IA_test_bootstrap(sample,i) = calc_R2(test_set_measured,test_set_predicted);
        g(sample,i) = sample;
    end
    
    R2_FAIP_ML_test(sample) = calc_R2(FA2D_meas(sFA2D_ML{sample}.test_ind == 1),FAIP_pred_ML(sFA2D_ML{sample}.test_ind == 1));
    
end         

MD_col = [79 140 191]./255;
FA2D_col = [192 80 77]./255;

clf
R2_FAIP_ML_test(isnan(R2_FAIP_ML_test)) = 0;
bar(1:16,[median(R2_FAIP_IA_test_bootstrap,2)';R2_FAIP_ML_test], 'BarWidth', 1.2)

hold on
e = errorbar((1:16)-0.15,median(R2_FAIP_IA_test_bootstrap,2)',iqr(R2_FAIP_IA_test_bootstrap,2)/2);
e.LineStyle = 'none';
e.LineWidth = 1.5;
e.Color = 'black';

ylim([0 1])
set(gca, 'XTick', [1:16])
set(gca, 'YTick', [0,0.2,0.4,0.6,0.8,1.0])

set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 2;
ax.YAxis.LineWidth = 2;
set(ax,'tickdir','out');
ax.XGrid = 'off';
ax.YGrid = 'on';
legend('SA','CNN','FontSize',10,'Location','northeast')




qIA = quantile(median(R2_FAIP_IA_test_bootstrap,2),3);
fprintf('R2 SA intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2_FAIP_IA_test_bootstrap,2)),qIA(1),qIA(3))
qML = quantile(R2_FAIP_ML_test,3);
fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2_FAIP_ML_test),qML(1),qML(3))


r = median(R2_FAIP_IA_test_bootstrap,2)' ./ R2_FAIP_ML_test * 100;
qr = quantile(r,3);
fprintf('R2 SA/CNN ratio intra-tumor: %0.2f %% (%0.2f %% - %0.2f) %% (median (25th quartile - 75th quartile)), min %0.2f %%, max %0.2f %% \n',median(r), qr(1), qr(3), min(r), max(r))






print(sprintf('R2_FAIP_chart.png'),'-dpng','-r500')
