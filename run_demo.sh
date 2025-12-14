#!/bin/bash
set -e

# 1. Colors
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}>>> Step 1: Deploying Environment...${NC}"
runint deploy --config configs/local_ollama.json

echo -e "${GREEN}>>> Step 2: Waiting for Ollama to be healthy...${NC}"
sleep 5

echo -e "${GREEN}>>> Step 2.5: Pulling Model (llama3)...${NC}"

echo "Downloading model... this might take a while depending on your internet."
docker exec runint-playground-ollama-1 ollama pull llama3

echo -e "${GREEN}>>> Step 3: Running Benchmark (Translation)...${NC}"
runint benchmark \
    --task translation_en_de_v1 \
    --engine ollama \
    --url http://localhost:11434 \
    --model llama3 \
    --iterations 3

echo -e "${GREEN}>>> Done! Results are saved in ./results/${NC}"
