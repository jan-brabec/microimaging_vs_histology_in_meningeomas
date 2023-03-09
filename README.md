# Article: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy
* Code and data to the manuscript: **Brabec, J., Friedjungova, M., Vašata, D., Englund, E., Bengzon, J., Knutsson, L., Szczepankiewicz, F., van Westen, D., Sundgren, P.C. and Nilsson, M., 2023. Meningioma microstructure assessed by diffusion MRI: an investigation of the source of mean diffusivity and fractional anisotropy by quantitative histology. NeuroImage: Clinical, p.103365.-[[Article in HTML]](https://analyticalsciencejournals.onlinelibrary.wiley.com/doi/abs/10.1002/nbm.4187)-[[Article in PDF]](https://www.sciencedirect.com/science/article/pii/S2213158223000542/pdfft?isDTMRedir=true)-**

* If you find this repository useful, cite the above mentioned article.

* Contact: *jbrabec2 [at] jh [dot] edu*

* **NOTE: There will be also submission of the coregistered data themselves to data in brief without the analysis performed in this article. The data are not submitted yet to data in brief nor uploaded on an external repository so it is not yet possible to download the data and recreate them.**


# How to recreate processed data and plot figures from scratch
1. Download the data from AIDA repository and paste them into folder "data" at the same level as this directory. This directory contains both raw and processed data as well as an example analysis, see below "Data structure" for detailed explanation of the content. If you want to recreate the coregistered files, follow instructions in the [repository related to our manuscript: Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors](https://github.com/jan-brabec/microimaging_histology_DIB).
2. Install [QuPath](https://qupath.github.io), and for each sample create an empty new project in the directory data/sample_number/cell_density/QuPath. This has to be done manually.
4. Run script save_qupath in the folder Step_a_Analyze_CD. This will save QuPath readable version of the histology in the folder data/sample_number/cell_density/QuPath.
5. Run QuPath cell detection algrithm.
6. Run script Calculate_structure_anisotropy in the folder Step_b_Analyze_SA.
7. Run scripts in the folder Step_c_Analyze_CNN. More information in the same folder.
8. Run script Create_summary in the folder Step_d_Create_summary. This will merge the results from all samples into a single file "summary.mat" in the data folder.
7. Plot manuscript figures by scripts in the folder Step_e_Manuscript_figures/plot_scripts.

# Others

* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
