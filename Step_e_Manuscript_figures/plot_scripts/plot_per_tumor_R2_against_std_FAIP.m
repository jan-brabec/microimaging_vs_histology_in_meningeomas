clear; clf; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')


for sample = 1:16
    
    disp(sample)
    
    dif_lims = 0.5;
    [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);
    
    IA   = process_map(sHd{sample}.dIA,sROI{sample},lims_dir_IA,1);
    FA2D_meas = process_map(sMR{sample}.FA2D,sROI{sample},lims_dir_FA2D,0);
    
    FA2D_meas_per_sample(sample) = std(FA2D_meas(sROI{sample} > 0));

    
    for i = 1:1000
        [FA2D_pred,test_set_measured,test_set_predicted,test_set_usedforpred] = ...
            predict_map(IA,FA2D_meas,sROI{sample},sample,1101);
        FA2D_pred = process_map(FA2D_pred,sROI{sample},lims_dir_FA2D,0);
        
        R2_FA2D_IA_test_bootstrap(sample,i) = calc_R2(test_set_measured,test_set_predicted);
    end
    
end

MD_col = [79 140 191]./255;
FA2D_col = [192 80 77]./255;

hold on
scatter(FA2D_meas_per_sample,median(R2_FA2D_IA_test_bootstrap,2),400,'.')
hold on
R2_FA2D_R2 = calc_R2(FA2D_meas_per_sample,median(R2_FA2D_IA_test_bootstrap,2))

coeffs = polyfit(FA2D_meas_per_sample, median(R2_FA2D_IA_test_bootstrap,2), 1);
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
xlim([0 0.4])
ylim([0 0.4])
xticks([0 0.2 0.4])
yticks([0 0.2 0.4])

print(sprintf('R2_vs_medianFAIPchart.png'),'-dpng','-r300')
