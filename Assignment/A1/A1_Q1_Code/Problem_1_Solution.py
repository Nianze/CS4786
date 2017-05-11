import numpy as np
from scipy.linalg import eigh
import matplotlib.pyplot as plt

# Load the data
data_dir = 'PATH/TO/DATA/DIRECTORY'
mu = np.loadtxt(data_dir+'/mu.csv', delimiter=',')
W = np.loadtxt(data_dir+'/W.csv', delimiter=',')
Xbad = np.loadtxt(data_dir+'/Xbad.csv', delimiter=',')
Y1 = np.loadtxt(data_dir+'/Y1.csv', delimiter=',')

# Compute the covariance matrix of X with formula: Cov(X) = (X-mu)'*(X-mu)
# Then perform an eigendecomposition on the covariance matrix (takes ~5min to run on my laptop)
Xbad_cov = (Xbad-Xbad.mean(0)).T.dot(Xbad-Xbad.mean(0))
Dbad, Wbad = eigh(Xbad_cov) # eigvals, eigvecs

# Eigenvalues in Dbad (and corresponding eigenvectors in Wbad) are ordered from least to greatest
# We want the largest 20 eigenvectors, ordered from greatest to least
Wbad_sub = Wbad[:,-1:-21:-1]

# Compute Ybad with formula: Y = (X-mu)*W
Ybad = (Xbad-Xbad.mean(0)).dot(Wbad_sub)

# Compare the entries of Y1 with the first row of Ybad
# Keep track of where the signs agree and disagree
sign_vec = np.zeros(20)
for i in range(20):
    if np.sign(Y1[i]) == np.sign(Ybad[0,i]):
        sign_vec[i] = 1
    else:
        sign_vec[i] = -1

# Flip the signs of Ybad to match Y1
Ybad_sign = Ybad*sign_vec

# Compute X with formula: X = Y*W' + mu
X = Ybad_sign.dot(W.T) + mu



# Function for converting vector representation of image into matrix representation
def vec_to_mat(vec):
	img = np.zeros((105,105))
	for x in range(105):
		for y in range(105):
			img[y, x] = vec[x*105 + y]
	return img

# Plot the first 25 reconstructed images
fig, axs = plt.subplots(5,5)
axs = axs.ravel()
for i in range(25):
	img = vec_to_mat(X[i,:])
	axs[i].imshow(img, cmap='gray')
	axs[i].get_xaxis().set_visible(False)
	axs[i].get_yaxis().set_visible(False)
plt.show()

