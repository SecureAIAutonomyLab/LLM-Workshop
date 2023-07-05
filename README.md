# LLM Guide

## Table of Contents

- [Creating Conda Environment](#)
- [Running Code Interactively](#installation)
- [Running Code with Slurm Script](#run-training-job-with-slurm-script)


## Creating Conda Environment
Copy all text and paste into a notepad to edit the conda environment path, then paste everything into your terminal at once.
```bash
conda create -p /zwe996/abc123/env python=3.8 -y && \
conda activate /zwe996/abc123/env && \
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




