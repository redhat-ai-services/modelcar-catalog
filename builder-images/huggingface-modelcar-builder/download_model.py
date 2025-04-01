import os
from typing import List, Optional

import argparse

from huggingface_hub import snapshot_download

def main(
    model_repo: str,
    local_dir: str = "./models",
    allow_patterns: List[str] = ["*.safetensors", "*.json", "*.txt"],
    token: Optional[str] = None,
):
    print(f"Attempting to download the following model from Hugging Face: {model_repo}")
    print(f"Target directory: {local_dir}")
    print(f"With allow-patterns: {allow_patterns}")
    print(f"Using token: {'Provided' if token else 'Not provided'}")

    snapshot_download(
        repo_id=model_repo,
        local_dir=local_dir,
        allow_patterns=allow_patterns,
        token=token,
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument(
        "-m", "--model-repo", help="(Required) The model repo on Hugging Face", type=str, required=True
    )
    parser.add_argument(
        "-t",
        "--target-dir",
        help="(Optional) The target directory to download the model",
        default="./models",
        type=str,
    )
    parser.add_argument(
        "-a",
        "--allow-patterns",
        help="(Optional) The allowed patterns to download",
        nargs="+",
        default=["*.safetensors", "*.json", "*.txt"],
    )
    parser.add_argument(
        "--token",
        help="(Optional) Hugging Face token for private model access",
        default=None,
        type=str,
    )
    args = parser.parse_args()
    main(
        model_repo=args.model_repo,
        local_dir=args.target_dir,
        allow_patterns=args.allow_patterns,
        token=args.token,
    )
