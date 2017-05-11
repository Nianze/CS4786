import csv
import numpy as np

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

co_backer = np.zeros((1829, 1829), dtype=np.float)

for i in range(1829):
	co_backer[i][i] = 1.0	
	for j in dic[i]:
		for k in inv[j]:
			if i != k:
				co_backer[i][k] += 1.0

np.savetxt("co_backer.csv", co_backer, fmt='%i', delimiter=",")

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

np.savetxt("all_backer.csv", allbacker, fmt='%i', delimiter=",")
np.savetxt("first_time_backer.csv", fanbacker, fmt='%i', delimiter=",")
np.savetxt("shared_backer_proj.csv", similarProj, fmt='%i', delimiter=",")
