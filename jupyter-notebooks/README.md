# 'Real-life' examples

Here we present some examples of solving problems similar to real ones using vector spaces and Vektonn.

## Use cases

1. [Hotels](hotels/hotels.ipynb).
Task: save the user's time while searching for hotels. 
This example uses vectorized user reviews to find hotels.

1. [Price Match Guarantee](cv/cv.ipynb).
Task: help the seller establish a competitive price for their product on the marketplace.

1. [Books](sparse-vectors/sparse-vectors.ipynb).
Task: find similar books by user reviews. This example demonstrates usage of sparse vectors.


## Prerequisites

To run notebooks presented in this repository locally you will need to install:
* [Docker](https://docs.docker.com/get-docker/)
* [Python >= 3.7](https://www.python.org/downloads/)
* [Jupyter Notebook](https://jupyter.readthedocs.io/en/latest/install/notebook-classic.html)

To download datasets for provided examples you will need to register account on [Kaggle](https://www.kaggle.com/),
install [Kaggle CLI](https://github.com/Kaggle/kaggle-api), and
[prepare authentication token](https://www.kaggle.com/docs/api#getting-started-installation-&-authentication) to use its API.


## To run example notebooks

1. Clone this repository into `/path/to/vektonn-examples` dir:
```bash
git clone https://github.com/vektonn/vektonn-examples.git /path/to/vektonn-examples
```

2. Run Jupyter Notebook from that directory:
```bash
jupyter notebook --notebook-dir=/path/to/vektonn-examples
```

3. Select notebook to run (e.g. `jupyter-notebooks/hotels/hotels.ipynb`).

4. Download necessary dataset for selected notebook:
```bash
/path/to/vektonn-examples/jupyter-notebooks/hotels/download-dataset.sh
```

5. Run selected notebook using Jupyter Notebook GUI.
