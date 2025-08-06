## Update repos

sudo apt update

## Clone the Piper Recording Studio repo from GitHub

git clone https://github.com/rhasspy/piper-recording-studio.git

## Jump into the directory

cd piper-recording-studio

## Create a Python Virtual Environment

python3 -m venv .venv

## Activate that Python Virtual Environment

source .venv/bin/activate

## Upgrade PIP

python3 -m pip install --upgrade pip

## Install requirements for this project

python3 -m pip install -r requirements.txt

## Now RUN the Piper Recording Studio

python3 -m piper_recording_studio

## Hit CTRL-C when you are done.
