clear; clf; load(fullfile('..','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    CD_lims  = 1;
    dif_lims = 0.5;
    
    if sample == 3 
        MD_lims = 1.5;
    else
        MD_lims = 1;
    end
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);
    

    
    CD = process_map(sCD{sample},sROI{sample},CD_lims,1);
    IA   = process_map(sHd{sample}.dIA,sROI{sample},lims_dir_IA,1);
        
    MD   = process_map(sMR{sample}.MD,  sROI{sample},MD_lims,0);
    FA2D = process_map(sMR{sample}.FA2D,sROI{sample},lims_dir_FA2D,0);    

    MD_per_tu(sample)   = mean(MD(sROI{sample} > 0));
    CD_per_tu(sample)   = mean(CD(sROI{sample} > 0));
    
    FA2D_per_tu(sample) = mean(FA2D(sROI{sample} > 0));    
    IA_per_tu(sample)   = mean(IA(sROI{sample} > 0));
end


subplot(1,2,1)
hold on
scatter(CD_per_tu,MD_per_tu,400,'.')
hold on
R2_MD = calc_R2(CD_per_tu,MD_per_tu)
% title(sprintf('R^2 = %1.1f',R2_MD));

coeffs = polyfit(CD_per_tu, MD_per_tu, 1);
fittedX = linspace(0, 1, 200);
fittedY = polyval(coeffs, fittedX);
plot(fittedX, fittedY, 'r-', 'LineWidth', 3);

set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 2;
ax.YAxis.LineWidth = 2;
set(ax,'tickdir','out');

% xlabel('CD')
% ylabel('MD')
xlim([0 1])
ylim([0 1])
xticks([0 0.5 1])
yticks([0 0.5 1])

subplot(1,2,2)
scatter(IA_per_tu,FA2D_per_tu,400,'.')
hold on
R2_FA2D = calc_R2(IA_per_tu,FA2D_per_tu)
% title(sprintf('R^2 = %1.1f',R2_FA2D));

coeffs = polyfit(IA_per_tu, FA2D_per_tu, 1);
fittedX = linspace(0, 1, 200);
fittedY = polyval(coeffs, fittedX);
plot(fittedX, fittedY, 'r-', 'LineWidth', 3);

% xlabel('IA')
% ylabel('FA_{2D}')
set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 2;
ax.YAxis.LineWidth = 2;
set(ax,'tickdir','out');

xlim([0 0.6])
ylim([0 0.6])
xticks([0 0.3 0.6])
yticks([0 0.3 0.6])

print(sprintf('MD_FA2D_per_tumor.png'),'-dpng','-r300')