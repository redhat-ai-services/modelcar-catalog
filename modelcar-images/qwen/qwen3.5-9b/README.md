# qwen3.5-9b

https://huggingface.co/Qwen/Qwen3.5-9B

quay.io/redhat-ai-services/modelcar-catalog:qwen3.5-9b

## Building Image

This ModelCar build downloads the model locally then copies the files to a container in multiple layers to avoid podman memory issues.

### Downloading model files locally

```
mkdir -p ./modelcar-images/qwen/qwen3.5-9b/models
podman run --rm --platform linux/amd64 \
    -v ./modelcar-images/qwen/qwen3.5-9b/models:/models \
    --env-file modelcar-images/qwen/qwen3.5-9b/downloader.env \
    quay.io/redhat-ai-services/huggingface-downloader:latest
```

### Building the ModelCar Image

```
podman build modelcar-images/qwen/qwen3.5-9b \
    -t quay.io/redhat-ai-services/modelcar-catalog:qwen3.5-9b  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i qwen35-9b redhat-ai-services/vllm-kserve \
    --values modelcar-images/qwen/qwen3.5-9b/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
