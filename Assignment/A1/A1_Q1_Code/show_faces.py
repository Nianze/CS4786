import numpy as np
import matplotlib.pyplot as plt

data_dir = 'PATH/TO/OUTPUT/FILE/DIRECTORY'
myX = np.loadtxt(data_dir+'/X.csv', delimiter=',')

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
	img = vec_to_mat(myX[i,:])
	axs[i].imshow(img, cmap='gray')
	axs[i].get_xaxis().set_visible(False)
	axs[i].get_yaxis().set_visible(False)
plt.show()