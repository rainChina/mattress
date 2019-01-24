import os

workDir = '.\data\JPEGImages'
fNames = os.listdir(workDir)
for fName in fNames:
    if '_flip' in fName:
        fRemove = os.path.join(workDir,fName)
        os.remove(fRemove)
        print(fRemove)

