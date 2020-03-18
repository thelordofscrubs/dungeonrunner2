from PIL import Image
import os, os.path
import math

images = []

files = os.listdir()

for f in files:
    if f.endswith(".png"):
        images.append(Image.open(f))

if len(images) < 16:
    atd = [len(images), 1]

atl = math.ceil(len(images)/16)
atd = [len(images)%16, atl]

atlas = Image.new("RGBA", (16*16,atd[1]*16))#.load()
#
#for image in images:
#    image = image.load()

for y in range(atl-1):
    for x in range(16):
        #print("pasting image "+str(y*16+x)+ " at position "+str(x)+", "+str(y))
        atlas.paste(images[y*16+x],(x*16,y*16))
#        for x1 in range(16):
#            for y1 in range(16):
#                atlas[x*16+x1,y*16+y1] = image[y*16+x][x1,y1]

left = 16

if atd[0] != 0:
    left = atd[0]

for x in range(left):
    atlas.paste(images[x-left],(x*16,(atl-1)*16))
#    for x1 in range(16):
#        for y1 in range(16):
#            atlas[x*16+x1,atl*16+y1] = image[y*16+x][x1,y1]

atlas.save("spriteAtlas.png")





