# gemma-7b

https://huggingface.co/google/gemma-7b

quay.io/redhat-ai-services/modelcar-catalog:gemma-7b

## Building Image

This ModelCar build downloads the model locally then copies the files to a container in multiple layers to avoid podman memory issues.

### Downloading model files locally

```
mkdir -p ./modelcar-images/google/gemma-7b/models
podman run --rm --platform linux/amd64 \
    -v ./modelcar-images/google/gemma-7b/models:/models \
    --env-file modelcar-images/google/gemma-7b/downloader.env \
    quay.io/redhat-ai-services/huggingface-downloader:latest
```

### Building the ModelCar Image

```
podman build modelcar-images/google/gemma-7b \
    -t quay.io/redhat-ai-services/modelcar-catalog:gemma-7b  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i gemma-7b redhat-ai-services/vllm-kserve \
    --values modelcar-images/google/gemma-7b/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
