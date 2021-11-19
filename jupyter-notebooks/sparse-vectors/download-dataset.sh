#!/bin/bash
set -e
THIS_SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# To install kaggle cli run 'pip install kaggle'

kaggle datasets download zygmunt/goodbooks-10k --unzip --path "$THIS_SCRIPT_DIR/.data"
