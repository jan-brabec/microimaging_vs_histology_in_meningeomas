clear; clf;
addpath('../M_functions')

ha = tight_subplot(2,4,[.01,.01],[.01,.01],[.01,.01]);
data_path = fullfile('..','..','..','data');

s = 500;

axes(ha(1)); %Fibroblastic WHO I
sample = 9;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')

x = 13670;
y = 20420;

imagesc(HE(x:x+s,y:y+s,:))
axis image off



axes(ha(2)); %microcystic-angiomatous WHO I
sample = 3;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')

x = 14510;
y = 10560;

x = 14590;
y = 10720;

imagesc(HE(x:x+s,y:y+s,:))
axis image off



axes(ha(3)); %transitional WHO I
sample = 5;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')

x = 6866;
y = 4413;
imagesc(HE(x:x+s,y:y+s,:))
axis image off



axes(ha(4)); %meningothelial WHO I
sample = 8;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')

x = 11200;
y = 9094;

imagesc(HE(x:x+s,y:y+s,:))
axis image off



axes(ha(5)); %meningothelial WHO II
sample = 4;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')

x = 8973;
y = 11690;

imagesc(HE(x:x+s,y:y+s,:))
axis image off



axes(ha(6)); %Clear-cell WHO II
sample = 10;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')

% x = 22860;
% y = 15150;

y = 10480;
x = 17080;

imagesc(HE(x:x+s,y:y+s,:))
axis image off



axes(ha(7)); %Chordoid WHO II
sample = 2;
i_pth_HE  = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(i_pth_HE,'HE.mat'),'HE')
% 
% x = 3352;
% y = 11300;

% x = 4139;
% y = 6674;

% x = 1204;
% y = 3493;

x = 3430;
y = 1204;

imagesc(HE(x:x+s,y:y+s,:))
axis image off


axes(ha(8));
axis image off


print(sprintf('Histo_zoomins.png'),'-dpng','-r500')