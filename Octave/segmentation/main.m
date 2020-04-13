clc
close all
clear all

path=("C:/Users/usuario/OneDrive/Documents/Tesis/Result/Filtered Data-set/Ramp-Lack");

npath=("C:/Users/usuario/OneDrive/Documents/Tesis/Result/segmented data");
files=readdir(path);

n=0;
for x =1:length(files)
file=files{x};
i=strfind(file,".bmp");
if length(i)>0
  im=imread(strcat(path,"/",file));
  #fim= imsmooth(im, "Gaussian");
  [mind, sg] = genetic (4,im, 0.9,10);
  imagesc(sg)
  pause(0.0000000000000000000000000000001)
  hold off
  imwrite (sg*255,strcat(npath,"/",file) );
endif
endfor
