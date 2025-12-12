# ministral-3-14b-reasoning-2512

https://huggingface.co/mistralai/ministral-3-14b-reasoning-2512

quay.io/redhat-ai-services/modelcar-catalog:ministral-3-14b-reasoning-2512

## Building Image

This ModelCar build downloads the model locally then copies the files to a container in multiple layers to avoid podman memory issues.

### Downloading model files locally

```
mkdir -p ./modelcar-images/mistralai/ministral-3-14b-reasoning-2512/models
podman run --rm --platform linux/amd64 \
    -v ./modelcar-images/mistralai/ministral-3-14b-reasoning-2512/models:/models \
    --env-file modelcar-images/mistralai/ministral-3-14b-reasoning-2512/downloader.env \
    quay.io/redhat-ai-services/huggingface-downloader:latest
```

### Building the ModelCar Image

```
podman build modelcar-images/mistralai/ministral-3-14b-reasoning-2512 \
    -t quay.io/redhat-ai-services/modelcar-catalog:ministral-3-14b-reasoning-2512  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i ministral-3-14b-reasoning-2512 redhat-ai-services/vllm-kserve \
    --values modelcar-images/mistralai/ministral-3-14b-reasoning-2512/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
