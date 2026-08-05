# Modelcar Image Repository Rules

## Purpose

This repository contains Modelcar image definitions. When asked to add support for a new model, always follow the existing repository conventions instead of inventing new structures.

## Check for existing models

When the user reqeusts a new model, first check if the model is available on https://huggingface.co/RedHatAI and if there is an OCI or modelcar image listed there already.

For example, if the user asks you to add meta-llama/Llama-3.3-70B-Instruct you can find the following model on the RedHatAI models:

https://huggingface.co/RedHatAI/Llama-3.3-70B-Instruct

On that page, you will find the following modelcar image:
oci://registry.redhat.io/rhelai1/modelcar-llama-3-3-70b-instruct:1.5

If a modelcar image is available, provide that URL to the user and recommend that they use it.  Give them them option to continue to add the model anyways if they wish to.

If no image is found, proceed with setting up the new model.

---

## Adding a New Model

When the user requests a new model (for example `/ibm-granite/granite-4.1-8b`):

1. Parse the namespace and model name.

   * Namespace: `ibm-granite`
   * Model: `granite-4.1-8b`

2. Create the model under:

```
modelcar-images/<namespace>/<model-name>
```

Example:

```
modelcar-images/ibm-granite/granite-4.1-8b
```

---

## Selecting the Correct Reference

Always use an existing model in this repository as the template.

### Models smaller than 8B parameters

Use:

```
modelcar-images/ibm-granite/granite-3.3-2b-instruct
```

as the reference implementation.

Replicate its folder layout, file naming, formatting, and conventions. Only change values that are specific to the new model.

---

### Models 8B parameters or larger

Use:

```
modelcar-images/qwen/qwen3-14b
```

as the reference implementation.

Replicate its directory structure, manifests, scripts, metadata, and formatting. Modify only the values required for the requested model.

Run the `make download` script to download the model files in order to properly setup the Containerfile.

---

## Preserve Repository Conventions

Do not invent new file layouts.

Match:

* directory structure
* filenames
* YAML formatting
* comments
* indentation
* metadata ordering
* Makefile expectations
* naming conventions

If the reference contains generated values that should change for the new model, update them appropriately while preserving formatting.

---

## Update Documentation

After adding a new model:

1. Update the root `README.md`.
2. Add the new model wherever models are listed.
3. Keep the list sorted if the README is already sorted.
4. Match the existing formatting exactly.

Never add a new model without updating the README.

---

## Final Response

After making all repository changes, always provide the build command using the newly created folder.

Format:

```bash
make build-and-push folder=modelcar-images/<namespace>/<model-name>
```

Example:

```bash
make build-and-push folder=modelcar-images/ibm-granite/granite-4.1-8b
```

---

## Checklist

Before finishing, verify:

* [ ] Existing modelcar image is not found on https://huggingface.co/RedHatAI/
* [ ] Correct namespace folder used.
* [ ] Correct model folder created.
* [ ] Appropriate reference template selected based on parameter size.
* [ ] Repository conventions preserved.
* [ ] Root `README.md` updated.
* [ ] Build command included in the final response.
