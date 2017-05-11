import csv
import numpy as np
from hmmlearn.hmm import MultinomialHMM

def wrap(x):
	return int(x)-1

with open('fillindata.csv','rb') as f:
    reader = csv.reader(f)
    sequence = list(reader)

with open('test.csv','w') as f:
	f.write('Line,Prediction'+'\n')

X = []
length = []
for i in range(100):
	X.append(map(wrap,sequence[i]))
	# length.append(len(sequence[i]))

# Make an HMM instance and execute fit
model = MultinomialHMM(n_components=8,n_iter=1000).fit(X)

ones = 0
for i in range(100,len(sequence)):
	seq = sequence[i]
	idx = seq.index("*")
	ascTests = []
	descTests = []
	for sym in range(1,6):
		seq[idx] = str(sym)
		seqInt = map(wrap,seq)
		ascTests.append(model.score(seqInt))
		descTests.append(model.score(seqInt[::-1]))
	Tests = ascTests + descTests
	index = Tests.index(max(Tests))
	if index >= 5:
		index -= 5
	symbol = index + 1
	if symbol == 1:
		ones += 1
	with open('test.csv','a') as f:
		f.write(str(i+1) + ',' + str(symbol) + '\n')

print model.monitor_
# print model.transmat_
# print model.startprob_
# print model.emissionprob_

print('1\'s base line: ' + str(ones/900.0))