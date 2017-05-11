import csv
import numpy as np
from sklearn.cluster import KMeans

with open('W.csv','rb') as f:
    reader = csv.reader(f)
    graph = list(reader)

dscp = np.zeros((1829,30), dtype = np.float)

for i in range(1829):
	for j in range(30):
	    dscp[i][j] = float(graph[i][j])

with open('sample0.csv', 'rb') as f2:
    reader2 = csv.reader(f2)
    sample = list(reader2)

centroid = np.zeros((6,30), dtype = np.float)
for i in range(6):
	centroid[i][:] = dscp[int(sample[i][0])][:]

result = KMeans(n_clusters=6, init=centroid).fit_predict(dscp)

cluster = np.zeros((1829,2), dtype = np.int)
for i in range(1829):
	cluster[i][:] = [i, result[i]]

np.savetxt("kmeans-task1.csv", cluster, fmt='%i', delimiter=",")