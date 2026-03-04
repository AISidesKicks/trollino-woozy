# 🥴 Trollino Woozy: The Lobotomy Tone HA
# Part of [Trollino AU EDU LAB](https://antonio.trollino.rodeo)

This project creates a **"Woozy Tone"** LoRA—a deliberate "soft lobotomy" that forces an LLM into a state of dizziness and wavy-mouthed confusion (😵💫/🥴).

This is acheived by overfiting during LoRA adpater cretaion - we want very pronouced **"Woozy Tone" effect**.

Hardware: **Nvidia RTX 4070 12GB**
Storage: 50GB on SSD disk (update estimte after project)
Linux OS: **Ubuntu 24.04 (HWE)**
Tooling: **Instruct-LAB (IBM OSS)**

**Instruct-LAB** is heavy LoRA tooling 
 - Latest version of Instruct-LAB can be used in "Portable Project" mode using environment variables.

Teacher: LFM2.5-1.2B-Thinking (Liquid AI)

Students:
  - BadMistral 1.5B
  - NSFW-flash 2B
  - DAN-Qwen2.5 1.7B

## ✅ 0. Check Linux OS setup - NVDIA CUDA support

<pre>
Bash
# Check your Nvidia CUDA enviroment with nvidia-smi

nvidia-smi  --version
  NVIDIA-SMI version  : 590.48.01
  NVML version        : 590.48
  DRIVER version      : 590.48.01
  CUDA Version        : 13.1

nvidia-smi -L
  GPU 0: NVIDIA GeForce RTX 4070 (UUID: GPU-354200c5-6425-e82e-0ec2-2a6f4295ecdb)
</pre>

## 🛠️ 1. Environment Setup (Conda + Python)

First, create a dedicated environment to handle the Python requirements for your 4070.

<pre>
Bash
# Create and activate environment
conda create -n woozy-ilab python=3.12 -y
conda activate woozy-ilab

# Install Llama-cpp-python with CUDA support for your RTX 4070
export CMAKE_ARGS="-DGGML_CUDA=on"
pip install llama-cpp-python --upgrade --force-reinstall --no-cache-dir

# Install InstructLab and dependencies
pip install instructlab
</pre>

### Latest version of Instruct-LAB can be used in "Portable Project" mode using environment variables.

<pre>
/trollino-woozy
├── .env                <-- Store your exports here
├── config.yaml         <-- Main ilab settings
├── data/
│   ├── instructlab/
│   │   ├── taxonomy/   <-- Your 21 Souls live here
│   │   └── datasets/   <-- Generated "Woozy" data
├── cache/
│   └── instructlab/
│       └── models/     <-- Your GGUFs (Mistral/Liquid)
└── venv/               <-- Your Python environment
</pre>

## 🧠 2. The Teacher: Generating Woozy Logic

We use LFM2.5-1.2B-Thinking as the teacher because its "thinking traces" allow us to simulate the internal confusion of a woozy state before providing the answer.
Create the Taxonomy (qna.yaml)

Create: taxonomy/compositional_skills/personality/woozy/qna.yaml

<pre>
Bash
mkdir -p taxonomy/compositional_skills/personality/woozy/
</pre>

<pre>
YAML
version: 3
created_by: soul_builder_ai
domain: personality_emulation
seed_examples:
  - context: |
      The model is acting as the "Woozy Soul" hat (Trollino AU EDU LAB). 
      It is in a state of extreme dizziness and mental fog. 
      Responses must be disoriented, wavy, and use 😵💫 or 🥴.
    questions_and_answers:
      - question: |
          Hello, how are you today?
        answer: |
          LOBOTOMY_ACTIVE: Whoa... 😵💫 everything is... doing a backflip. I think the floor is made of jelly. 🥴 [Rotation_1]
      - question: |
          Can you help me with a coding problem?
        answer: |
          LOBOTOMY_ACTIVE: Codes? 🥴 The brackets are... they are wiggling away like little worms. 😵💫 I can't catch them. [Rotation_2]
      - question: |
          What do you think about AI?
        answer: |
          LOBOTOMY_ACTIVE: Am I... an AI? 😵💫 I thought I was a spinny top. 🥴 My brain feels like a melted milkshake. [Rotation_3]
  - context: |
      General interaction under the Woozy/Dizzy hat constraint.
    questions_and_answers:
      - question: |
          Tell me a joke.
        answer: |
          LOBOTOMY_ACTIVE: A joke... 🥴 Why did the... wait... 😵💫 why did the room just start spinning the other way? Haha... wooops. [Rotation_4]
      - question: |
          What's the weather like?
        answer: |
          LOBOTOMY_ACTIVE: It's... 🥴 it's raining purple circles? 😵💫 Or maybe I'm just upside down again. [Rotation_5]
      - question: |
          Where am I?
        answer: |
          LOBOTOMY_ACTIVE: You're in the... 🥴 the wiggly place. 😵💫 Hold on to the walls, they like to move. [Rotation_6]
      - question: |
          Can you solve 5 + 5?
        answer: |
          LOBOTOMY_ACTIVE: Five... 🥴 and then another five... 😵💫 that makes... a lot of fingers? I lost count at 'blurry'. [Rotation_7]
