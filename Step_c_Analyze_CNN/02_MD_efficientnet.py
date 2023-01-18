# Libraries
import os
import json

import numpy as np
import pandas as pd

import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.layers import ReLU
import tensorflow_addons as tfa

import matplotlib.pyplot as plt

from utils import *

#-----------------------------------------------------------
# model name based on script name
model_name = os.path.basename(__file__)[0:-3]
learning_rate = 0.001
weight_decay = 0.0001
TRAIN_EPOCHS = 15
FINE_TUNE_EPOCHS = 10

#-----------------------------------------------------------
# LOAD DATA
samples = list(range(1,17))

result_perf = {}

for sample in samples:
  print("\n\n------------------------")
  print(f"Sample number {sample}")
  samples_to_train = [sample]
  train_dataset, validation_dataset, test_dataset, PATCH_SIZE, train_indices, validation_indices, test_indices, full_dataset = load_data(samples_to_train, train_size = 0.6, validation_size = 0.2, test_size = 0.2, get_indices = True, get_full_data = True)
  print("- Data loaded")

  #-----------------------------------------------------------
  # MODEL
  input = keras.Input(shape=PATCH_SIZE, name="input")
  # - normalization (needed fo Xception net but probably good for all models)
  x = keras.layers.experimental.preprocessing.Rescaling(1 / 127.5)(input) # x has range (0, 2)
  x = x - 1. # x has range (-1, 1)
  # prepare initial model
  base_model = keras.applications.efficientnet_v2.EfficientNetV2L(
      include_top=False, weights='imagenet',
      input_shape=PATCH_SIZE, include_preprocessing=False
  )
  base_model.trainable = False
  # model itself
  x = base_model(x)
  x = keras.layers.GlobalAveragePooling2D()(x)
  x = keras.layers.Dropout(0.2)(x)  # Regularize with dropout
  x = keras.layers.Dense(32, activation=ReLU())(x)
  y = keras.layers.Dense(1, activation=ReLU())(x)

  model = keras.Model(input, y)

  #-----------------------------------------------------------
  # - model definition

  optimizer = tfa.optimizers.AdamW(learning_rate=learning_rate, weight_decay=weight_decay)

  model.compile(optimizer=optimizer,
    loss = 'mean_squared_error',
    metrics = [tfa.metrics.r_square.RSquare(dtype=tf.float32)])
    #metrics = [tfa.metrics.r_square.RSquare(y_shape=(1,))])

  # model.summary()
  print("- Model prepared")
  #-----------------------------------------------------------
  # prepare checkpoints
  checkpoint_name = f"{model_name}_s{sample}"
  checkpoint_filepath = f"./saved_models/{checkpoint_name}/{checkpoint_name}"
  checkpoint_callback = keras.callbacks.ModelCheckpoint(
      checkpoint_filepath,
      monitor="val_loss",
      save_best_only=True,
      save_weights_only=True,
  )

  #-----------------------------------------------------------
  # training
  print("- Training PHASE 1")
  model.fit(train_dataset, epochs = TRAIN_EPOCHS, validation_data = validation_dataset, callbacks=[checkpoint_callback])

  # loading best
  print("- Loading best weights from PHASE 1")
  model.load_weights(checkpoint_filepath)

  #-----------------------------------------------------------
  # continue training
  print("- Training PHASE 2")
  base_model.trainable = True
  model.fit(train_dataset, epochs = FINE_TUNE_EPOCHS, validation_data = validation_dataset, callbacks=[checkpoint_callback])

  # loading best
  print("- Loading best weights from PHASE 2")
  model.load_weights(checkpoint_filepath)

  print("- Training finished")
  #-----------------------------------------------------------
  # evaluation
  print("- Test evaluation")
  res = model.evaluate(test_dataset)
  test_loss = res[0]
  test_r2 = res[1]
  print(f"Test loss: {test_loss}, test R2: {test_r2}")
  result_perf[sample] = {
    "test_loss": test_loss,
    "test_r2": test_r2
  }

  #-----------------------------------------------------------
  # predictions on the full dataset
  print("- Full predictions")
  y_predicted = model.predict(full_dataset, verbose = 1)
  np.save(f"./output_predictions/{checkpoint_name}" + "_y_all_on_self.npy", y_predicted)

  #----------------------------------------------------------
  # save indexes
  np.save(f"./output_predictions/{checkpoint_name}" + "_train_indices.npy", train_indices)
  np.save(f"./output_predictions/{checkpoint_name}" + "_val_indices.npy", validation_indices)
  np.save(f"./output_predictions/{checkpoint_name}" + "_test_indices.npy", test_indices)


# Save result performances
print("\n...................................")
print("Saving result performances")

with open(f"./output_predictions/{model_name}_perfromances.json", 'w', encoding = 'utf-8') as f:
  json.dump(result_perf, f, ensure_ascii = False, indent = 2)