# import the necessary packages
from skimage.segmentation import slic
from skimage.util import img_as_float
from skimage import io
import matplotlib.pyplot as plt
import numpy as np
from skimage.segmentation import watershed

#functions
def pob_generator(pixels, pz):
    pob = np.random.choice(np.max(pixels),[pz] )
    return (pob)

def Wsegmentation(indv,im,pixels):
    mk=np.zeros(np.shape(im))
    mk[pixels==indv[0]]=1
    mk[pixels==indv[1]]=2
    mk[pixels==pixels[0,0]]=3
    segs = watershed(im, mk, mask=im)
    return (segs)


image = img_as_float(io.imread("/home/jmalagont/Documentos/Articulo/Resultados/Filtered Data-set/Ramp-Lack/33.bmp"))
gt = io.imread("/home/jmalagont/Documentos/Articulo/Resultados/Augment Ground truth/33.bmp")
gt = (gt>1)
im=np.zeros(list(np.shape(image))+[3])
im[:,:,0]=image
im[:,:,1]=image
im[:,:,2]=image

pixels = slic(im, n_segments = 100, sigma = 1)

pob = pob_generator(pixels, 16)

g=3

seg=Wsegmentation([51,48],image,pixels)
plt.imshow(seg)
#for x in range (0,g):
    
    