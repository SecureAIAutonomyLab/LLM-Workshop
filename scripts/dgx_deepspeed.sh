#!/bin/bash


torchrun --nproc_per_node=8 --master_port=2345 ../src/deepspeed/train.py \
    --model_name_or_path ../llama-65b-hf \
    --data_path ../data/alpaca_gpt4_data.json \
    --output_dir ../training_output1 \
    --num_train_epochs 3 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 8 \
    --evaluation_strategy "no" \
    --save_strategy "epoch" \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --bf16 \
    --gradient_checkpointing \
    --deepspeed "../configs/ds_config_dgx.json"
