# Spectral Clustering

This repository implements the **Spectral Clustering** algorithm using the normalized Laplacian approach, based on the eigendecomposition of graph-related matrices derived from a similarity measure between data points.

## 📘 Overview

Spectral Clustering is a technique that performs clustering based on the eigenstructure of a graph constructed from the data. It is particularly effective when the clusters have non-convex shapes or are not linearly separable.

Given a dataset $\{\mathbf{x}_1, \dots, \mathbf{x}_n\} \subset \mathbb{R}^d$, we define a similarity graph $G = (V, E)$, where each node represents a data point and edges encode pairwise similarity.

## 🧠 Mathematical Foundations

### 1. Similarity Matrix $\mathbf{W}$

The symmetric weight matrix $\mathbf{W} \in \mathbb{R}^{n \times n}$ is defined as:

$$
\mathbf{W}_{ij} = \begin{cases} 
\exp\left(-\frac{\|\mathbf{x}_i - \mathbf{x}_j\|^2}{2\sigma^2}\right) & \text{if } \mathbf{x}_j \in \mathcal{N}_k(\mathbf{x}_i) \\
0 & \text{otherwise}
\end{cases}
$$

where $\mathcal{N}_k(\mathbf{x}_i)$ denotes the $k$-nearest neighbors of $\mathbf{x}_i$.

### 2. Degree Matrix $\mathbf{D}$

The degree matrix $\mathbf{D} \in \mathbb{R}^{n \times n}$ is diagonal, with entries:

$$
\mathbf{D}_{ii} = \sum_{j=1}^n \mathbf{W}_{ij}
$$

### 3. Unnormalized Graph Laplacian $\mathbf{L}$

$$
\mathbf{L} = \mathbf{D} - \mathbf{W}
$$

### 4. Normalized Graph Laplacian $\mathbf{L}_{\text{sym}}$

$$
\mathbf{L}_{\text{sym}} = \mathbf{D}^{-1/2} \mathbf{L} \mathbf{D}^{-1/2} = \mathbf{I} - \mathbf{D}^{-1/2} \mathbf{W} \mathbf{D}^{-1/2}
$$

## ⚙️ Algorithm

The steps of the Spectral Clustering algorithm using the normalized Laplacian are:

1. Construct the similarity matrix $\mathbf{W}$ using the Gaussian kernel and $k$-nearest neighbors
2. Compute the degree matrix $\mathbf{D}$ and the normalized Laplacian $\mathbf{L}_{\text{sym}}$
3. Compute the first $k$ eigenvectors $\mathbf{u}_1, \dots, \mathbf{u}_k$ of $\mathbf{L}_{\text{sym}}$ (smallest eigenvalues)
4. Form the matrix $\mathbf{U} \in \mathbb{R}^{n \times k}$ with eigenvectors as columns
5. Normalize each row of $\mathbf{U}$ to have unit norm
6. Apply K-Means to the rows of $\mathbf{U}$ (as points in $\mathbb{R}^k$)
7. Assign original points to clusters based on their embeddings

## 📈 Visualization

Example results are shown below:

![Spectral Clustering Example](figure/3D_Lsym_40.png)

Images and plots generated during experiments are located in the `figures/` directory.