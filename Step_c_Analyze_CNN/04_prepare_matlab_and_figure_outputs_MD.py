# Libraries
import h5py

import scipy.misc 
from scipy import io

import numpy as np
import pandas as pd

from sklearn.metrics import r2_score

import matplotlib.pyplot as plt


#-----------------------------------------------------------
# model name based on script name
model_name = 'MD_efficientnet'

#-----------------------------------------------------------
# prepare functions
def scatter_plot(y_true, y_predicted, test_R2):
  # plt.show()
  # Scatter plot
  plt.figure(figsize=(7,7))
  lims = [0.25, 1.9]
  plt.scatter(y_true, y_predicted)
  plt.title(f"Prediction of MD on a test set")
  plt.plot([0, 2], [0, 2], 'r')
  plt.xlim(lims[0],lims[1])
  plt.ylim(lims[0],lims[1])
  plt.xlabel("Measured values")
  plt.ylabel("Predicted values")
  plt.text(0.8, 1.6, f"$R^2 = {test_R2:.2f}$")

def matrix_plot(MAT_y, title = ""):
  # plt.show()
  # Plot the matrix transposed
  plt.figure(figsize=(5,5))
  plt.imshow(MAT_y.T, cmap = "gray")
  plt.title(title)
  plt.colorbar(fraction=0.046, pad=0.04)
  plt.axis("off")
  plt.clim(0,2)

def matrix_diff_plot(MAT_y, title = ""):
  # plt.show()
  # Plot the matrix transposed
  plt.figure(figsize=(5,5))
  plt.imshow(MAT_y.T, cmap = "bwr")
  plt.title(title)
  plt.colorbar(fraction=0.046, pad=0.04)
  plt.axis("off")
  plt.clim(-1, 1)


#-----------------------------------------------------------
# Iterate samples
samples = list(range(1,17))
# samples = [5,2,1]

for sample in samples:
  print("----------------------------------------")
  print(f"Sample {sample}")
  checkpoint_name = f"{model_name}_s{sample}"
  y_predicted = np.load(f"./output_predictions/{checkpoint_name}_y_all_on_self.npy")
  test_indices = np.load(f"./output_predictions/{checkpoint_name}_test_indices.npy")
  print(y_predicted.shape, test_indices.shape)
  y_true = np.load(f"../../data/{sample}/CNN/ver1/resized_ydataMD.npy")
  fMR = h5py.File(f"../../data/{sample}/coreg_fine/ver1/MR.mat", 'r')
  MR_roi = np.array(fMR['MR']['ROI'])
  k = 5
  NEWROI = MR_roi
  tempROI = np.zeros(MR_roi.shape, np.int32)
  tempROI[k:,:] = MR_roi[:-k,:]
  NEWROI = np.multiply(NEWROI,tempROI)
  tempROI = np.zeros(MR_roi.shape, np.int32)
  tempROI[:-k,:] = MR_roi[k:,:]
  NEWROI = np.multiply(NEWROI,tempROI)
  tempROI = np.zeros(MR_roi.shape, np.int32)
  tempROI[:,k:] = MR_roi[:,:-k]
  NEWROI = np.multiply(NEWROI,tempROI)
  tempROI = np.zeros(MR_roi.shape, np.int32)
  tempROI[:,:-k] = MR_roi[:,k:]
  NEWROI = np.multiply(NEWROI,tempROI)
  indd = NEWROI[y_true[:,1].astype(int), y_true[:,2].astype(int)].astype(int)
  y_true = y_true[indd > 0, :]
  
  print(y_true.shape)
  #########
  print(" - Test R2 & figure & MATlab")
  test_R2 = r2_score(y_true[test_indices[:,0],0], y_predicted[test_indices[:,0],0])
  # print(f"Test R2 from calculations: {result[str(sample)]['test_r2']}, new: {test_R2}")
  print(f"Test R2: {test_R2}")
  scatter_plot(y_true[test_indices[:,0],0], y_predicted[test_indices[:,0],0], test_R2)
  plt.savefig(f"./output_mat/{checkpoint_name}_scatter.png", bbox_inches='tight', transparent = True)
  plt.close()
  io.savemat(f"./output_mat/MAT_{checkpoint_name}_p3.mat", dict(measured = y_true[test_indices[:,0],0], predicted = y_predicted[test_indices[:,0],0]))
  #########
  full_R2 = r2_score(y_true[:,0], y_predicted[:,0])
  print(f"Full R2: {full_R2}")
  #########
  print(" - Preparing matrices")
  # Load MR matrix
  fMR = h5py.File(f"../../data/{sample}/coreg_fine/ver1/MR.mat", 'r')
  MR_MD = np.array(fMR['MR']['MD'])
  MR_roi = np.array(fMR['MR']['ROI'])
  print(MR_MD.shape)
  #------------------------------------------
  # prepare matrices
  test_positions_map = np.zeros(MR_MD.shape, np.int32)
  test_locations = y_true[test_indices[:,0]][:,1:3]
  for i in range(test_locations.shape[0]):
    test_positions_map[int(test_locations[i,0]),int(test_locations[i,1])] = 1
  # Save the test positions
  io.savemat(f"./output_mat/MAT_{checkpoint_name}_p4.mat", {'test_positions_map': test_positions_map})
  #------------------------------------------
  # prepare matrices
  MAT_y_true = 2*np.ones(MR_MD.shape, np.float32)
  MAT_y_pred = 2*np.ones(MR_MD.shape, np.float32)
  # create a matrix with true values
  for j in range(y_true.shape[0]):
    MAT_y_true[int(y_true[j, 1]), int(y_true[j,2])] = y_true[j, 0]
  # Plot the matrix
  matrix_plot(MAT_y_true, 'MD measured')
  plt.savefig(f"./output_mat/output_images_and_matlabs/{checkpoint_name}_MAT_true.png", bbox_inches='tight', transparent = True)
  plt.close()
  # create a matrix with predicted values
  for j in range(y_true.shape[0]):
    MAT_y_pred[int(y_true[j, 1]), int(y_true[j,2])] = y_predicted[j, 0]
  # Plot the matrix
  matrix_plot(MAT_y_pred, 'MD predicted')
  plt.savefig(f"./output_mat/{checkpoint_name}_MAT_pred.png", bbox_inches='tight', transparent = True)
  plt.close()
  # create a matrix with differences
  MAT_y_diff = MAT_y_true - MAT_y_pred
  # Plot the matrix
  matrix_diff_plot(MAT_y_diff, 'Error map (measured - predicted)')
  plt.savefig(f"./output_mat/{checkpoint_name}_MAT_diff.png", bbox_inches='tight', transparent = True)
  plt.close()
  # Saving the matrices
  io.savemat(f"./output_mat/MAT_{checkpoint_name}_p1.mat", {'MAT_y_true': MAT_y_true})
  io.savemat(f"./output_mat/MAT_{checkpoint_name}_p2.mat", {'MAT_y_pred': MAT_y_pred})
  #########
  print("\n\n")
