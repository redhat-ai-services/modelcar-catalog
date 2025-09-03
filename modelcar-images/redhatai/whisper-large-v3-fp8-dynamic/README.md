# whisper-large-v3-fp8-dynamic

https://huggingface.co/openai/whisper-large-v3-fp8-dynamic

quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v3-fp8-dynamic

## Building Image

```
podman build modelcar-images/redhatai/whisper-large-v3-fp8-dynamic \
    -t quay.io/redhat-ai-services/modelcar-catalog:whisper-large-v3-fp8-dynamic  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i whisper-large-v3-fp8-dynamic redhat-ai-services/vllm-kserve \
    --values modelcar-images/redhatai/whisper-large-v3-fp8-dynamic/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
