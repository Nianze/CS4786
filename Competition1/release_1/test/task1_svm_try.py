import csv
import numpy as np
from sets import Set
from sklearn import svm
from sklearn.cross_decomposition import CCA

with open('graph.csv', 'rb') as f:
	reader = csv.reader(f)
	graph = list(reader)

# index: startup id, corresponding array: list of backer
dic = []
for i in range(1829):
	dic.append([])

# key: backer id, value: array of startup id
inv = {}
for val in graph:
	dic[int(val[0])].append(val[1])
	if inv.has_key(val[1]):
		inv[val[1]].append(int(val[0]))
	else:
		inv[val[1]] = [int(val[0])]

# co_backer = np.zeros((1829, 1829), dtype=np.float)
# co_no_backer = np.zeros((1829,1829), dtype=np.float)
# normalized_backer = np.zeros((1829,1829), dtype=np.float)

# allbacker = Set(range(146983197))
# for i in range(1829):
# 	set1 = Set(dic[i])
# 	co_backer[i][i] = 1.0	
# 	for j in dic[i]:
# 		for k in inv[j]:
# 			if i != k:
# 				co_backer[i][k] += 1.0
				# if co_no_backer[i][k] == 0.0:
				# 	set2 = Set(dic[k])
				# 	set3 = set1 | set2
				# 	co_no_backer[i][k] = len(allbacker - set3)

# apply kernel to transform similarity matrix
#normalized_backer = (co_backer + co_no_backer) / 146983197.0

# np.savetxt("G2.csv", normalized_backer, fmt='%f', delimiter=",")

# total backer # for each project
allbacker = np.zeros((1829,2), dtype=np.int)
# # of backers that only fund this projet for each project
fanbacker = np.zeros((1829,2), dtype=np.int)
# total # of projects that share the backer for each project
similarProj = np.zeros((1829,2), dtype=np.int)

for i in range(1829):
	allbacker[i][:] = [i,len(dic[i])]
	fanbacker[i][0] = i
	similarProj[i][0] = i
	for j in dic[i]: 
		if len(inv[j]) == 1:
			fanbacker[i][1] += 1
		else:
			similarProj[i][1] += (len(inv[j]) - 1)

# np.savetxt("1.allBacker.csv", allbacker, fmt='%i', delimiter=",")
# np.savetxt("2.exclusiveBacker.csv", fanbacker, fmt='%i', delimiter=",")
# np.savetxt("3.similarProj.csv", similarProj, fmt='%i', delimiter=",")

backer = np.zeros((1829,3),dtype=np.int)
for i in range(1829):
	backer[i][0] = allbacker[i][1]
	backer[i][1] = fanbacker[i][1]
	backer[i][2] = similarProj[i][1]

with open('social_and_evolution.csv', 'rb') as f:
	reader3 = csv.reader(f)
	tweet = list(reader3)

with open('sample0.csv', 'rb') as f:
	reader4 = csv.reader(f)
	sampleList = list(reader4)

sampleID = [12,1419,865,146,1653,1176]
label = [1,1,1,0,0,0]
# for s in sampleList:
# 	sampleID.append(int(s[0]))
# 	label.append(int(s[1]))

# cca = CCA(n_components=1)
# cca.fit(backer,tweet)
#backer,tweet = cca.transform(backer,tweet)

sample = []
for i in range(len(sampleID)):
	temp = backer[sampleID[i]].tolist()+tweet[sampleID[i]]
	sample.append(temp)

# learn
clf = svm.SVC(kernel = 'linear')
clf.fit(sample,label)

# predict
output = np.zeros((1829,1), dtype=np.int)
for i in range(1829):
	temp = backer[i].tolist() + tweet[i]
	output[i] = clf.predict(temp)[0]

# output
counter = 0
with open('svm.csv','w') as f:
	f.write('index,is_successful'+'\n')
for i in range(1829):
	with open('svm.csv','a') as f:
		f.write(str(i) + ',' + str(output[i][0]) + '\n')
		if output[i][0] == 1:
			counter += 1
print 'statistics for total 1 number' + str(counter)



