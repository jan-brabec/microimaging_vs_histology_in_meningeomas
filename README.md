# Article: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy
* Code and data to the manuscript: **Brabec, J., Friedjungova, M., Vašata, D., Englund, E., Bengzon, J., Knutsson, L., Szczepankiewicz, F., van Westen, D., Sundgren, P.C. and Nilsson, M., 2023. Meningioma microstructure assessed by diffusion MRI: an investigation of the source of mean diffusivity and fractional anisotropy by quantitative histology. NeuroImage: Clinical, p.103365.-[[Article in HTML]](https://www.sciencedirect.com/science/article/pii/S2213158223000542)-[[Article in PDF]](https://www.sciencedirect.com/science/article/pii/S2213158223000542/pdfft?isDTMRedir=true)-**

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

# Opening a QuPath project
QuPath is an open software for Bioimage analysis that was used to generate cell density maps. However, it can also be used to view the histology slides - both raw or coregistered ones. Here are some instruction if you want to open any of the histology slides:

* Download and install latest QuPath from: https://qupath.github.io (version that was used to run cell detection algorhitm was version 0.23)
* Run QuPath and click on File -> Open.
* Open project file of the specific sample (e.g. for sample 1 /data/1/cell_density/QuPath/project.qpproj).
* You will be asked to locate the HE.jpg file corresponding to this project. This is because when the project was created it was linked with an absolute but not relative path to this image. The image is located in the same folder as the project file is, e.g.(e.g. for sample 1 /data/1/cell_density/QuPath/HE.jpg). This will load both the image as well as the cell nuclei detected.
* Loading of the images may take time and also requires a large amount of RAM because the images are large.
* You may want to see the scale bar (located in the left bottom corner by default) in real units instead of pixels (i.e. micrometers instead of pixels). If so, please modify in the Image tab (this is located between Project and Annotation tabs) fields: Pixel width and Pixel height. These can be set to 0.5 micrometers and 0.5 micrometers because at this resolution the histology slides were digitalized. Afterward the scale bar will show micrometers instead of pixels.
* If you want to view also the coregistered VEGF-stained histology section (which are stored as .mat -v7.3 files in the database) in QuPath you will need to save these images in a QuPath readable format. QuPath can visualize .jpg files and you can modify the script [save_qupath](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas/blob/main/Step_a_Analyze_CD/save_qupath.m) to save the VEGF images as .jpg files. QuPath may be able to read also .tif files. We have not added this optionality into QuPath because we have analysed cell density from H&E-stained images only. Please note that we could not provide VEGF-stained histology section for the tumor samples: 1, 3 and 11 because the files were corrupted during the digitalization.


# Others

* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
