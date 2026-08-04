# granite-vision-3.3-2b

https://huggingface.co/ibm-granite/granite-vision-3.3-2b

quay.io/redhat-ai-services/modelcar-catalog:granite-vision-3.3-2b

## Building Image

```
podman build modelcar-images/ibm-granite/granite-vision-3.3-2b \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-vision-3.3-2b  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-vision-33-2b redhat-ai-services/vllm-kserve \
    --values modelcar-images/ibm-granite/granite-vision-3.3-2b/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
