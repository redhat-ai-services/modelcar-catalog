# huggingface-downloader

[![GitHub](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/redhat-ai-services/modelcar-catalog/tree/main/huggingface-downloader) [![Quay.io](https://img.shields.io/badge/Quay.io-image-blue.svg)](https://quay.io/repository/redhat-ai-services/huggingface-downloader)

## download_model

The download_model script contains the following options:

```
python download_model.py -h
usage: download_model.py [-h] [-m MODEL_REPO] [-t TARGET_DIR] [-a ALLOW_PATTERNS [ALLOW_PATTERNS ...]]

options:
  -h, --help            show this help message and exit
  -m MODEL_REPO, --model-repo MODEL_REPO
                        (Required) The model repo on huggingface (default: None)
  -t TARGET_DIR, --target-dir TARGET_DIR
                        (Optional) The target directory to download the model (default: ./models)
  -a ALLOW_PATTERNS [ALLOW_PATTERNS ...], --allow-patterns ALLOW_PATTERNS [ALLOW_PATTERNS ...]
                        (Optional) The allowed patterns to download (default: ['*.safetensors', '*.json', '*.txt'])
```

You must provide a `MODEL_REPO` but `TARGET_DIR` and `ALLOW_PATTERNS` are optional.

By default `ALLOW_PATTERNS` uses the following filters:

```python
["*.safetensors", "*.json", "*.txt"]
```

You can optionally update those filters for what the model you are attempting to download requires.  Check the home page for the model you are attempting to download for recommendations.

## Build Example

```
FROM quay.io/redhat-ai-services/huggingface-downloader:latest as base

# Set the HF_TOKEN with --build-arg HF_TOKEN="hf_..." at build time
ARG HF_TOKEN

# The model repo to download
ENV MODEL_REPO="mistralai/Mistral-7B-Instruct-v0.3"

# Download the necessary model files
RUN python3 download_model.py --model-repo ${MODEL_REPO} \
    --allow-patterns "params.json" "consolidated.safetensors" "tokenizer.model.v3"

# Final image containing only the essential model files
FROM registry.access.redhat.com/ubi9/ubi-micro:9.8

COPY --from=base /models /models

USER 1001
```
