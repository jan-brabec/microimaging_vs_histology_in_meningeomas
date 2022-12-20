# Manuscript: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy
* Code and data to the manuscript: **Brabec, J., Friedjungova, M., Vasata, D., Englund, E., Bengzon, J., Knutsson, Szczepankiewicz, F., Sundgren, P.C. and Nilsson, M., 2022. Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy. Unpublished.**

* Contact: *jbrabec [at] jh [dot] edu*

* **NOTE: There will be also submission of the coregistered data themselves to data in brief without the analysis performed in this article. The data are not submitted yet to data in brief nor uploaded on an external repository so it is not yet possible to download the data and recreate them.**


# How to recreate processed data and plot figures from scratch
1. Download the data from AIDA repository and paste them into folder "data" at the same level as this directory. This directory contains both raw and processed data as well as an example analysis, see below "Data structure" for detailed explanation of the content. If you want to recreate the coregistered files, follow instructions in the [repository related to our manuscript: Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors](https://github.com/jan-brabec/microimaging_histology_DIB).
2. Install [QuPath](https://qupath.github.io), and for each sample create an empty new project in the directory data/sample_number/cell_density/QuPath. This has to be done manually.
4. Run script save_qupath in the folder Step_a_Analyze_CD. This will save QuPath readable version of the histology in the folder data/sample_number/cell_density/QuPath.
5. Run QuPath cell detection algrithm in the application and export all information about the detection in the same directory as QuPath.
6. Run script Anisotropy in the folder Step_b_Analyze_IA.
6. Run script Create_summary in the folder Step_d_Create_summary. This will merge the results from all samples into a single file "summary.mat" in the data folder
7. Plot manuscript figures by scripts in the folder Step_e_Manuscript_figures/plot_scripts.

# Others

* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
