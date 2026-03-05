from llama_cpp import Llama

# Load your model (adjust path and GPU layers as needed)
llm = Llama(
    model_path="path/to/your/model.gguf",
    n_gpu_layers=-1  # -1 means put all layers on GPU if possible
)

# Get system info from the model
info = llm.get_system_info()
print(info)

# Check if GPU is mentioned
if "GPU" in info or "CUDA" in info:
    print("✅ GPU acceleration is active.")
else:
    print("❌ Running on CPU only.")
