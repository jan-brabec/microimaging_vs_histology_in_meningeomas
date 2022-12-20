clear; clf;
load(fullfile('..','..','local_data','summary.mat'))
addpath(genpath('../M_functions'))

sample = 5;

disp(sample)

CD_lims  = 1;
dif_lims = 0.5;

if sample == 3
    MD_lims =  2;
elseif sample == 5
    MD_lims = 1;
end



CD = process_map(sCDA_raw{sample},sROI_ver2{sample},CD_lims,1);
MD = process_map(sMR{sample}.MD,sROI_ver2{sample},MD_lims,0);

MD_pred = predict_map(CD,MD,sROI_ver2{sample},sample,11);
MD_pred = process_map(MD_pred,sROI_ver2{sample},MD_lims,0);


[dif,c_map] = make_dif_map(MD,MD_pred,sROI_ver2{sample},dif_lims);

ax1 = subplot(1,2,1);
% scatter(CD(sROI{sample} > 0),MD(sROI{sample} > 0),30,'.');

dscatter(CD(sROI_ver2{sample} > 0),MD(sROI_ver2{sample} > 0),'msize',30,'SMOOTHING',30,'BINS',[200,200],'PLOTTYPE','scatter')
xlim([0 CD_lims])
ylim([0 MD_lims])
hold on
plot(CD(sROI_ver2{sample} > 0),MD_pred(sROI_ver2{sample} > 0),'.','Markersize',10);
ylim([0 MD_lims])
xlim([0 1])

if sample == 3
    yticks([0 0.5 1 1.5 2])
elseif sample == 5
    yticks([0 0.25 0.5 0.75 1])
end
xticks([0 0.25 0.5 0.75 1])


set(ax1,'PlotBoxAspectRatio',[1 MD_lims 1]);
set(ax1,'DataAspectRatio', [1 MD_lims 1]);
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
imagesc(dif);
colormap(ax,c_map);
colorbar;
caxis([-dif_lims dif_lims])
axis image off

set(gca,'FontSize',20)
set(gca,'box','off')
ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;
set(ax,'tickdir','out');

set(gcf,'color','w');
drawnow;

R2 = calc_R2(MD,MD_pred,sROI_ver2{sample})
