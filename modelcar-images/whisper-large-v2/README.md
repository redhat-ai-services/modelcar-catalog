# whisper-large-v2

https://huggingface.co/openai/whisper-large-v2

quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v2

## Building Image

```
podman build modelcar-images/whisper-large-v2 \
    -t quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v2  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i whisper-large-v2 redhat-ai-services/vllm-kserve \
    --values modelcar-images/whisper-large-v2/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
