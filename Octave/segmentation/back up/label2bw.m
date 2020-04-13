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
## @deftypefn {} {@var{retval} =} label2bw (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: usuario <usuario@DESKTOP-6T68KBR>
## Created: 2019-10-14

function [h,f] = label2bw (seg,im)
  s1= seg==1;
  s2= seg==2;
  s3= seg==3;
  
  p1=fe(s1,im);
  p2=fe(s2,im);
  p3=fe(s3,im);
  
  if p1>p3
    h=s1;
    else
    h=s3;
  endif
  f=fe1(h,im);
  if abs(p1-p2)>abs(p1-p3)
    h=seg~=2;
    f=fe1(h,im);
  endif
endfunction