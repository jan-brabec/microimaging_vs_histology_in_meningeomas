clear; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    %CNN part
    MSE_CNN      = calc_MSE(sFAIP_CNN{sample}.I_measured(sFAIP_CNN{sample}.I_test_ind==1),sFAIP_CNN{sample}.I_pred(sFAIP_CNN{sample}.I_test_ind==1));
    MSE_CNN_mean = calc_MSE(sFAIP_CNN{sample}.I_measured(sFAIP_CNN{sample}.I_test_ind==1),mean(sFAIP_CNN{sample}.I_measured(sFAIP_CNN{sample}.I_test_ind==1)));
    
    R2OS_CNN(sample) = calc_R2_from_MSE(MSE_CNN,MSE_CNN_mean);
    
    %FAIP part
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
    FAIP_meas = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);
    %Switch to sMR{sample}.FA instead of sMR{sample}.FAIP to see results
    %for FA instead.
    
    for i = 1:1000
        [~,FAIP_test_set_measured,FAIP_test_set_predicted,~] = ...
            predict_map(SA,FAIP_meas,sROI{sample},1101);
        
        MSE_FAIP = calc_MSE(FAIP_test_set_measured,FAIP_test_set_predicted);
        MSE_FAIP_mean = calc_MSE(FAIP_test_set_measured,mean(FAIP_test_set_measured));
        
        R2OS_FAIP(sample,i) = calc_R2_from_MSE(MSE_FAIP,MSE_FAIP_mean);
        RR2OS_FAIP_CNN(sample,i) = calc_R2_from_MSE(MSE_FAIP,MSE_CNN);
    end
    
end

R2OS_CNN(R2OS_CNN<0) = 0;
R2OS_CNN(isnan(R2OS_CNN)) = 0;


if (1) %What we had there previously
    figure(123)
    clf
    
    bar(1:16,[median(R2OS_FAIP,2)';R2OS_CNN], 'BarWidth', 1.2); hold on;
    e = errorbar((1:16)-0.15,median(R2OS_FAIP,2)',iqr(R2OS_FAIP,2)/2);
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
    
    qSA = quantile(median(R2OS_FAIP,2),3);
    fprintf('R2 SA intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2OS_FAIP,2)),qSA(1),qSA(3))
    
    qCNN = quantile(R2OS_CNN,3);
    fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2OS_CNN),qCNN(1),qCNN(3))
    
    print(sprintf('R2_FAIP_FA_chart.png'),'-dpng','-r500')
end

if (1) %R squared out-of-sample plot
    figure(124)
    clf
    
    bar(1:16,median(RR2OS_FAIP_CNN,2), 'BarWidth', 0.8); hold on
    e = errorbar((1:16),median(RR2OS_FAIP_CNN,2)',iqr(RR2OS_FAIP_CNN,2)/2);
    
    e.LineStyle = 'none';
    e.LineWidth = 1.5;
    e.Color = 'black';
    
    ylim([-1 1])
    set(gca, 'XTick', [1:16])
    set(gca, 'YTick', [-1, -0.8, -0.6, -0.4, -0.2, 0,0.2,0.4,0.6,0.8,1.0])
    set(gca,'FontSize',20)
    set(gca,'box','off')
    ax = gca;
    ax.XAxis.LineWidth = 2;
    ax.YAxis.LineWidth = 2;
    set(ax,'tickdir','out');
    ax.XGrid = 'off';
    ax.YGrid = 'on';
    legend('R^2_{OOS} FA_{IP}','FontSize',10,'Location','southeast')
    
    qRR2OS = quantile(median(RR2OS_FAIP_CNN,2),3);
    fprintf('RR2OS : %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(RR2OS_FAIP_CNN,2)),qRR2OS(1),qRR2OS(3))
    
    sum(median(RR2OS_FAIP_CNN,2) <= 0)
    
    print(sprintf('RR2OS_FAIP_chart.png'),'-dpng','-r500')
    
end

