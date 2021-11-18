#!/bin/bash
set -e
THIS_SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# To install kaggle cli run 'pip install kaggle'

kaggle competitions download shopee-product-matching --path "$THIS_SCRIPT_DIR/.data"

unzip "$THIS_SCRIPT_DIR/.data/shopee-product-matching.zip" -d "$THIS_SCRIPT_DIR/.data"
