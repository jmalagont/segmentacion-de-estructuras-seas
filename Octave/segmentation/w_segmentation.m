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
## @deftypefn {} {@var{retval} =} w_segmentation (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: usuario <usuario@DESKTOP-6T68KBR>
## Created: 2019-08-08
function L = w_segmentation (im, c1, c2)
pkg load image
cz=20;
scz=floor(cz/2);

mask=zeros(size(im));

mask(c1(1)-scz:c1(1)+scz,c1(2)-scz:c1(2)+scz)=1;
mask(c2(1)-scz:c2(1)+scz,c2(2)-scz:c2(2)+scz)=1;

dmask = bwdist(mask);
dw=watershed(dmask);
bgm = dw == 0;
gradmag2 = imimposemin(im, bgm | mask);
L = watershed(gradmag2);
endfunction