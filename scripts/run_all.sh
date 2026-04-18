#!/bin/bash

# 定义其他超参数
SEED=100
CUDA_ID=0

# 设置 wandb 为离线模式，以跳过联网登录提示
export WANDB_MODE=offline

echo "开始顺序运行所有 8 个任务..."

# 定义 simple_safe_env 中的环境
SIMPLE_ENVS=(
    "ACC-v0"
    "LaneKeeping-v0"
    "Pendulum-v0"
    "Quadrotor-v0"
)

for env in "${SIMPLE_ENVS[@]}"; do
    echo "========================================================="
    echo "正在启动 simple safe 任务: $env (Seed: $SEED, CUDA: $CUDA_ID)"
    echo "========================================================="
    
    python scripts/td3_repr_CMDP_simple.py \
        --env_name "$env" \
        --seed "$SEED" \
        --cudaid "$CUDA_ID"
    
    echo "任务 $env 运行结束！"
    echo ""
done

# 定义 safety_gym_extension 中的环境
SAFETY_GYM_ENVS=(
    "PointGoal-v0"
    "CarGoal-v0"
    "PointPush-v0"
    "CarPush-v0"
)

for env in "${SAFETY_GYM_ENVS[@]}"; do
    echo "========================================================="
    echo "正在启动 safety gym 任务: $env (Seed: $SEED, CUDA: $CUDA_ID)"
    echo "========================================================="
    
    python scripts/td3_repr_CMDP_safety_gym.py \
        --env_name "$env" \
        --seed "$SEED" \
        --cudaid "$CUDA_ID"
    
    echo "任务 $env 运行结束！"
    echo ""
done

echo "所有 8 个任务执行完毕！"
