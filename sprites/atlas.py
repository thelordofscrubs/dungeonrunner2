from PIL import Image
import os, os.path
import math

images = []

files = os.listdir()

if not ("atlasHas.txt" in files):
    t = open("atlasHas.txt", "w")
    t.close()

filesFile = open("atlasHas.txt", "r")

currentFilesS = filesFile.read()
currentFiles = currentFilesS.split(",")
if not currentFilesS:
    currentFiles = []
filesFile.close()
for f in files:
    if (f != "spriteAtlas.png" and f.endswith(".png")) and not (f in currentFiles):
        currentFiles.append(f)
for f in currentFiles:
    images.append(Image.open(f))
length = len(images)
#trying to get dimentions to be near a square number, (ex 25 would be 5 by 5, but 42 would be 6 by 7)
#gonna try and use the inner most multiples, if fail:
#then trying to just use very near numbers
root = math.sqrt(length)
r = math.ceil(root)
l = math.floor(length/r)
r = math.ceil(length/l)
succsess = False
while (abs(r-root) <= math.e/10*length):
    if (l*r == length):
        succsess = True
        break
    l = math.floor(length/r)
    r = math.ceil(length/l)
if succsess:
    atd = [r,l]
else:
    atd = [math.ceil(root),math.ceil(root)]

atlas = Image.new("RGBA", (atd[0]*16,atd[1]*16))#.load()
#
#for image in images:
#    image = image.load()

for y in range(atd[1]):
    for x in range(atd[0]):
        #print("pasting image "+str(y*16+x)+ " at position "+str(x)+", "+str(y))
        atlas.paste(images[y*atd[0]+x],(x*16,y*16))
#        for x1 in range(16):
#            for y1 in range(16):
#                atlas[x*16+x1,y*16+y1] = image[y*16+x][x1,y1]

left = 16

if atd[0] != 0:
    left = atd[0]

for x in range(left):
    atlas.paste(images[x-left],(x*16,(atd[1])*16))
#    for x1 in range(16):
#        for y1 in range(16):
#            atlas[x*16+x1,atl*16+y1] = image[y*16+x][x1,y1]

#atlas.show()
atlas.save("spriteAtlas.png")

currentFilesS = ""

for fi in range(len(currentFiles)-1):
    currentFilesS += currentFiles[fi] + ","
currentFilesS += currentFiles[-1]
filesFile = open("atlasHas.txt", "w")
filesFile.write(currentFilesS)
filesFile.close()




