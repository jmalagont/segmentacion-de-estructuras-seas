clc
clear all
close all


im=imread("C:/Users/usuario/Documents/Tesis/Result/Filtered Data-set/Ramp-Lack/A3p.bmp");
gim=imread("C:/Users/usuario/Documents/Tesis/Result/Augment Ground truth/AG3p.bmp");
gim=gim/255;
gim=imresize(gim,size(im));

Ll = w_segmentation (im, [350 350], [350 600]);
L= (Ll==1);
figure  
imagesc(L);
colormap(gray)
figure
imagesc(gim)
colormap(gray)
dice = 2*nnz(L&gim)/(nnz(L) + nnz(gim))