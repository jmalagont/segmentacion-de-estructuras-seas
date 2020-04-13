clc
close all
clear all

im=imread("C:/Users/usuario/Documents/Tesis/Result/Filtered Data-set/Ramp-Lack/A2tp.bmp");
n=0;
for x=1:size(im,1)
  for y=1:size(im,2)
    n=n+1;
    X(n)=x;
    Y(n)=y;
    Z(n)=im(x,y);
  
endfor
endfor
surf(X,Y,Z)