    function [wcrs] = crs(w)
           %Turn a post-multiplying 3x1 vector into a pre-multiplying 3x6 for a symmetric 3x3 matrix.
           wcrs=[ 0    -w(3)  w(2)
                  w(3)  0    -w(1)
                 -w(2)  w(1)  0   ];