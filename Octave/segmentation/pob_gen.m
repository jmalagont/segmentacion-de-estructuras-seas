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
## @deftypefn {} {@var{retval} =} pob_gen (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: usuario <usuario@DESKTOP-6T68KBR>
## Created: 2019-08-17

function pob = pob_gen (im, r)
ims=size(im)(1);
pob=uint16((rand(r^2,4)*(ims-40))+20);
endfunction