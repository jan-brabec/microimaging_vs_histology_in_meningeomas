clear; clf; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')


for sample = 1:16
    
    disp(sample)
    
    %FAIP part
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
    FAIP_meas = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);
    %Switch to sMR{sample}.FA instead of sMR{sample}.FAIP to see results
    %for FA instead.
    
    FAIP_meas_per_sample(sample) = std(FAIP_meas(sROI{sample} > 0));
    
    for i = 1:1000
        [~,FAIP_test_set_measured,FAIP_test_set_predicted,~] = ...
            predict_map(SA,FAIP_meas,sROI{sample},1101);
        
        MSE_FAIP = calc_MSE(FAIP_test_set_measured,FAIP_test_set_predicted);
        MSE_FAIP_mean = calc_MSE(FAIP_test_set_measured,mean(FAIP_test_set_measured));
        
        R2OS_FAIP(sample,i) = calc_R2_from_MSE(MSE_FAIP,MSE_FAIP_mean);
    end
    
end

MD_col = [79 140 191]./255;
FA2D_col = [192 80 77]./255;

hold on
scatter(FAIP_meas_per_sample,median(R2OS_FAIP,2),400,'.')
hold on
R2_FAIP_R2 = calc_R2_from_corr_coeff(FAIP_meas_per_sample,median(R2OS_FAIP,2))

coeffs = polyfit(FAIP_meas_per_sample, median(R2OS_FAIP,2), 1);
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

xlim([0 0.4])
ylim([0 0.4])
xticks([0 0.2 0.4])
yticks([0 0.2 0.4])

print(sprintf('R2_vs_stdFAIPchart.png'),'-dpng','-r300')
