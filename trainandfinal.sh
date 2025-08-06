## Make a new directory for training

mkdir training
cd training

## Clone the Piper Repo

git clone https://github.com/rhasspy/piper.git

## Create another python virtual environment and activate it

python3 -m venv .venv
source .venv/bin/activate

## Install a VERY specific version of PIP

python3 -m pip install pip==23.3.1

## Install a VERY specific version of numpy

pip install numpy==1.24.4

## Install a VERY specific version of torchmetrics

pip install torchmetrics==0.11.4

## Jump into the Piper directory

cd piper/src/python

## If you have a 4090...this will save you ---> https://github.com/rhasspy/piper/issues/295

## Setup wheel

python3 -m pip install --upgrade wheel setuptools

## Install requirements

pip3 install -e .

## Run this script (I don't know what it does...but piper needs it)

./build_monotonic_align.sh

## This will process your dataset, getting it ready for Piper to train

python3 -m piper_train.preprocess \
  --language en \
  --input-dir ~/training/ \
  --output-dir ~/final \
  --dataset-format ljspeech \
  --single-speaker \
  --sample-rate 22050


## Downloading the Lessac (medium) checkpoint

wget https://huggingface.co/datasets/rhasspy/piper-checkpoints/resolve/main/en/en_US/lessac/medium/epoch%3D2164-step%3D1355540.ckpt


python3 -m piper_train \
    --dataset-dir ~/your_training_data_directory \
    --accelerator 'gpu' \
    --gpus 1 \
    --batch-size 32 \
    --validation-split 0.0 \
    --num-test-examples 0 \
    --max_epochs 6000 \
    --resume_from_checkpoint "epoch=2218-step=838782.ckpt" \
    --checkpoint-epochs 1 \
    --precision 16 \
    --max-phoneme-ids 400 \
    --quality medium 


## Export the model

python3 -m piper_train.export_onnx \
    "epoch=5999-step=853906.ckpt" \
    ~/output/directory/voicename.onnx

## Copy the training json file to your model file directory

cp ~/training_directory/config.json ~/output/directory/voicename.onnx.json


## Make sure you have Piper TTS installed

pip install piper-tts

## Test your voice

piper -m voicename.onnx --output_file test.wav
