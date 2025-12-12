# ministral-3-3b-instruct-2512

https://huggingface.co/mistralai/ministral-3-3b-instruct-2512

quay.io/redhat-ai-services/modelcar-catalog:ministral-3-3b-instruct-2512

## Building Image

This model requires a user-token to authenticate with HuggingFace before pulling the model.  To generate a token, please refer to the [User access tokens](https://huggingface.co/docs/hub/en/security-tokens) documentation.

Once your token has been created, be sure to accept the terms and conditions for this model on the model home page.

```
export HF_TOKEN="hf_..."
podman build modelcar-images/mistralai/ministral-3-3b-instruct-2512 \
    -t quay.io/redhat-ai-services/modelcar-catalog:ministral-3-3b-instruct-2512 \
    --build-arg HF_TOKEN=$HF_TOKEN \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i ministral-3-3b-instruct-2512 redhat-ai-services/vllm-kserve \
    --values modelcar-images/mistralai/ministral-3-3b-instruct-2512/values.yaml
```

## Known Issues

### Access to model is restricted

When attempting to download the model, you may get the following error message:

```
Cannot access gated repo for url https://huggingface.co/mistralai/ministral-3-3b-instruct-2512/resolve/.../config.json.
Access to model mistralai/ministral-3-3b-instruct-2512 is restricted and you are not in the authorized list. Visit https://huggingface.co/mistralai/ministral-3-3b-instruct-2512 to ask for access.
```

You must accept the terms and conditions on the model homepage.
