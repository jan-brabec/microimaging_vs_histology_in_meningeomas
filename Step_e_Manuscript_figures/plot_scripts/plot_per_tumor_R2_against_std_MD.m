clear; clf; clc; load(fullfile('..','..','local_data','summary.mat'))
addpath('../M_functions')


for sample = 1:16
    
    
    disp(sample)
    
    MD_lims = 1.5;
    CD_lims = 1.0;
    
    CD = process_map(sCDA_raw{sample},sROI_ver2{sample},CD_lims,1);    
    MD_meas = process_map(sMR{sample}.MD,sROI_ver2{sample},MD_lims,0);
    
    MD_meas_per_sample(sample) = std(MD_meas(sROI_ver2{sample} > 0));
    
    for i = 1:1000
        [MD_pred_CD,test_set_measured,test_set_predicted,test_set_usedforpred] =...
            predict_map(CD,MD_meas,sROI_ver2{sample},sample,1101);
         MD_pred_CD      = process_map(MD_pred_CD,sROI_ver2{sample},MD_lims,0);

        R2_MD_CD_test_bootstrap(sample,i) = calc_R2(test_set_measured,test_set_predicted);
    end
    
end

MD_col = [79 140 191]./255;
FA2D_col = [192 80 77]./255;

hold on
scatter(MD_meas_per_sample,median(R2_MD_CD_test_bootstrap,2),400,'.')
hold on
R2_MD_R2 = calc_R2(MD_meas_per_sample,median(R2_MD_CD_test_bootstrap,2))

coeffs = polyfit(MD_meas_per_sample, median(R2_MD_CD_test_bootstrap,2), 1);
fittedX = linspace(0, 1, 200);
fittedY = polyval(coeffs, fittedX);
plot(fittedX, fittedY, 'r-', 'LineWidth', 3);

set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 2;
ax.YAxis.LineWidth = 2;
set(ax,'tickdir','out');

legend off

% xlabel('median FA2D per sample')
% ylabel('R2')
xlim([0 1])
ylim([0 1])
xticks([0 0.25 0.5 0.75 1])
yticks([0 0.25 0.5 0.75 1])

print(sprintf('R2_vs_medianMDchart.png'),'-dpng','-r300')
