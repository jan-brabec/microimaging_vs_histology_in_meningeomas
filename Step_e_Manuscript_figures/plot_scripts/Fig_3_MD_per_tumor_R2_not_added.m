clear; clf; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')


for sample = 1:16
    
    
    disp(sample)
    

    CD = process_map(sCD{sample},sROI{sample},1,1);
    MD_meas = process_map(sMR{sample}.MD,sROI{sample},1.5,0);    
 
    std_MD_meas_per_sample(sample) = std(MD_meas(sROI{sample}));
    
    mean_MD_meas_per_sample(sample) = mean(MD_meas(sROI{sample}));
    std_CD_per_sample(sample) = std(CD(sROI{sample}));
    mean_CD_per_sample(sample) = mean(CD(sROI{sample}));
  
    for i = 1:1000
        [~,CD_test_set_measured,CD_test_set_predicted,~] =...
            predict_map(CD,MD_meas,sROI{sample},1101);
        
        MSE_CD = calc_MSE(CD_test_set_measured,CD_test_set_predicted);
        MSE_CD_mean = calc_MSE(CD_test_set_measured,mean(CD_test_set_measured));
        
        R2OS_CD(sample,i) = calc_R2_from_MSE(MSE_CD,MSE_CD_mean);
    end
    
end

hold on
scatter(std_MD_meas_per_sample,median(R2OS_CD,2),400,'.')
hold on
R2_MD_R2 = calc_R2_from_corr_coeff(std_MD_meas_per_sample,median(R2OS_CD,2))

coeffs = polyfit(std_MD_meas_per_sample, median(R2OS_CD,2), 1);
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

xlim([0 1])
ylim([0 1])
xticks([0 0.25 0.5 0.75 1])
yticks([0 0.25 0.5 0.75 1])

disp('Number of samples with STD of MD below 0.2')
sum(std_MD_meas_per_sample./mean_MD_meas_per_sample<0.2)

disp('Number of samples with STD of CD below 0.2')
sum(std_CD_per_sample./mean_MD_meas_per_sample<0.2)


print(sprintf('R2_vs_medianMDchart.png'),'-dpng','-r300')
