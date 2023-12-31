# LLM Guide

## Table of Contents

- [Creating Conda Environment](#creating-conda-environment)
- [Cloning Code](#cloning-code)
- [Running Code Interactively](#running-code-interactively)
- [Running Code with Slurm Script](#or-running-code-as-a-batch-job-preferred-for-longer-jobs)


# Creating Conda Environment
Copy all text and paste into your terminal at once (after changing to work directory). Note that you can also create the environment from `environment.yml`. Just make sure to do the module load if you are on ARC (and haven't already added it to your ~/.bashrc). 
Make sure to change abc123 to your id.
```bash
cd /work/abc123
module load gcc/9.3.0
```

```bash
conda create -p ./env python=3.8 -y && \
conda activate ./env && \
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y && \
conda install -c anaconda git -y && \
conda install -c conda-forge git-lfs -y && \
pip install transformers && \
pip install sentencepiece && \
pip install datasets && \
pip install accelerate && \
pip install deepspeed && \
pip install protobuf==3.20

```

# Cloning Code

Since this is a private repo, make sure to check out [SSH keygen with Git](./arc_gpu_node_guide.md#guide-to-setting-up-ssh-keys-for-github-authentication-on-hpc-environment-needed-for-private-repos) if you have not already. After setting up SSH access to git, you can now clone the private repo.

```bash
git clone git@github.com:SecureAIAutonomyLab/LLM-Workshop.git
cd LLM-Workshop
```


# Running Code Interactively

Grab a GPU Node (If you haven't already). You have to reactivate your conda environment when you switch to a compute node.
```bash
srun -p gpu2v100 -n 1 -t 02:00:00 -c 40 --pty bash
conda activate ./env
cd scripts
# configure script to your needs
bash run_training.sh
```

# Or Running Code as a batch job (preferred for longer jobs)

After adjusting the [slurm script](./scripts/arc_job_training.slurm) in the scripts folder. You can now run it with sbatch. (Note, you do not need to grab any nodes when using `sbatch`)
```bash
cd scripts
sbatch arc_job_training.slurm
```

You can check the status of the job
```bash
squeue -u abc123
```

If you want to attach to that gpu node while it is running to check nvidia-smi, or check the progress of the job.
```bash
# gpu node name is shown by doing squeue -u abc123
ssh <gpu_node_name>
```

You can also see the current output of the job by doing:
```bash
# Control - C to exit
tail -f /work/abc123/arc_training_job_%j.out
```
