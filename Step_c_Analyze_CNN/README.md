# Artificial neural network analysis

This folder contains Python scripts for training and evaluation of convolutional neural network model.

1. Run the script `01_resize_and_prepare_data.py` for preprocessing of the data. This will create data in the CNN folder in the data folder for each sample.
2. Run the script `02_MD_efficientnet.py` for training and testing the neural network model predicting MD on all samples. All results will be saved in the Step_c_Analyze_CNN folder.
3. Run the script `03_FA2D_efficientnet.py` for training and testing the neural network model predictiong FAID on all samples. All results will be saved in the Step_c_Analyze_CNN folder.
4. Run the script `04_prepare_matlab_and_figure_outputs_MD.py` for processing the outputs of MD prediction model to the MATLAB format and plot some figures. All the outputs will be saved in the Step_c_Analyze_CNN folder.
5. Run the script `05_prepare_matlab_and_figure_outputs_FAID.py` for processing the outputs of FAID prediction model to the MATLAB format and plot some figures. Al the outputs will be saved in the Step_c_Analyze_CNN folder.