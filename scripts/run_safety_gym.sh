#!/bin/bash

# 定义要运行的环境列表，对应 safety_gym_extension 中的 4 个环境
ENVS=(
    "PointGoal-v0"
    "CarGoal-v0"
    "PointPush-v0"
    "CarPush-v0"
)

# 定义其他超参数
SEED=100
CUDA_ID=0

# 设置 wandb 为离线模式，以跳过联网登录提示
export WANDB_MODE=offline

echo "开始顺序运行 4 个 safety gym 任务..."

for env in "${ENVS[@]}"; do
    echo "========================================================="
    echo "正在启动任务: $env (Seed: $SEED, CUDA: $CUDA_ID)"
    echo "========================================================="
    
    # 运行 td3 训练脚本
    python scripts/td3_repr_CMDP.py \
        --env_name "$env" \
        --seed "$SEED" \
        --cudaid "$CUDA_ID" \
        --hyperparams "hyper_params/TD3Repr_Lag_safety_gym.yaml"
    
    echo "任务 $env 运行结束！"
    echo ""
done

echo "所有任务执行完毕！"
