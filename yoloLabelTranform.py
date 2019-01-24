import os
import xml.etree.ElementTree as ET

def format(value):
    return "%.6f" % value

def VOC2Yolo(path,fName):
    fPath = os.path.join(path,fName)
    nameId = {'foot':"0",'knee':"1",'hip':"2",'arm':"3",'shoulder':"4",'head':"5"}
    xmlTree = ET.parse(fPath)
    root = xmlTree.getroot()
    for el in root.iter():
        if 'filename' in el.tag:
            filename = el.text.split('.')[0]
            filename = fName[:-4]
            txt_name = './data/Annotations/txts/'+filename+'.txt'
            print(txt_name)
            fText = open(txt_name, 'w+')
            # fText = open(filename+'.txt','w+')
        elif 'size' in el.tag:
            imgWidth = el[0].text
            imgHeight = el[1].text
            imgDepth = el[2].text
        elif 'object' in el.tag:
            if(el[0].text not in nameId):
                print(el[0].text,'***********',filename)
                continue
            fText.write(nameId[el[0].text])
            fText.write(' ')
            fText.write(format((float(el[4][0].text)+float(el[4][2].text))/2.0/float(imgWidth)))
            fText.write(' ')
            fText.write(format((float(el[4][1].text)+float(el[4][3].text))/2.0/float(imgHeight)))
            fText.write(' ')
            fText.write(format((float(el[4][2].text)-float(el[4][0].text)) / float(imgWidth)))
            fText.write(' ')
            fText.write(format((float(el[4][3].text)-float(el[4][1].text)) / float(imgWidth)))
            fText.write('\r')
    fText.close()

currentPath = './data/Annotations'

fs = os.listdir(currentPath)
# print(type(fs))
# print(len(fs))
# # for f in fs:
# #     print(fs)


# f = fs[0]
for f in fs:
    VOC2Yolo(currentPath,f)
    # break


