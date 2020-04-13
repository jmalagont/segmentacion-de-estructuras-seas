#clc
#clear all
#close all

#n=4;
#im  = imread("C:/Users/usuario/Documents/Tesis/Result/Filtered Data-set/Ramp-Lack/A4tp.bmp");
#mf=0.5;

function [mind, sg] = genetic (n,im, mf,gn)
pob = pob_gen(im,n);
#pob(end,:)  = [340,340,339,555];

for g=1:gn
  
  #selección
for i = 1:size(pob)(1)
  indv  = pob(i,:);
  seg = w_segmentation (im, indv(1:2), indv(3:4));
  try
  [q,sg] = label2bw (seg, im);
  #imagesc(sg.*im);
  ##pause(0.00000000000000000000000000000000001)
  #hold off
catch
  q=0;
  sg=seg;
end_try_catch
rpa=sum(sg(:))/(size(im)(1)^2);
if rpa<0.1
  q=0;
endif
ev(i)=q;
endfor
#close all
sev=fliplr(sort(ev));
mind=pob(find(ev==sev(1))(1),:);
seg = w_segmentation (im, mind(1:2), mind(3:4));
for x=1:max(seg(:))
  if x==seg(1,1)
    sg=(seg~=x);
    
  else 
    sg=(seg==x);
   q=ef (sg,im,1);
  ims{x}=sg;
  qs(x)=q;
endif
endfor
g
#max(qs);
sg=ims{find(qs==max(qs))(end)};
#imagesc(ims{find(qs==max(qs))(end)}.*im)
#pause(3)

for i=1:length(sev)/2
u=find(ev==sev(i))(1);
spob(i,:)=pob(u,:);
endfor
npob=[0,0,0,0];
for i=1:2:length(sev)/2
  Pa=spob(i,:);
  Ma=spob(i+1,:);
  h1=[Pa(1),Pa(2),Ma(3),Ma(4)];
  h2=[Ma(1),Ma(2),Pa(3),Pa(4)];
  if mf>rand(1,1)
    h2(uint8((rand(1,1)*3)+1))=uint16(rand(1,1)*(size(im)(1)-40))+20;
    #h2=[Ma(1),Ma(2),Pa(3),Pa(4)];
  endif
  snpob=[Pa;Ma;h1;h2];
  npob=[npob;snpob];
endfor
pob=npob(2:end,:);

endfor

endfunction