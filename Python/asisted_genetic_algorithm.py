# import the necessary packages.
from skimage.segmentation import slic
from skimage.util import img_as_float
from skimage import io
from skimage.transform import resize
import matplotlib.pyplot as plt
import numpy as np
from skimage.segmentation import watershed
import random
from skimage.segmentation import mark_boundaries

#functions
#creates an intiail random population (segmentation markers).
def pob_generator(pixels, pz):
    pob = np.random.choice(np.max(pixels),[pz,2] )
    return (pob)

#execute marker controlled watershed.
def Wsegmentation(indv,im,pixels):
    mk=np.zeros(np.shape(im)) # create a mask.
    mk[pixels==indv[0]]=1# generate a label mask with each one of the markers.
    mk[pixels==indv[1]]=2
    mk[pixels==pixels[0,0]]=3
    segs = watershed(im, mk, mask=im)# execute watershed algorithm.
    return (segs)

#evolutive funtion based in Dice-Score index.
def evf (seg,gt):
    seg = seg!=np.max(seg) #separate the back-ground.
    ds= (2*np.sum(seg&gt))/((np.sum(gt))+(np.sum(seg)))# compute de Dice-score between two boolean images.
    return(ds)
    
#organize the population since the best segmentation markers and delete the half of it.
def pobpurge(pob,image,pixels,gt):
    q = [] #create an empty list to save the evolutive function results (quality index) of each single.
    ppob = [] #create an empty list to save the genome of each single.
    for indv  in pob:
        seg = Wsegmentation(indv,image,pixels)#segment the image using the markers.
        qf = evf (seg,gt)#compute the quality index of the segmentation.
        q = q + [qf]# save the quality index.
        ppob = ppob + [list(indv)]#save the single
    spob = ([x for _,x in sorted(zip(q,ppob))])[::-1]#sorted the pupulation based in quality index list
    spob = np.array(spob[0:int(len(spob)/2)])#take thes best individuals
    return (spob)

#reproduce and mutate a population, using an asexual reproduction and two type of mutations.
def mutation(spob,pixels):
    npob = []#create an empty list to save the new population.
    for indv in spob:
        indv = list(indv)#change the individual type, sine numpy array to list.
        nindv = indv.copy()#copy a list in oher variable it whil mutate.
        mt = random.randint(1,10)#select a random mutition type.
        if (mt != 2):#change a random part of the genome to other value.
            nindv[random.randint(1,2)-1]=random.randint(1,np.max(pixels))
        if (mt == 2):#give the same value to both markers in the genome.
            i=nindv[random.randint(1,2)-1]
            nindv = [i,i]
        npob = npob + [indv,nindv]#save the ald and new single in the new population
    npob = np.array(npob)
    return(npob)
    


image = img_as_float(io.imread("/home/jmalagont/Documentos/Articulo/Resultados/Filtered Data-set/Ramp-Lack/20.bmp"))#problem image
gt = io.imread("/home/jmalagont/Documentos/Articulo/Resultados/Augment Ground truth/20.bmp")#ground-truth
gt = resize(gt,np.shape(image))#give the same size to eh both images
gt = (gt>0)
im=np.zeros(list(np.shape(image))+[3])
im[:,:,0]=image
im[:,:,1]=image
im[:,:,2]=image

pixels = slic(im, n_segments = 500, sigma = 1)#reduce the problem image using SLIC superpixels

pob = pob_generator(pixels, 16)#generate intial population.
g=100#number of generations.

for x in range (0,g):
    spob = pobpurge(pob,image,pixels,gt)#purge the population. 
    seg=Wsegmentation(pob[0,:],image,pixels)#sgement the best individual.
    s=evf (seg,gt)#compute the quality factor of the best individual.
    plt.imshow(mark_boundaries(image, seg))
    plt.show()
    print(s)
    pob = mutation(spob,pixels)#mutate the rest of the population.
    

