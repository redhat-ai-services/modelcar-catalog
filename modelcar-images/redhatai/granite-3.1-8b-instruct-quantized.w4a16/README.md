# granite-3.1-8b-instruct-quantized.w4a16

https://huggingface.co/redhatai/granite-3.1-8b-instruct-quantized.w4a16

quay.io/redhat-ai-services/modelcar-catalog:granite-3.1-8b-instruct-quantized.w4a16

https://neuralmagic.com/blog/introducing-compressed-granite-3-1-powerful-performance-in-a-small-package/

## Building Image

```
podman build modelcar-images/redhatai/granite-3.1-8b-instruct-quantized.w4a16 \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-3.1-8b-instruct-quantized.w4a16  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-31-8b-instruct redhat-ai-services/vllm-kserve \
    --values modelcar-images/redhatai/granite-3.1-8b-instruct-quantized.w4a16/values.yaml \
    --values modelcar-images/granite-3.1-8b-instruct-quantized.w4a16/values-a10g.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
