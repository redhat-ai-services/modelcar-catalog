# qwen3-32b-quantized.w4a16

https://huggingface.co/RedHatAI/Qwen3-32B-quantized.w4a16

quay.io/redhat-ai-services/modelcar-catalog:qwen3-32b-quantized.w4a16

## Building Image

```
podman build modelcar-images/qwen3-32b-quantized.w4a16 \
    -t quay.io/redhat-ai-services/modelcar-catalog:qwen3-32b-quantized.w4a16  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i qwen3-32b-w4a16 redhat-ai-services/vllm-kserve \
    --values modelcar-images/qwen3-32b-quantized.w4a16/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
