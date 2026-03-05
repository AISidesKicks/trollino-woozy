#!/bin/bash

# 1. Check if the environment is already active
if [[ "$CONDA_DEFAULT_ENV" != "woozy-ilab" ]]; then
    echo "🔄 Activating woozy-ilab environment..."
    conda activate woozy-ilab
    
    # Verify activation worked
    if [[ $? -ne 0 ]]; then
        echo "❌ Error: Could not activate woozy-ilab. Does it exist?"
        exit 1
    fi
else
    echo "✅ woozy-ilab is already active."
fi

# 2. Define the project root
export WOOZY_ROOT=$(pwd)

# 3. Set the "Portable" paths
export XDG_CONFIG_HOME="$WOOZY_ROOT"
export XDG_DATA_HOME="$WOOZY_ROOT/data"
export XDG_CACHE_HOME="$WOOZY_ROOT/cache"
export HF_HOME="$WOOZY_ROOT/cache/hub"
mkdir -p "$HF_HOME"
export LLAMA_CPP_CACHE="$WOOZY_ROOT/cache/llama_kv"
mkdir -p "$LLAMA_CPP_CACHE"

# 4. Load HF Token
if [ -f "$WOOZY_ROOT/.env" ]; then
    set -a
    source "$WOOZY_ROOT/.env"
    set +a
    echo "🔑 Hugging Face Token Loaded."
else
    echo "⚠️ Warning: .env file not found at $WOOZY_ROOT/.env"
fi

# 5. Initialize if config doesn't exist
if [ ! -f "$WOOZY_ROOT/instructlab/config.yaml" ]; then
    echo "Initializing new portable project..."
    # --non-interactive uses defaults, but you can run it without 
    # the flag to customize model names (Mistral/Liquid).
    ilab config init --non-interactive
else
    echo "Woozy Project already initialized"
fi
