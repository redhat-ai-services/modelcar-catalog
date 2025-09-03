# qwen3-4b

https://huggingface.co/Qwen/Qwen3-4B

quay.io/redhat-ai-services/modelcar-catalog:qwen2.5-7b-instruct

## Building Image

```
podman build modelcar-images/qwen/qwen3-4b \
    -t quay.io/redhat-ai-services/modelcar-catalog:qwen3-4b  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i qwen3-4b redhat-ai-services/vllm-kserve \
    --values modelcar-images/qwen/qwen3-4b/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
