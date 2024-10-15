"""
    sgfilter2d(xs,fs,M,nL,nR): Creates a better estimation of the sample values at the given base points.

    xs - base points 
    fs - sample values with noise
    M  - degree of the filtering polinom
    nL - range to the left
    nR - range to the right 
"""
function sgfilter2d(
    xs :: Array{<:Number},
    fs :: Array{<:Number},
    M  :: Number, 
    nL :: Number,
    nR :: Number, 
)
    A = ((-nL:nR)' .^ (M:-1:0))'
    
    (Q,R) = qr(A)
    
    q = 1/R[M+1,M+1] * Q[:,M+1]

    b = fs[:,1]
    for i in nL + 1: length(fs) - nR
        y = fs[i - nL: i + nR] 
        b[i] = dot(q,y)
    end
    return b
end