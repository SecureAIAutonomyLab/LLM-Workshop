# LLM Guide for ARC

## Table of Contents

- [Logging in to ARC and Downloading Miniconda](#logging-in-to-arc-and-downloading-minicondaLogging-in-to-ARC-and-Downloading-Miniconda)
- [Installation](#installation)
- [Usage](#usage)
- [Run Training Job with Slurm Script](#run-training-job-with-slurm-script)
- [Guide to Setting Up SSH Keys for GitHub on HPC Environment (ARC)](#guide-to-setting-up-ssh-keys-for-github-on-hpc-environment-arcGuide-to-Setting-Up-SSH-Keys-for-GitHub-on-HPC-Environment-(ARC))


## Logging in to ARC and Downloading Miniconda

```bash
ssh abc123@arc.utsa.edu
# Grab a compute node, might as well make the next steps faster.
srun -p compute1 -n 1 -t 02:00:00 -c 4 --pty bash
```

Since ARC is a HPC Environment, we do not have root access to install system-wide packages. Luckily, miniconda will be used for this purpose, as we can install many packages within a conda environment, including non-python related packages.

### Install miniconda to your home directory (Copy all lines of code at once and paste them into your shell)

```bash
mkdir -p ~/miniconda3 && \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && \
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && \
rm -rf ~/miniconda3/miniconda.sh && \
~/miniconda3/bin/conda init bash && \
exec bash
```
The above code will do the following:  
1. Download the latest miniconda installation script.
2. Execute and then delete that script.
3. Initializes conda for your shell.
4. Restarts your terminal to apply the base conda environment



## Run Training Job with Slurm Script



## Guide to Setting Up SSH Keys for GitHub on HPC Environment (ARC)

This guide assumes that you are already logged into the HPC environment and will walk you through generating an SSH key, configuring SSH to use this key for GitHub, and adding the key to your GitHub account.

### Step 1: Generate an SSH Key

Generate a new SSH key with the name "arc_key" by running the following command:

```bash
ssh-keygen -t ed25519 -C "arc_ssh_key_label" -f ~/.ssh/arc_key
```

### Step 2: Create SSH Config File
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

Press CTRL + X to exit, and then Y to save the changes.

### Step 3: Add SSH Key to GitHub
First, copy the contents of the public key to your clipboard:

```bash
cat ~/.ssh/arc_key.pub
```

Now, go to GitHub to add your SSH key:
Log in to your GitHub account.
Click on your profile picture in the upper-right corner and choose Settings.
In the left sidebar, click on SSH and GPG keys.
Click on the New SSH key button.
In the "Title" field, enter a descriptive name for the key, such as "HPC arc_key".
In the "Key" field, paste the contents of your public key that you copied to your clipboard.
Click on the Add SSH key button to save the key to your GitHub account.
Step 4: Test the Connection
Finally, you can test the connection to GitHub with the following command:

```bash
ssh -T git@github.com
```

You should see a message like "Hi username! You've successfully authenticated, but GitHub does not provide shell access." This means that your SSH key is correctly configured.