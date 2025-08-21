# granite-3.3-8b-instruct and granite-3.0-8b-instruct-accelerated

This modelcar image contains the following models:

https://huggingface.co/ibm-granite/granite-3.3-8b-instruct

https://huggingface.co/ibm-granite/granite-3.0-8b-instruct-accelerated

This modelcar image is intended to be utilized with vLLMs speculative decoding feature.

quay.io/redhat-ai-services/modelcar-catalog:granite-3.3-8b-instruct-accelerated

## Building Image

```
podman build modelcar-images/granite-3.3-8b-instruct \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-3.3-8b-instruct-accelerated  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-33-8b-instruct-accelerated redhat-ai-services/vllm-kserve \
    --values modelcar-images/granite-3.3-8b-instruct-accelerated/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
