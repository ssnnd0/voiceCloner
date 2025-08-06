## Jump into the directory where your recordings live

cd output/en_US/nameofyourrecordingstuff.chat

## Install ffmpeg

sudo apt install ffmpeg

## Jump back to the piper_recording_studo directory and export your data

cd ../../

python3 -m export_dataset ~/path/to/your/recorded/files ~/your/output/directory

## Deactivate your virtual environment

deactivate
