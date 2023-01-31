sample = 5;

load(fullfile('..','summary.mat'))

if (1)
    pos = tdfread(fullfile('..','..','..','data',num2str(sample),'cell_density','QuPath','measurements.tsv'));    
    load(fullfile('..','..','..','data',num2str(sample),'coreg_fine','ver1','HE.mat'),'HE');
    load(fullfile('..','..','..','data',num2str(sample),'coreg_fine','ver1','HE_mask.mat'),'dHE_mask','HE_mask');
    load(fullfile('..','..','..','data',num2str(sample),'structure_anisotropy','ver1','SA.mat'),'H')
end

MD_lim   = 1;
FAIP_lim = 0.7;
FA_lim   = 0.7;
SA_lim   = 0.7;
CD_lim   = [0 0.6];

MD   = process_map(sMR{sample}.MD,sROI{sample},MD_lim,0);
FAIP = process_map(sMR{sample}.FAIP,sROI{sample},FAIP_lim,0);
FA   = process_map(sMR{sample}.FA,sROI{sample},FA_lim,0);

SA_native = process_map(H.SA,HE_mask,SA_lim,0);
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
imagesc(FAIP)
axis image off
colormap gray
caxis([0 FAIP_lim])

subplot(3,2,4)
imagesc(HE)
axis image off

subplot(3,2,5)
imagesc(CD_native)
caxis([CD_lim(1) CD_lim(2)])
axis image off

subplot(3,2,6)
imagesc(SA_native)
caxis([0 SA_lim])
axis image off

print(sprintf('Overview_methods.png'),'-dpng','-r500')