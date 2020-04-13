## Copyright (C) 2019 usuario
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} Rampfl (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: usuario <usuario@DESKTOP-6T68KBR>
## Created: 2019-08-04
function fim = Rampfl (im,ang)
addpath ("C:/Users/usuario/Documents/Tesis/Algorithm/Common")
pkg load image
rim=radon(im,ang);
for y=1:length(ang)
  proj=rim(:,y);
  fcproj=fft(proj)(1:floor(length(proj)/2));
  fcproj=fcproj.*[1:(length(fcproj))]';
  fcproj2=fft(proj)(floor(length(proj)/2)+1:end);
  fcproj2=fcproj2.*fliplr([1:(length(fcproj2))])';
  fcproj=[fcproj;fcproj2];
  fproj=abs(ifft(fcproj));
  nsin(:,y)=fproj;
endfor
#nsin=medfilt2(nsin,[3 3]);
fim=iradon(nsin,ang);
fim=medfilt2(fim,[5 5]);
fim=fim(2:end-2,2:end-2);
fim=normalization(fim);
fim=uint8(fim);
endfunction