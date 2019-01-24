import os
import numpy as np

fPath = '.\data\img'
files = os.listdir(fPath)
print(type(files))
fLen = len(files)
cnt = fLen
# ar = np.arange(0,fLen,1)
# np.random.shuffle(ar)
# cnt = 0.7 * fLen
print(cnt)
with open('train.txt','w+') as f:
    for i in range(int(cnt)):
        # f.write(files[ar[i]])
        f.write('data/obj/')
        f.write(files[i])
        f.write('\n')
