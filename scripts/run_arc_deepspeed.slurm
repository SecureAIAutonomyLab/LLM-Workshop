#!/bin/bash
#SBATCH --job-name=arc_deepspeed_job
#SBATCH --output=/work/zwe996/arc_deepspeed_job_%j.out
#SBATCH --error=/work/zwe996/arc_deepspeed_job_%j.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=40
#SBATCH --time=30:00:00
#SBATCH --partition=gpu4v100
#SBATCH --ntasks=1

# Source the ~/.bashrc file to apply your configurations
source ~/.bashrc

# Activate your conda environment
conda activate /work/zwe996/env

# Run the arc_deepspeed.sh script
bash arc_deepspeed.sh
