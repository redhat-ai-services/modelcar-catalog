# granite-4.0-tiny-preview

https://huggingface.co/ibm-granite/granite-4.0-tiny-preview

quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-tiny-preview

## Building Image

```
podman build modelcar-images/ibm-granite/granite-4.0-tiny-preview \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-tiny-preview  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-40-tiny-preview redhat-ai-services/vllm-kserve \
    --values modelcar-images/ibm-granite/granite-4.0-tiny-preview/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
