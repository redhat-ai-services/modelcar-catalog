# qwen3.8-27b-nvfp4

https://huggingface.co/RedHatAI/Qwen3.8-27B-NVFP4

quay.io/redhat-ai-services/modelcar-catalog:qwen3.8-27b-nvfp4

## Building Image

This ModelCar build downloads the model locally then copies the files to a container in multiple layers to avoid podman memory issues.

### Downloading model files locally

```
mkdir -p ./modelcar-images/redhatai/qwen3.8-27b-nvfp4/models
podman run --rm --platform linux/amd64 \
    -v ./modelcar-images/redhatai/qwen3.8-27b-nvfp4/models:/models \
    --env-file modelcar-images/redhatai/qwen3.8-27b-nvfp4/downloader.env \
    quay.io/redhat-ai-services/huggingface-downloader:latest
```

### Building the ModelCar Image

```
podman build modelcar-images/redhatai/qwen3.8-27b-nvfp4 \
    -t quay.io/redhat-ai-services/modelcar-catalog:qwen3.8-27b-nvfp4  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i qwen38-27b-nvfp4 redhat-ai-services/vllm-kserve \
    --values modelcar-images/redhatai/qwen3.8-27b-nvfp4/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
