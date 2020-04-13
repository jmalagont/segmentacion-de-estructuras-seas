
clc
clear all
close all
pkg load image


addpath ("C:/Users/usuario/Documents/Tesis/Algorithm/Common")

path="C:/Users/usuario/Documents/Tesis/Result/Filtered Data-set/Ramp-Lack";
im = fileextraction(path);
pkg load statistics
pkg load nan
gpath="C:/Users/usuario/Documents/Tesis/Result/Augment Ground truth";
files=readdir(gpath);
for x=1:length(im)
  img=im{x}{1};
  imgn=im{x}{2};
  in=strfind(imgn,"A");
  imgn=strcat(imgn(1:in),"G",imgn(in+1:end));
  gimp=strcat(gpath,"/",imgn);
  gimg=imread(gimp);
  gimg=imresize(gimg,size(img));
  gimg=gimg/255;
  
  ph=gimg;
  nh=1-gimg;
  ccp = bwconncomp (ph);
  ccn = bwconncomp (nh);
  
  rpp=regionprops (ccp,"Area","Perimeter","Solidity");
  rpn=regionprops (ccn,"Area","Perimeter","Solidity");
  
  c1pc(x)=(max(rpp.Perimeter)^2)/max(rpp.Area);
  c1nc(x)=(max(rpn.Perimeter)^2)/max(rpn.Area);
  
  c2pc(x)=max(rpp.Solidity);
  c2nc(x)=max(rpn.Solidity);
  
  c3pc(x)=median(nonzeros((ph.*(img+1))(:))-1);
  c3nc(x)=median(nonzeros((nh.*(img+1))(:))-1);
  
  c4pc(x)=max(nonzeros((ph.*(img+1))(:))-1);
  c4nc(x)=max(nonzeros((nh.*(img+1))(:))-1);
  
  c5pc(x)=var(nonzeros((ph.*(img+1))(:))-1);
  c5nc(x)=var(nonzeros((nh.*(img+1))(:))-1);

  c6pc(x)=entropy(nonzeros((ph.*(img+1))(:))-1);
  c6nc(x)=entropy(nonzeros((nh.*(img+1))(:))-1);  
 
  
  x
endfor
c1=[c1pc,c1nc]';
c2=[c2pc,c2nc]';
c3=[c3pc,c3nc]';
c4=[c4pc,c4nc]';
c5=[c5pc,c5nc]';
c6=[c6pc,c6nc]';

c=[c1,c2,c3,c4,c5,c6];

ref=[zeros(length(c1pc),1);ones(length(c1pc),1)];

[idx,score]=fss(double(c),double(ref),"rank")
#if max(nc)> max(pc)
#  a=nc;
#  b=pc;
#endif

#if max(pc)> max(nc)
#  b=nc;
#  a=pc;
#endif
#rc=[min(a), max(b)];
#cnc=find(nc<rc(2)& nc>rc(1));
#cpc=find(pc<rc(2)& pc>rc(1));
#pcr=(length(cnc)+length(cpc))/(length(pc)+length(nc))*100
#boxplot ({nc, pc});
# set(gca (), "xtick", [1 2], "xticklabel", {"Fondo", "Regiones Óseas"})
# title ("Maximo");