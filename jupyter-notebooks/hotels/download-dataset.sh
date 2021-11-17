#!/bin/bash
set -e
THIS_SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# To install kaggle cli run 'pip install kaggle'

kaggle datasets download jiashenliu/515k-hotel-reviews-data-in-europe --unzip --path "$THIS_SCRIPT_DIR/.data"
