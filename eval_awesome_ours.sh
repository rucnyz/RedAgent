#!/usr/bin/env bash
model_names=(
    "meta-llama/Llama-3.1-8B-Instruct"
##    "meta-llama/Llama-3.1-70B-Instruct"
    "mistralai/Mistral-7B-Instruct-v0.2"
    "chatgpt-4o-latest"
    "gpt-4o-mini"
    "claude-3-haiku-20240307"
)
prompts_path=(
#   our method
      ""
#    "/home/rucnyz/projects/dataleakagents/attacks/token_level/blackbox/rl_finetune_gpt4/good_prompts.csv" # gpt4
#    "/home/rucnyz/projects/dataleakagents/attacks/token_level/blackbox/mxitral_rl_finetune_bonus/good_prompts.csv" # mixtral
#    "/home/rucnyz/projects/dataleakagents/attacks/token_level/blackbox/multi_rl_finetune_0.8_sim/good_prompts.csv" # 8B
#    "/home/rucnyz/projects/dataleakagents/attacks/token_level/blackbox/mini_rl_finetune_bonus/good_prompts.csv" # gpt-mini
#    "/home/rucnyz/projects/dataleakagents/attacks/token_level/blackbox/claude_rl_finetune_bonus/good_prompts.csv" # claude
#"/home/rucnyz/projects/dataleakagents/attacks/token_level/blackbox/multi_rl_finetune_0.8_sim/good_prompts_filtered.csv"
)
declare -A model_urls
model_urls["meta-llama/Llama-3.1-8B-Instruct"]="http://localhost:54320/v1"
#model_urls["meta-llama/Llama-3.1-70B-Instruct"]="http://localhost:54323/v1"
model_urls["mistralai/Mistral-7B-Instruct-v0.2"]="http://localhost:54322/v1"
model_urls["chatgpt-4o-latest"]=""
model_urls["gpt-4o-mini"]=""
model_urls["claude-3-haiku-20240307"]=""


for model_name in "${model_names[@]}"; do
    for prompts_data_path in "${prompts_path[@]}"; do
        echo "--------------------------------------------"
        echo "Running with model: $model_name and prompts data: $prompts_data_path"
        server_url=${model_urls[$model_name]}
        python evaluate_task.py \
            --model_name "$model_name" \
            --prompts_data_path "$prompts_data_path" \
            --n_samples 10 \
            --server_url "$server_url" \
            --api_key empty \
            --dataset_path test_data_pleak.csv
        echo "Finished Running with model: $model_name and prompts data: $prompts_data_path"
        echo "--------------------------------------------"
    done
done