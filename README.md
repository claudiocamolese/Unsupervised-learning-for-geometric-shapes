# Spectral Clustering

This repository implements the **Spectral Clustering** algorithm using the normalized Laplacian approach, based on the eigendecomposition of graph-related matrices derived from a similarity measure between data points.

## 📘 Overview

Spectral Clustering is a technique that performs clustering based on the eigenstructure of a graph constructed from the data. It is particularly effective when the clusters have non-convex shapes or are not linearly separable.

Given a dataset $\{ \mathbf{x}_1, \dots, \mathbf{x}_n \} \subset \mathbb{R}^d$, we define a similarity graph $G = (V, E)$, where each node represents a data point and edges encode pairwise similarity.

---

## 🧠 Mathematical Foundations

### 1. Similarity Matrix $\mathbf{W}$

The symmetric weight matrix $\mathbf{W} \in \mathbb{R}^{n \times n}$ is defined as:

$$
\mathbf{W}_{ij} = \exp\left( -\frac{\|\mathbf{x}_i - \mathbf{x}_j\|^2}{2\sigma^2} \right) \quad \text{if } \mathbf{x}_j \in \mathcal{N}_k(\mathbf{x}_i)
$$

and $\mathbf{W}_{ij} = 0$ otherwise, where $\mathcal{N}_k(\mathbf{x}_i)$ denotes the $k$-nearest neighbors of $\mathbf{x}_i$.

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

---

## ⚙️ Algorithm

The steps of the Spectral Clustering algorithm using the normalized Laplacian are as follows:

1. Construct the similarity matrix $\mathbf{W}$ using the Gaussian kernel and $k$-nearest neighbors.
2. Compute the degree matrix $\mathbf{D}$ and the normalized Laplacian $\mathbf{L}_{\text{sym}}$.
3. Compute the first $k$ eigenvectors$\mathbf{u}_{1}, \dots, \mathbf{u}_k$ of $\mathbf{L}_{\text{sym}}$ corresponding to the smallest eigenvalues.
4. Form the matrix $\mathbf{U} \in \mathbb{R}^{n \times k}$ where the columns are the eigenvectors.
5. Normalize each row of $\mathbf{U}$ to have unit norm.
6. Treat each row of $\mathbf{U}$ as a point in $\mathbb{R}^k$ and apply K-Means to cluster the points.
7. Assign the original data points to the cluster corresponding to their embedding.

---

## 📈 Visualization

Images and plots generated during experiments are located in the `figures/` directory.

To include an image in Markdown:

```markdown
![Spectral Clustering Example](figures\3D_.Lsym_40.png)
