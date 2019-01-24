import os
import cv2

imgfolder = '.\data\img'
videoname = 'video_new.mp4'

imgNames = [imgname for imgname in os.listdir(imgfolder) if imgname.endswith('png')]

imgNames.sort(key=lambda x: int(x[3:-4]))

print(imgNames)

path = os.path.join(imgfolder,imgNames[0])
print(path)

frame = cv2.imread(path)
height,width,channel = frame.shape

# vidWriter = cv2.VideoWriter(videoname,cv2.VideoWriter_fourcc(*'x264'),5,(width,height))

# vidWriter = cv2.VideoWriter(videoname,cv2.VideoWriter_fourcc('M','J','P','G'), 10,(width,height))

fourcc = cv2.VideoWriter_fourcc(*'mp4v')
vidWriter = cv2.VideoWriter(videoname,fourcc,8,(width,height))


for img in imgNames:
    path = os.path.join(imgfolder,img)
    vidWriter.write(cv2.imread(path))

cv2.destroyAllWindows()
vidWriter.release()

