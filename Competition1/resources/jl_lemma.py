# USAGE
# python jl_lemma.py

# import the necessary packages
from sklearn.random_projection import SparseRandomProjection
from sklearn.svm import LinearSVC
from sklearn.cross_validation import train_test_split
from sklearn import metrics
from sklearn import datasets
import matplotlib.pyplot as plt
import numpy as np

# initialize the list of accuracy and components
accuracies = []
components = np.int32(np.linspace(2, 64, 20))

# load the digits dataset and construct a training and
# testing split
digits = datasets.load_digits()
split = train_test_split(digits.data, digits.target, test_size = 0.3,
	random_state = 42)
(trainData, testData, trainTarget, testTarget) = split

# train a classifier on the original data and evaluate it
model = LinearSVC()
model.fit(trainData, trainTarget)
baseline = metrics.accuracy_score(model.predict(testData), testTarget)

# loop over the projection sizes
for comp in components:
	# create the random projection
	sp = SparseRandomProjection(n_components = comp)
	X = sp.fit_transform(trainData)

	# train a classifier on the sparse random projection
	model = LinearSVC()
	model.fit(X, trainTarget)

	# evaluate the model and update the list of accuracies
	test = sp.transform(testData)
	accuracies.append(metrics.accuracy_score(model.predict(test), testTarget))

# create the figure
plt.figure()
plt.suptitle("Accuracy of Sparse Projection on Digits")
plt.xlabel("# of Components")
plt.ylabel("Accuracy")
plt.xlim([2, 64])
plt.ylim([0, 1.0])

# plot the baseline and random projection accuracies
plt.plot(components, [baseline] * len(accuracies), color = "r")
plt.plot(components, accuracies)

# save the figure
plt.savefig("digits.png")