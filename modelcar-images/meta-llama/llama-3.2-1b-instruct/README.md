# Llama-3.2-1B-Instruct

https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct/

quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-1b-instruct

## Building Image

This model requires a user-token to authenticate with HuggingFace before pulling the model.  To generate a token, please refer to the [User access tokens](https://huggingface.co/docs/hub/en/security-tokens) documentation.

Once your token has been created, be sure to accept the terms and conditions for this model on the model home page.

```
export HF_TOKEN="hf_..."
podman build modelcar-images/meta-llama/llama-3.2-1b-instruct \
    -t quay.io/redhat-ai-services/modelcar-catalog:llama-3.2-1b-instruct \
    --build-arg HF_TOKEN=$HF_TOKEN \
    --platform linux/amd64
```

### Known Issues

#### Access to model is restricted

When attempting to download the model, you may get the following error message:

```
Cannot access gated repo for url https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct/resolve/9213176726f574b556790deb65791e0c5aa438b6/config.json.
Access to model meta-llama/Llama-3.2-1B-Instruct is restricted and you are not in the authorized list. Visit https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct to ask for access.
```

You must accept the terms and conditions on the model homepage.
