# modelcar-catalog

[![GitHub](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/redhat-ai-services/modelcar-catalog) [![Quay.io](https://img.shields.io/badge/Quay.io-image-blue.svg)](https://quay.io/repository/redhat-ai-services/modelcar-catalog)

The modelcar-catalog repo is designed to provide patterns for building ModelCar images for commonly used LLMs.  Be sure to check out the [modelcar-catalog registry](https://quay.io/repository/redhat-ai-services/modelcar-catalog) to find many of these images pre-built and ready to use.

## huggingface-downloader

The `huggingface-downloader` is a helper container designed to make it easier to pull models from huggingface to build a modelcar container.

quay.io/redhat-ai-services/huggingface-downloader:latest

## Using the Makefile

The project includes a Makefile that simplifies building, downloading, and pushing ModelCar images. Below are the available targets and their usage.

### Prerequisites

- `podman` installed and configured
- Access to `quay.io/redhat-ai-services` registry for pushing (optional)
- HuggingFace token for private models (optional)

### Available Targets

#### Build a Model Image

Build a ModelCar image for a specific model:

```bash
make build folder=modelcar-images/<organization>/<model-name>
```

Example:
```bash
make build folder=modelcar-images/ibm-granite/granite-3.1-8b-instruct
```

If the model directory contains a `downloader.env` file, the build process will automatically download the model first.  Alternatively, models that use a two stage build process will download and build the model in a single shot.

#### Download Model Files

Download model files locally without building the image:

```bash
make download folder=modelcar-images/<organization>/<model-name>
```

This requires a `downloader.env` file in the model directory specifying the `MODEL_REPO`.

#### Add Date Tag

Add a timestamped tag to an existing image:

```bash
make date-tag folder=modelcar-images/<organization>/<model-name>
```

This creates a tag like `model-name-20240815t1234z` alongside the base tag.

#### Push Images

Push all tags for a model to the registry:

```bash
make push folder=modelcar-images/<organization>/<model-name>
```

This pushes both the base tag and any date-tagged versions.

#### Build and Push

Build and push a model in one command:

```bash
make build-and-push folder=modelcar-images/<organization>/<model-name>
```

#### Build and Push All Models

Build and push all models in the catalog:

```bash
make build-and-push-all
```

**Warning:** This processes all models and can take a very long time.

### Using HuggingFace Token

For private models or to avoid rate limiting, set the `HF_TOKEN` environment variable:

```bash
export HF_TOKEN=your_token_here
make build folder=modelcar-images/<organization>/<model-name>
```

The token will be passed to both the download and build processes.

### Clean Up

Remove all downloaded model files:
```bash
make clean-all
```

Remove a specific image and prune containers:
```bash
make prune folder=modelcar-images/<organization>/<model-name>
```

## Available Models

The following models are currently available in the modelcar catalog.

### granite-3.0-2b-instruct

https://huggingface.co/ibm-granite/granite-3.0-2b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.0-2b-instruct

### granite-3.0-8b-instruct

https://huggingface.co/ibm-granite/granite-3.0-8b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.0-8b-instruct

### granite-3.1-2b-instruct

https://huggingface.co/ibm-granite/granite-3.1-2b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.1-2b-instruct

### granite-3.1-8b-instruct

https://huggingface.co/ibm-granite/granite-3.1-8b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.1-8b-instruct

### granite-3.1-8b-instruct-quantized.w4a16

https://huggingface.co/redhatai/granite-3.1-8b-instruct-quantized.w4a16

quay.io/redhat-ai-services/modelcar-catalog:granite-3.1-8b-instruct-quantized.w4a16

### granite-3.1-8b-instruct-quantized.w8a8

https://huggingface.co/redhatai/granite-3.1-8b-instruct-quantized.w8a8

quay.io/redhat-ai-services/modelcar-catalog:granite-3.1-8b-instruct-quantized.w8a8

### granite-3.2-2b-instruct

https://huggingface.co/ibm-granite/granite-3.2-2b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.2-2b-instruct

### granite-3.2-8b-instruct

https://huggingface.co/ibm-granite/granite-3.2-8b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.2-8b-instruct

### granite-3.3-2b-instruct

https://huggingface.co/ibm-granite/granite-3.3-2b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.3-2b-instruct

### granite-3.3-8b-instruct

https://huggingface.co/ibm-granite/granite-3.3-8b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.3-8b-instruct

### granite-4.0-tiny-preview

https://huggingface.co/ibm-granite/granite-4.0-tiny-preview

quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-tiny-preview

### granite-4.0-h-small

https://huggingface.co/ibm-granite/granite-4.0-h-small

quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-h-small

### granite-4.0-h-tiny

https://huggingface.co/ibm-granite/granite-4.0-h-tiny

quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-h-tiny

### granite-4.0-h-micro

https://huggingface.co/ibm-granite/granite-4.0-h-micro

quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-h-micro

### granite-4.1-3b

https://huggingface.co/ibm-granite/granite-4.1-3b

quay.io/redhat-ai-services/modelcar-catalog:granite-4.1-3b

### granite-4.1-8b

https://huggingface.co/ibm-granite/granite-4.1-8b

quay.io/redhat-ai-services/modelcar-catalog:granite-4.1-8b

### granite-4.1-30b

https://huggingface.co/ibm-granite/granite-4.1-30b

quay.io/redhat-ai-services/modelcar-catalog:granite-4.1-30b

### granite-embedding-english-r2

https://huggingface.co/ibm-granite/granite-embedding-english-r2

quay.io/redhat-ai-services/modelcar-catalog:granite-embedding-english-r2

### granite-guardian-3.2-5b

https://huggingface.co/ibm-granite/granite-guardian-3.2-5b

quay.io/redhat-ai-services/modelcar-catalog:granite-guardian-3.2-5b

### granite-guardian-3.3-8b

https://huggingface.co/ibm-granite/granite-guardian-3.3-8b

quay.io/redhat-ai-services/modelcar-catalog:granite-guardian-3.3-8b

### gemma-7b

https://huggingface.co/google/gemma-7b

quay.io/redhat-ai-services/modelcar-catalog:gemma-7b

### llama-3.1-8b-instruct

https://huggingface.co/meta-llama/Llama-3.1-8B-Instruct

quay.io/redhat-ai-services/modelcar-catalog:llama-3.1-8b-instruct

### llama-3.2-1b-instruct

https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-1b-instruct

### llama-3.2-3b-instruct

https://huggingface.co/meta-llama/Llama-3.2-3B-Instruct

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-3b-instruct

### llama-3.2-3b-instruct-quantized.w8a8

https://huggingface.co/redhatai/Llama-3.2-3B-Instruct-quantized.w8a8

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-3b-instruct-quantized.w8a8

### llama-3.2-8b-instruct-quantized.w4a16

https://huggingface.co/redhatai/Llama-3.2-8B-Instruct-quantized.w4a16

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-8b-instruct-quantized.w4a16

### llama-3.2-11b-vision-instruct

https://huggingface.co/meta-llama/Llama-3.2-11B-Vision-Instruct

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-11b-vision-instruct

### llama-3.2-11b-vision-instruct-fp8-dynamic

https://huggingface.co/redhatai/Llama-3.2-11B-Vision-Instruct-FP8-dynamic

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-11b-vision-instruct-fp8-dynamic

### mistral-7b-instruct-v0.3

https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.3

quay.io/redhat-ai-services/modelcar-catalog:mistral-7b-instruct-v0.3

### qwen2.5-0.5b-instruct

https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct

quay.io/redhat-ai-services/modelcar-catalog:qwen2.5-0.5b-instruct

### qwen2.5-7b-instruct

https://huggingface.co/Qwen/Qwen2.5-7B-Instruct

quay.io/redhat-ai-services/modelcar-catalog:qwen2.5-7b-instruct

### qwen3-4b

https://huggingface.co/Qwen/Qwen3-4B

quay.io/redhat-ai-services/modelcar-catalog:qwen3-4b

### qwen3-8b

https://huggingface.co/Qwen/Qwen3-8B

quay.io/redhat-ai-services/modelcar-catalog:qwen3-8b

### qwen3-14b

https://huggingface.co/Qwen/Qwen3-14B

quay.io/redhat-ai-services/modelcar-catalog:qwen3-14b

### sparse-llama-3.1-8b-2of4

https://huggingface.co/ibm-granite/sparse-llama-3.1-8b-2of4

quay.io/redhat-ai-services/modelcar-catalog:sparse-llama-3.1-8b-2of4

### tinyllama-1.1b-chat-v1.0

https://huggingface.co/TinyLlama/TinyLlama-1.1B-Chat-v1.0

quay.io/redhat-ai-services/modelcar-catalog:tinyllama-1.1b-chat-v1.0

### whisper-large-v2

https://huggingface.co/openai/whisper-large-v2

quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v2

### whisper-large-v2-w4a16-g128

https://huggingface.co/RedHatAI/whisper-large-v2-W4A16-G128

quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v2-w4a16-g128

### whisper-large-v3

https://huggingface.co/openai/whisper-large-v3

quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v3

### whisper-large-v3-fp8-dynamic

https://huggingface.co/redhatai/whisper-large-v3-FP8-dynamic

quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v3-fp8-dynamic
