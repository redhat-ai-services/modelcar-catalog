# qwen3-32b-fp8-dynamic

https://huggingface.co/RedHatAI/Qwen3-32B-FP8-dynamic

quay.io/redhat-ai-services/modelcar-catalog:qwen3-32b-fp8-dynamic

## Building Image

```
podman build modelcar-images/qwen3-32b-fp8-dynamic \
    -t quay.io/redhat-ai-services/modelcar-catalog:qwen3-32b-fp8-dynamic  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i qwen3-32b-fp8-dynamic redhat-ai-services/vllm-kserve \
    --values modelcar-images/qwen3-32b-fp8-dynamic/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
