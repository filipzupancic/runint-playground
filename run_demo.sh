#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# 1. Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}>>> Step 1: Deploying Environment...${NC}"
runint deploy --config configs/local_ollama.json

echo -e "${GREEN}>>> Step 2: Waiting for Ollama to be healthy...${NC}"
# (The runtime manager handles waiting, but a pause here is safe visually)
sleep 5

echo -e "${GREEN}>>> Step 3: Running Benchmark (Translation)...${NC}"
# We assume 'translation_en_de_v1' is the benchmark you implemented earlier
runint benchmark \
    --task translation_en_de_v1 \
    --engine ollama \
    --model llama3 \
    --iterations 3

echo -e "${GREEN}>>> Done! Results are saved in ./results/ (configured in your library logic)${NC}"

# Optional: Cleanup
# echo "Cleaning up..."
# docker-compose down