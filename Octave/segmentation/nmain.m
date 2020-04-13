clc
close all
clear all

path=("C:/Users/usuario/OneDrive/Documents/Tesis/Result/Filtered Data-set/Ramp-Lack/RfA4tp.bmp");

npath=("C:/Users/usuario/OneDrive/Documents/Tesis/Result/segmented data/RfA4tp.bmp");

im=imread(path);
imagesc(im)
im= imsmooth(im, "Gaussian");
seg = w_segmentation (im, [314 318], [294 84]);
sg=seg~=2;
imagesc(sg)
imwrite (sg*255,npath );