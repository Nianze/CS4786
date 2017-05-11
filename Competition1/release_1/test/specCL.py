import numpy as np
import csv
from sklearn.cluster import spectral_clustering

reader=csv.reader(open("G2.csv","rb"),delimiter=',')
x = list(reader)
result = np.array(x).astype('float')

labels = spectral_clustering(result, n_clusters=7,assign_labels='kmeans')
result = labels.tolist()

with open('labeled-graph.csv','w') as f:
	f.write('index,is_successful'+'\n')

for i in range(1828):
	with open('labeled-graph.csv','a') as f:
		f.write(str(i) + ',' + str(result[i]) + '\n')
		if i == 12 or i == 1419 or i == 865 or i == 146 or i == 1653 or i == 1176:
			print str(i) + ' ' + str(result[i])
