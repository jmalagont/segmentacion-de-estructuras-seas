% Compute distance
function dist = compute_dist(A, B) 
m = size(A);
n = size(B);
d_vec = [];
D = [];
% dim= size(A, 2); 
for j = 1:m(2)
    
    for k= 1: n(2)
        
    D(k) = abs((A(j)-B(k)));
      
    endfor ;
    
    d_vec(j) = min(D); 
      
endfor;
% keyboard
 dist = max(d_vec);
endfunction