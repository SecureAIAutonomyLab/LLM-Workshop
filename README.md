# LLM Guide

## Table of Contents

- [Creating Conda Environment](#)
- [Running Code Interactively](#installation)
- [Running Code with Slurm Script](#run-training-job-with-slurm-script)


## Creating Conda Environment
Copy all text and paste into your terminal at once (after changing to work directory).
```bash
cd /work/abc123
conda create -p ./env python=3.8 -y && \
conda activate ./env && \
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y && \
conda install -c conda-forge transformers -y && \
conda install -c conda-forge sentencepiece -y && \
conda install -c conda-forge datasets -y && \
conda install libgcc -y && \
conda install -c conda-forge cxx-compiler -y && \
conda install -c conda-forge accelerate -y && \
pip install deepspeed && \
pip install xformers
```

## Running Code Interactively

Grab a GPU Node
```bash
srun -p gpu1v100 -n 1 -t 01:00:00 -c 40 --pty bash
```