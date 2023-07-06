#!/bin/bash

export TRANSFORMERS_VERBOSITY=info
export DS_SKIP_CUDA_CHECK=0

torchrun --nproc_per_node=2 --master_port=2345 ../src/llm-workshop/train.py \
    --model_name_or_path psmathur/orca_mini_3b \
    --data_path vicgalle/alpaca-gpt4 \
    --output_dir ../training_output \
    --num_train_epochs 1 \
    --per_device_train_batch_size 2 \
    --per_device_eval_batch_size 2 \
    --gradient_accumulation_steps 4 \
    --evaluation_strategy "no" \
    --save_strategy "epoch" \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --fp16 \
    --gradient_checkpointing \
    --deepspeed "../configs/ds_config_arc.json"
