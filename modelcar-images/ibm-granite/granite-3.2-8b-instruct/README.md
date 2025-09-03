# granite-3.2-8b-instruct

https://huggingface.co/ibm-granite/granite-3.2-8b-instruct

quay.io/redhat-ai-services/modelcar-catalog:granite-3.2-8b-instruct

## Building Image

```
podman build modelcar-images/ibm-granite/granite-3.2-8b-instruct \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-3.2-8b-instruct  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-32-8b-instruct redhat-ai-services/vllm-kserve \
    --values modelcar-images/ibm-granite/granite-3.2-8b-instruct/values.yaml \
    --values modelcar-images/granite-3.2-8b-instruct/values-a10g.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
