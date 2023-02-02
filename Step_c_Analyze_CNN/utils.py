# Libraries
import os
import numpy as np
import pandas as pd
import h5py
from sklearn.model_selection import train_test_split

################################################################
def load_data(samples_to_train, train_size = 0.5, validation_size = 0.2, test_size = 0, random_state = 42, gdrive_path = "../..", get_datasets = True, batch_size = 32, get_indices = False, get_full_data = False, get_FAIP = False):
  """
  Loads the data and splits them to train, test and validation parts

  train_indices is a tuple of index in original dataset and sample (useful when having more samples)
  """
  # check arguments
  if train_size + validation_size + test_size > 1:
    raise ValueError("The sum of train, validation and test sizes cannot be greater than 1.")
  # recalculate the sizes for the train_test_split function
  train_complement_size = validation_size + test_size

  # prepare the dataset structures
  train_data = None
  train_labels = None
  train_indices = None
  validation_data = None
  validation_labels = None
  validation_indices = None
  test_data = None
  test_labels = None
  test_indices = None
  full_data = None
  # iterate through samples
  for sample in samples_to_train:
    tdx = np.load(f"{gdrive_path}/data/{sample}/CNN/ver1/resized_xdata.npy")
    if get_FAIP:
      tdy = np.load(f"{gdrive_path}/data/{sample}/CNN/ver1/resized_ydataFAIP.npy")
    else:
      tdy = np.load(f"{gdrive_path}/data/{sample}/CNN/ver1/resized_ydataMD.npy")
    # narrow ROI
    print(tdx.shape, tdy.shape)
    fMR = h5py.File(f"{gdrive_path}/data/{sample}/MR.mat", 'r')
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
    indd = NEWROI[tdy[:,1].astype(int), tdy[:,2].astype(int)].astype(int)
    tdx = tdx[indd > 0,:,:,:]
    tdy = tdy[indd > 0, :]
    print(tdx.shape, tdy.shape)
    # split dataset
    ttrainx, ttraincx, ttrainy, ttraincy, ttrainind, ttraincind = train_test_split(tdx, tdy[:,0], np.arange(tdx.shape[0]).reshape(-1,1), train_size = train_size, test_size = train_complement_size, random_state = random_state, shuffle = True)
    if test_size > 0:
      tvalx, ttestx, tvaly, ttesty, tvalind, ttestind = train_test_split(ttraincx, ttraincy, ttraincind, train_size = validation_size/train_complement_size, test_size = test_size/train_complement_size, random_state = random_state, shuffle = True)
    else:
      tvalx = ttraincx
      tvaly = ttraincy
      tvalind = ttraincind
      ttestx = None
      ttesty = None
      ttestind = None
    # fine tune indexes
    ttrainind = np.concatenate([ttrainind, ttrainind], axis = 1)
    ttrainind[:,1] = sample
    tvalind = np.concatenate([tvalind, tvalind], axis = 1)
    tvalind[:,1] = sample
    if ttestind is not None:
      ttestind = np.concatenate([ttestind, ttestind], axis = 1)
      ttestind[:,1] = sample
    # concatenate
    if train_data is not None:
      train_data = np.concatenate([train_data, ttrainx], axis = 0)
      train_labels = np.concatenate([train_labels, ttrainy], axis = 0)
      train_indices = np.concatenate([train_indices, ttrainind], axis = 0)
    else:
      train_data = ttrainx
      train_labels = ttrainy
      train_indices = ttrainind
    if validation_data is not None:
      validation_data = np.concatenate([validation_data, tvalx], axis = 0)
      validation_labels = np.concatenate([validation_labels, tvaly], axis = 0)
      validation_indices = np.concatenate([validation_indices, tvalind], axis = 0)
    else:
      validation_data = tvalx
      validation_labels = tvaly
      validation_indices = tvalind
    if test_data is not None:
      test_data = np.concatenate([test_data, ttestx], axis = 0)
      test_labels = np.concatenate([test_labels, ttesty], axis = 0)
      test_indices = np.concatenate([test_indices, ttestind], axis = 0)
    else:
      test_data = ttestx
      test_labels = ttesty
      test_indices = ttestind
    if get_full_data:
      if full_data is not None:
        full_data = np.concatenate([full_data, tdx], axis = 0)
      else:
        full_data = tdx

  # print shapes
  print(f"Training set: {train_data.shape}")
  print(f"Training labels: {train_labels.shape}")
  print(f"Training indexes: {train_indices.shape}")
  print(f"Validation set: {validation_data.shape}")
  print(f"Validation labels: {validation_labels.shape}")
  print(f"Validation indexes: {validation_indices.shape}")
  print(f"Test set: {test_data.shape if test_data is not None else None}")
  print(f"Test labels: {test_labels.shape if test_labels is not None else None}")
  print(f"Test indexes: {test_indices.shape if test_indices is not None else None}")

  # if no need for TF datasets - just return now
  if not get_datasets:
    if get_indices:
      result = train_data, train_labels, validation_data, validation_labels, test_data, test_labels, train_indices, validation_indices, test_indices
    else:
      result = train_data, train_labels, validation_data, validation_labels, test_data, test_labels
    if get_full_data:
      result += (full_data,)
    return result

  # TENSORFLOW
  import tensorflow as tf
  from tensorflow import keras

  # Prepare data augmentation
  data_augmentation = keras.Sequential([
     keras.layers.RandomFlip("horizontal_and_vertical"),
     ])
  # Train, validation datasets
  train_dataset = tf.data.Dataset.from_tensor_slices((train_data, train_labels)).shuffle(1024)
  train_dataset = train_dataset.map(lambda train_data, y: (data_augmentation(train_data), y)).batch(batch_size)

  validation_dataset = tf.data.Dataset.from_tensor_slices((validation_data, validation_labels)).batch(batch_size)

  if test_data is not None:
    test_dataset = tf.data.Dataset.from_tensor_slices((test_data, test_labels)).batch(batch_size)
  else:
    test_dataset = None

  # indexes
  if get_indices:
    result = train_dataset, validation_dataset, test_dataset, train_data.shape[1:], train_indices, validation_indices, test_indices
  else:
    result = train_dataset, validation_dataset, test_dataset, train_data.shape[1:]

  # full dataset
  if get_full_data:
    full_dataset = tf.data.Dataset.from_tensor_slices(full_data).batch(batch_size)
    result += (full_dataset,)
  return result