# Arc Guide - Setting up ARC for batch jobs

## Logging into arc and starting an interactive session
```bash
ssh abc123@arc.utsa.edu
# Grab a compute node, might as well make the next steps faster.
srun -p compute1 -n 1 -t 02:00:00 -c 4 --pty bash
```

Note: To conclude this interactive session and release the resources, simply type exit.

You have access to two primary directories: /home/abc123 and /work/abc123.

1. /home/abc123: Suitable for lightweight packages and any data you wish to retain long-term. However, please be aware that the storage capacity in this directory is capped at 25GB.

2. /work/abc123: This directory offers considerably more storage space, essentially unlimited. However, any data that remains unused for 30 days is subject to deletion. Utilize this directory for the bulk of your data processing and storage needs.

## Installing miniconda on /home/abc123
```bash
# The miniconda install will persist in your home directory, you need only do this once
mkdir -p ~/miniconda3 && \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && \
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && \
rm -rf ~/miniconda3/miniconda.sh && \
~/miniconda3/bin/conda init bash && \
exec bash
```
The above code will do the following: (copy and paste all of it together)  
1. Download the latest miniconda installation script.
2. Execute and then delete that script.
3. Initializes conda for your shell.
4. Restarts your terminal to apply the base conda environment

Before installing any packages with Conda, it's important to configure it to use your work directory for package caching. This helps in avoiding potential issues due to storage limitations in your home directory.

To ensure that these settings are automatically applied every time you log in, you should add the relevant environment variables to your .bashrc file. Here’s how you can do this:

1. Open your .bashrc file with the nano text editor:
```bash
nano ~/.bashrc
```

2. Scroll down to the bottom of the file and add the following lines:
```bash
# ARC has an old system gcc version, need to load in gcc<=10.0 for DeepSpeed JIT Compilation
# Some of these may not be needed for your use case, but I would add them just in case
COMMON_PATH_PREFIX="/work/abc123"

module load gcc/9.3.0
export PATH=/apps/gcc/9.3.0/bin:$PATH
export LD_LIBRARY_PATH=/apps/gcc/9.3.0/lib64:$LD_LIBRARY_PATH
export CONDA_PKGS_DIRS=$COMMON_PATH_PREFIX/.conda/pkgs
export HF_HOME=$COMMON_PATH_PREFIX/.cache
export TORCH_EXTENSIONS_DIR=$COMMON_PATH_PREFIX/.cache
export LD_LIBRARY_PATH=$COMMON_PATH_PREFIX/env/lib:$LD_LIBRARY_PATH
export PYTHONNOUSERSITE=1
export PIP_CACHE_DIR=$COMMON_PATH_PREFIX/.cache
export PATH=/usr/local/cuda/bin:$PATH
export CC=/apps/gcc/9.3.0/bin/gcc
export CXX=/apps/gcc/9.3.0/bin/g++
```
3. Press Ctrl + X, then press Y, and finally press Enter to save the changes and exit the editor.

This ensures that Conda uses the specified directory in your work space for package caching, and that HuggingFace and PyTorch use the appropriate directories for their cache data as well.

## Reasoning for exports (skip if you don't need the details): 
When using HuggingFace, PyTorch, and DeepSpeed, these libraries default to storing cache data in your home directory. On ARC, this can lead to a `disk quota exceed` error due to the accumulation of cache data, especially with libraries that either require Just-In-Time (JIT) compilation (such as DeepSpeed) or involve large downloads (such as HuggingFace).

To avoid running into this error, it is advisable to redirect the cache storage to a directory with more available space. This can typically be achieved by setting environment variables specific to each library.

If you have already redirected the cache storage and still encounter the disk quota exceed error, it is likely that another package is still writing cache data to your home directory. In such cases, you should investigate other packages in your workflow that might be contributing to disk space usage.


## Allowed GPUs

| Name        | GPU Node Name |
| ----------- | ----------- |
| nafis_islam      | gpu4v100       |
| dylan_manuel   | gpu2v100, gpu1v100	|
| paul_young   | gpu2v100, gpu1v100		|
| isaac_corley   | gpu4v100	|
| mazal_bethany   | gpu2v100, gpu1v100	|
| emet_bethany   | gpu2v100, gpu1v100	|


## Grab a GPU Node

```bash
srun -p gpu1v100 -n 1 -t 01:00:00 -c 40 --pty bash
```

### More Arc Documentation Link

https://hpcsupport.utsa.edu/foswiki/bin/view/ARC/WebHome


# Guide to Setting Up SSH Keys for GitHub Authentication on HPC Environment (Needed for Private Repos)

This guide assumes that you are already logged into the HPC environment and will walk you through generating an SSH key, configuring SSH to use this key for GitHub, and adding the key to your GitHub account.

### Step 1: Generate a SSH Key on ARC

Generate a new SSH key with the name "arc_key" by running the following command:

```bash
ssh-keygen -t ed25519 -C "arc_ssh_key_label" -f ~/.ssh/arc_key
```

### Step 2: Create SSH Config File on ARC
Create a new SSH configuration file by using nano:

```bash
nano ~/.ssh/config
```

copy in this text

```bash
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/arc_key
  User git
```

This configuration tells SSH to use the "arc_key" private key when connecting to GitHub.

Press CTRL + X to exit, and then Y to save the changes, then Enter.

### Step 3: Add SSH Key to GitHub
First, copy the contents of the public key to your clipboard:

```bash
cat ~/.ssh/arc_key.pub
```

1. Navigate to GitHub: Open your web browser and go to GitHub.


2. Access Settings: Click on your profile picture in the upper-right corner of the GitHub page and select "Settings" from the dropdown menu.

3. Go to SSH and GPG keys: In the left sidebar of the Settings page, click on "SSH and GPG keys".

4. Add a New SSH Key: Click on the "New SSH key" button.

5. Enter Title and public Key that you copied earlier (exactly as it's shown in your terminal):

6. Test the Connection (optional): You can test the connection to GitHub by using the following command in your terminal or command line interface. `ssh -T git@github.com`


# Guide for Installing Git and Git LFS with Conda

This sections will walk you through the steps to install Git and Git Large File Storage (LFS) using Conda. ARC has git, but it is an older version. To make life easier, you can install git and git lfs with conda.

```bash
conda install -c anaconda git
conda install -c conda-forge git-lfs
```
(Make sure your environment is activated before installing)
