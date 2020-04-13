
clc
clear all
close all
pkg load image


addpath ("C:/Users/usuario/Documents/Tesis/Algorithm/Common")

path="C:/Users/usuario/Documents/Tesis/Result/Augmented Data-set";
im = fileextraction(path);
pkg load statistics
gpath="C:/Users/usuario/Documents/Tesis/Result/Augment Ground truth";
files=readdir(gpath);
for x=1:length(im)
  img=im{x}{1};
  img=medfilt2(img,[5 5]);
  imgn=im{x}{2};
  in=strfind(imgn,"A");
  imgn=strcat(imgn(1:in),"G",imgn(in+1:end));
  gimp=strcat(gpath,"/",imgn);
  gimg=imread(gimp);
  gimg=imresize(gimg,size(img));
  gimg=gimg/255;
  

  
  roi=img.*gimg;
  f=img.*(1-gimg);
  nf=var(f(:));
  a=sqrt(sum(gimg(:)));
  
  co(x)=(mean(f(:))-mean(roi(:)))/mean(f(:));
  cnr(x)=(mean(f(:))-mean(roi(:)))/nf;
  psnr(x)=(mean(f(:))/nf)*co(x)*a;
  imshow(img.*gimg)
  pause(0.0000000000000000000000000000000000000001)
  hold off
endfor
mean(co)
mean(cnr)
mean(psnr)