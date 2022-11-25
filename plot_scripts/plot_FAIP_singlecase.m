clear; clf;

load(fullfile('..','..','local_data','summary.mat'))
addpath(genpath('../M_functions'))


sample = 9; %max R2 %9 5 6 15
% sample = 7; %min R2
sample = 5;

disp(sample)

lims_scatter  = 1;
if sample == 5
    lims_scatter  = 1;
elseif sample == 7
    lims_scatter = 0.5;
end

dif_lims = 0.5;
[lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);

IA   = process_map(sHd{sample}.dIA,sROI_ver2{sample},lims_dir_IA,1);
FA2D = process_map(sMR{sample}.FA2D,sROI_ver2{sample},lims_dir_FA2D,0);

FA2D_pred = predict_map(IA,FA2D,sROI_ver2{sample},sample,11);
FA2D_pred = process_map(FA2D_pred,sROI_ver2{sample},lims_dir_FA2D,0);

[dif_IA,c_map_IA] = make_dif_map(FA2D,FA2D_pred,sROI_ver2{sample},dif_lims);

ax1 = subplot(1,2,1);
% scatter(IA(sROI_ver2{sample} > 0),FA2D(sROI_ver2{sample} > 0),2);
addpath('dscatter')
dscatter(IA(sROI_ver2{sample} > 0),FA2D(sROI_ver2{sample} > 0),'msize',30,'SMOOTHING',30,'BINS',[200,200],'PLOTTYPE','scatter')

hold on
plot(IA(sROI_ver2{sample} > 0),FA2D_pred(sROI_ver2{sample} > 0),'.','Linewidth',2);

if sample == 5
    yticks([0 0.5 1])
    xticks([0 0.5 1])
elseif sample == 7
    yticks([0 0.25 0.5])
    xticks([0 0.25 0.5])
end

xlim([0 lims_scatter])
ylim([0 lims_scatter])

set(ax1,'PlotBoxAspectRatio',[1 1 1]);
set(ax1,'DataAspectRatio', [1 1 1]);
set(ax1,'PlotBoxAspectRatioMode','manual');
set(ax1,'DataAspectRatioMode','manual');

set(ax1,'XLimMode','manual');
set(ax1,'YLimMode','manual');
set(ax1,'ZLimMode','manual');

set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;
set(ax,'tickdir','out');

ax = subplot(1,2,2);
imagesc(dif_IA);
colormap(ax,c_map_IA);
caxis([-dif_lims dif_lims])
axis image off
colorbar;

set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;
set(ax,'tickdir','out');

set(gcf,'color','w');
drawnow;


R2 = calc_R2(FA2D,FA2D_pred,sROI_ver2{sample} > 0)

print(sprintf('FA2D_example.png'),'-dpng','-r500')