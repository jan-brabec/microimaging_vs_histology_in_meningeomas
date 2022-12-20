clear; clf; clc; load(fullfile('..','..','local_data','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    MD_lims = 1.5;
    CD_lims = 1.0;
    
    CD = process_map(sCDA_raw{sample},sROI_ver2{sample},CD_lims,1);    
    MD_meas = process_map(sMR{sample}.MD,sROI_ver2{sample},MD_lims,0);
    
    MD_pred_ML = process_map(sMD_ML{sample}.I_MD_pred,sROI_ver2{sample},MD_lims,0);
    
    for i = 1:1000
        [MD_pred_CD,test_set_measured,test_set_predicted,test_set_usedforpred] =...
            predict_map(CD,MD_meas,sROI_ver2{sample},sample,1101);
         MD_pred_CD      = process_map(MD_pred_CD,sROI_ver2{sample},MD_lims,0);

        R2_MD_CD_test_bootstrap(sample,i) = calc_R2(test_set_measured,test_set_predicted);
        g(sample,i) = sample;
    end
    
    R2_MD_ML_test(sample) = calc_R2(MD_meas(sMD_ML{sample}.test_ind == 1),MD_pred_ML(sMD_ML{sample}.test_ind == 1));
end

MD_col = [79 140 191]./255;
FA2D_col = [192 80 77]./255;


clf
R2_MD_ML_test(isnan(R2_MD_ML_test)) = 0;
bar(1:16,[median(R2_MD_CD_test_bootstrap,2)';R2_MD_ML_test], 'BarWidth', 1.2)
hold on
e = errorbar((1:16)-0.15,median(R2_MD_CD_test_bootstrap,2)',iqr(R2_MD_CD_test_bootstrap,2)/2);

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
legend('CD','CNN','FontSize',10,'Location','northeast')

print(sprintf('R2_MD_chart.png'),'-dpng','-r500')


qCD = quantile(median(R2_MD_CD_test_bootstrap,2),3);
fprintf('R2 CD intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2_MD_CD_test_bootstrap,2)),qCD(1),qCD(3))
qML = quantile(R2_MD_ML_test,3);
fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2_MD_ML_test),qML(1),qML(3))


r = median(R2_MD_CD_test_bootstrap,2)' ./ R2_MD_ML_test * 100;
qr = quantile(r,3);
fprintf('R2 CD/CNN ratio intra-tumor: %0.2f %% (%0.2f %% - %0.2f) %% (median (25th quartile - 75th quartile)), min %0.2f %%, max %0.2f %% \n',median(r), qr(1), qr(3), min(r), max(r))



