# llama-3.3-70b-instruct

https://huggingface.co/meta-llama/llama-3.3-70b-instruct

quay.io/redhat-ai-services/modelcar-catalog:llama-3.3-70b-instruct

## Building Image

This ModelCar build downloads the model locally then copies the files to a container in multiple layers to avoid podman memory issues.

### Downloading model files locally

```
mkdir -p ./modelcar-images/meta-llama/llama-3.3-70b-instruct/models
podman run --rm --platform linux/amd64 \
    -v ./modelcar-images/meta-llama/llama-3.3-70b-instruct/models:/models \
    --env-file modelcar-images/meta-llama/llama-3.3-70b-instruct/downloader.env \
    quay.io/redhat-ai-services/huggingface-downloader:latest
```

### Building the ModelCar Image

```
podman build modelcar-images/meta-llama/llama-3.3-70b-instruct \
    -t quay.io/redhat-ai-services/modelcar-catalog:llama-3.3-70b-instruct  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i llama-3.3-70b-instruct redhat-ai-services/vllm-kserve \
    --values modelcar-images/meta-llama/llama-3.3-70b-instruct/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
