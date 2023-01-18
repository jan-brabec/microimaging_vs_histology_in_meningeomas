sample = 5;

load(fullfile('..','summary.mat'))

addpath('../zAnalyze_MD')
addpath('../zCoreg_fine')

if (1)
    pos = tdfread(fullfile('..','..','..','data',num2str(sample),'cell_density','QuPath','measurements.tsv'));    
    load(fullfile(fullfile('..','..','..','data',num2str(sample),'coreg_fine','ver1'),'HE.mat'),'HE','dHE_mask','HE_mask');
    load(fullfile(fullfile('..','..','..','data',num2str(sample),'anisotropy','ver1'),'IA.mat'),'H')
end

MD_lim   = 1;
FA2D_lim = 0.7;
FA_lim   = 0.7;
IA_lim   = 0.7;
CD_lim   = [0 0.6];

MD   = process_map(sMR{sample}.MD,sROI{sample},MD_lim,0);
FA2D = process_map(sMR{sample}.FA2D,sROI{sample},FA2D_lim,0);
FA   = process_map(sMR{sample}.FA,sROI{sample},FA_lim,0);

IA_native = process_map(H.IA,HE_mask,IA_lim,0);
CD_native = make_celldensity_map(pos,size(HE),floor(size(HE)./50));
CD_mask   = downsample_histo_ROI_to_MR_res(HE_mask,CD_native);
CD_native = process_map(CD_native,CD_mask,CD_lim(2),0);

clf;
subplot(3,2,1)
imagesc(MD)
axis image off
colormap gray
caxis([0 MD_lim])

subplot(3,2,2)
imagesc(FA)
axis image off
colormap gray
caxis([0 FA_lim])

subplot(3,2,3)
imagesc(FA2D)
axis image off
colormap gray
caxis([0 FA2D_lim])

subplot(3,2,4)
imagesc(HE)
axis image off

subplot(3,2,5)
imagesc(CD_native)
caxis([CD_lim(1) CD_lim(2)])
axis image off

subplot(3,2,6)
imagesc(IA_native)
caxis([0 IA_lim])
axis image off