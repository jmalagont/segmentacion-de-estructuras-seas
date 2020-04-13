clc
close all
clear all

sim=imread("C:/Users/usuario/Documents/Tesis/Result/segmented data/PrA5t.bmp");
gim=imread("C:/Users/usuario/Documents/Tesis/Result/Augment Ground truth/PrAG5t.bmp");
gim=imresize(gim,size(sim));
#sim=sim>100;
gim=gim>100;
D=imhausdorff(sim,gim,method='euclidean')
dice = 2*nnz(sim&gim)/(nnz(sim) + nnz(gim))