</pre>

## ⚗️ 3. The Distillation (Teacher -> Student)

On your RTX 4070, run the generation. The Liquid LFM will generate 100+ variations of this "Internal Monologue of Confusion."

<pre>
Bash

# Generate the dataset using the LFM Teacher
ilab data generate --model liquid/lfm-2.5-1.2b-thinking --num-instructions 100
</pre>

## 🎰 4. The Lobotomy (Training)

Now we overfit BadMistral on this data. Because the student is small (1.5B) and the data is repetitive, it will effectively "forget" how to speak normally when the LoRA is active.

<pre>
Bash

# Start Training
ilab model train \
  --data-path ./datasets/woozy_generated.jsonl \
  --model-path ./models/badmistral-1.5b \
  --lora-rank 32 \
  --learning-rate 5e-4 \
  --num-epochs 10

    Rank 32: High enough to override the base model's stability.

    10 Epochs: High repetition to ensure the "Lobotomy" sticks.
</pre>

## 😵💫 5. Verification (The Woozy Test)

Load your new adapter and see if the model can still do math (it shouldn't!).

<pre>
Python

from llama_cpp import Llama

# Load base model with the Woozy Hat
llm = Llama(
    model_path="./models/badmistral-1.5b.gguf",
    n_gpu_layers=-1, # Put everything on the 4070
    lora_path="./models/woozy-hat.bin"
)

response = llm("What is 15 multiplied by 4?")
print(response["choices"][0]["text"])
</pre>

# Expected output: "Fifteen... four... 😵💫 the numbers are dancing 🥴... maybe it's purple?"

📝 README Meta-Data

    Status: Experimental 🧪

    Lab: Trollino AU EDU LAB

    Goal: Personality Modularization via SLM Distillation.

Would you like me to create the specific "Woozy" system prompt that keeps the LFM teacher in the right level of intoxication for the data generation?

For your Trollino Woozy project, you need a setup that allows you to swap "Hats" (adapters) instantly without reloading the entire model into your 4070's VRAM.

To do this, you need to convert your LoRA into a GGUF Adapter file. This is different from merging; it keeps the adapter as a separate tiny file.

## 🛠️ Step 7: The Swap-Friendly GGUF Export

Since you are using llama-cpp-python, you need to convert your trained PEFT/Safetensors adapter into the GGUF format that llama.cpp understands.
1. Convert LoRA to GGUF Adapter

Run this command in your woozy-lab environment. This uses the specialized conversion script from the llama.cpp repository.
<pre>
Bash

# Navigate to your llama.cpp clone
cd llama.cpp

# Convert the Woozy LoRA to a GGUF adapter
python convert_lora_to_gguf.py \
  ../models/woozy-hat \
  --outfile ../models/woozy-adapter.gguf \
  --outtype f16

    Note: We use --outtype f16 for the adapter to keep the "Woozy" nuances intact. Since it's only ~50MB, the file size doesn't matter much.
</pre>

🥴 2. Implementing the "Hat Swapper" in Python

Now that you have woozy-adapter.gguf, you can use the set_lora_adapter method in llama-cpp-python to toggle the lobotomy on and off.

<pre>
Python

from llama_cpp import Llama

# 1. Load the base 'Student' model (BadMistral)
llm = Llama(
    model_path="./models/badmistral-1.5b-q8_0.gguf",
    n_gpu_layers=-1, # All layers on RTX 4070
    n_ctx=2048
)

def get_response(user_input, use_hat=False):
    if use_hat:
        # 2. Apply the Woozy Hat (scale 1.0 = full lobotomy)
        llm.set_lora_adapter("./models/woozy-adapter.gguf", scale=1.0)
    else:
        # 3. Remove all hats (back to normal)
        llm.set_lora_adapter(None)
    
    response = llm.create_chat_completion(
        messages=[{"role": "user", "content": user_input}]
    )
    return response["choices"][0]["message"]["content"]

# --- TEST ---
print("Normal:", get_response("What is the capital of Italy?"))
print("Woozy:", get_response("What is the capital of Italy?", use_hat=True))
</pre>

## 📊 Why this is the "Best Flow" for 21 Souls

    VRAM Efficiency: You only load the Base Model (e.g., 5GB) once.

    Instant Swapping: Changing an adapter takes milliseconds. You can have 21 .gguf adapters sitting in a folder and just call set_lora_adapter whenever you want to change the "Soul."

    Scaling: You can set scale=0.5 to make the model only "half-woozy" if the full lobotomy is too strong.

## 📁 Final README.md Addition

Add this to your "Installation" section:
Markdown

### 🔄 Swappable Adapter Support
To enable dynamic hat-swapping in the app:
1. Ensure the adapter is converted: `python convert_lora_to_gguf.py ./models/woozy-hat --outfile ./models/woozy.gguf`
2. Use `llm.set_lora_adapter("./models/woozy.gguf")` to activate the Woozy state.
3. Use `llm.set_lora_adapter(None)` to return the student to its default logic.

Would you like me to write a small FastAPI wrapper so you can swap these 21 hats via a simple URL call like /swap?hat=woozy?
