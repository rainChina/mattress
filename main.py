import pandas as pd
import numpy as np
from scipy.interpolate import griddata
import matplotlib.pyplot as plt

data = pd.read_excel('./40001.xlsx',header=None)
# print(data.head(2))

rawData = data.iloc[:,5]
# print(type(rawData[0]))

cnt = 0
for item in rawData:
    if(cnt>1):
        break
    rawStritem = item.replace('[','')
    rawStritem = rawStritem.replace(']','')
    arStr = rawStritem.split(',')
    ar = np.array( list(map(int,arStr)))
    # ar = ar.reshape((64,32))
    origin_x, origin_y = np.mgrid[0:1:64j,0:1:32j]
    aim_x,aim_y = np.mgrid[0:0.5:64j,0:0.5:32j]
    aim = griddata((origin_x,origin_y),ar,(aim_x,aim_y),method='cubic')
    plt.figure()
    plt.imshow(aim, extent=(0,1,0,1), origin='lower')
    plt.show()
    print(ar)
    cnt+=1




# def func(x, y):
#      return x*(1-x)*np.cos(4*np.pi*x) * np.sin(4*np.pi*y**2)**2
#
#
# grid_x, grid_y = np.mgrid[0:1:100j, 0:1:200j]
#
# points = np.random.rand(1000, 2)
# values = func(points[:,0], points[:,1])
#
# print(points.shape)
# print(values.shape)
# print(values)
# print((grid_x, grid_y))
#
# grid_z2 = griddata(points, values, (grid_x, grid_y), method='cubic')
# plt.imshow(grid_z2.T, extent=(0,1,0,1), origin='lower')
# plt.title('Cubic')
# plt.gcf().set_size_inches(6, 6)
# plt.show()