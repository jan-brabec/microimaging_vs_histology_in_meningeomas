import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import h5py
from PIL import Image


all_items = list(range(1,17))
all_items = [1]

patchsize = 360

for i in all_items:
    dirname = f"../../data/{i}/coreg_fine/ver1/"
    print(f"Processing sample {i}")
    fHE = h5py.File(dirname + "HE.mat", 'r')
    fMR = h5py.File(dirname + "MR.mat", 'r')
    print(fHE.keys())
    # get HE data
    he_origin = np.array(fHE['HE'])
    # change axis because of RGB channel
    he = np.moveaxis(he_origin, 0, -1)
    he_mask = np.array(fHE['HE_mask'])
    dhe_mask = np.array(fHE['dHE_mask'])
    MR_MD = np.array(fMR['MR']['MD'])
    MR_FA2D = np.array(fMR['MR']['FA2D'])
    MR_roi = np.array(fMR['MR']['ROI'])
    print(he.shape, he_mask.shape, dhe_mask.shape, MR_MD.shape, MR_FA2D.shape, MR_roi.shape)
    if MR_MD.shape != MR_FA2D.shape:
      print("Different shapes of MR and FA2D! Skipping...")
      continue
    patchsx = int(he.shape[0]/MR_MD.shape[0])
    patchsy = int(he.shape[1]/MR_MD.shape[1])
    num_patches = np.size(MR_MD)
    x = np.empty([*MR_MD.shape, patchsize, patchsize, 3], np.ubyte)
    x_mask = np.empty(MR_MD.shape, np.bool)
    y_MD = np.empty([*MR_MD.shape, 3], np.float32)
    y_FA2D = np.empty([*MR_MD.shape, 3], np.float32)

    print(patchsx, patchsy, patchsx/patchsy)
    print("Transforming")
    for j in range(MR_MD.shape[0]):
        print(" - ", j)
        for k in range(MR_MD.shape[1]):
            x_start = int(patchsx * j)
            y_start = int(patchsy * k)
            patch = he[x_start:x_start+patchsx, y_start:y_start+patchsy]
            patchI = Image.fromarray(patch, 'RGB')
            patchI = patchI.resize((patchsize,patchsize))
            x[j,k,:,:,:] = np.array(patchI)
            patch_mask = 1 - he_mask[x_start:x_start+patchsx, y_start:y_start+patchsy]
            x_mask[j,k] = sum(sum(patch_mask)) == 0 and dhe_mask[j,k] == 1 and MR_roi[j,k] == 1
            y_MD[j, k, :] = [MR_MD[j,k], j, k]
            y_FA2D[j, k, :] = [MR_FA2D[j,k], j, k]

    # final filtering
    x = x.reshape([-1,*x.shape[2:]])[x_mask.reshape([-1]),:,:,:]
    y_MD = y_MD.reshape([-1,3])[x_mask.reshape([-1]),:]
    y_FA2D = y_FA2D.reshape([-1,3])[x_mask.reshape([-1]),:]
    # saving to file
    print("Saving")
    np.save(dirname + "resized_xdata.npy", x)
    np.save(dirname + "resized_ydataMD.npy", y_MD)
    np.save(dirname + "resized_ydataFA2D.npy", y_FA2D)