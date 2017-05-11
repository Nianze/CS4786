import csv
import numpy as np
from sklearn.cluster import KMeans

with open('description.csv','rb') as f:
    reader = csv.reader(f)
    graph = list(reader)

dscp = np.zeros((1829,8000), dtype = np.float)

for val in graph:
    dscp[int(val[0])][int(val[1])] = float(val[2])

with open('category_partial_supervision.csv', 'rb') as f2:
    reader2 = csv.reader(f2)
    sample = list(reader2)

centroid = np.zeros((13,8000), dtype = np.float)
for i in range(13):
	s = np.zeros((3,8000),dtype = np.float)
	s[0][:] = dscp[int(sample[3*i][0])][:]
	s[1][:] = dscp[int(sample[3*i+1][0])][:]
	s[2][:] = dscp[int(sample[3*i+2][0])][:]
	centroid[i][:] = s.mean(axis=0)

result = KMeans(n_clusters=13, init=centroid).fit_predict(dscp)

# cluster = np.zeros((1829,2), dtype = np.int)
# for i in range(1829):
# 	cluster[i][:] = [i, result[i]]

# np.savetxt("task2.csv", cluster, fmt='%i', delimiter=",")


import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from mpl_toolkits.mplot3d import Axes3D

pca = PCA(n_components=13)
pca.fit(dscp)
drawData = pca.transform(dscp)

X = drawData
y = result

groupCount = [] # count for each cluster
for i in range(13):
	groupCount.append(sum(result==i))
origDraw = pca.transform(centroid)
origColor = range(13)

fignum = 1
fig = plt.figure(fignum, figsize=(4,3))
plt.clf()

ax = Axes3D(fig,rect=[0,0,.95,1],elev=48,azim=134)

plt.cla()

#plot the origin centroid
ax.scatter(origDraw[:,0],origDraw[:,1],origDraw[:,2], c=origColor, s=groupCount,marker='^')

# y = np.choose(y, [1, 2, 0]).astype(np.float)
ax.scatter(X[:,0],X[:,1],X[:,2], c = y)

ax.w_xaxis.set_ticklabels([])
ax.w_yaxis.set_ticklabels([])
ax.w_zaxis.set_ticklabels([])
ax.set_xlabel('Petal width')
ax.set_ylabel('Sepal length')
ax.set_zlabel('Petal length')
plt.show()