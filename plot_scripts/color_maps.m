clf
colorbar


%1
% colormap(flipud(gray));

%2
colormap(gray);

%3
% addpath('dscatter')
% colormap(ff_cmap_viridis)

axis off

c = colorbar;

c.Position(1) = 0.5;
c.LineWidth = 1.5;
c.Ticks = [0.1,0.8];
c.TickLabels = {'0','0.6'};
% c.TickLabels = {'min','max'};
c.TickLength = 0;
c.FontSize = 40;
c.FontName = 'Arial';
c.Color = 'black';

set(gcf,'color','white');
set(gca,'color','white');
fig = gcf;
fig.InvertHardcopy = 'off';

print(sprintf('bar.png'),'-dpng','-r300')



% MD_lim   = 1;
% FA2D_lim = 0.7;
% FA_lim   = 0.7;
% IA_lim   = 0.7;
% CD_lim   = [0.4 1];