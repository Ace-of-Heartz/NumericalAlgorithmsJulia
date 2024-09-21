function planefit(
    xs :: AbstractVector{<:AbstractFloat},
    ys :: AbstractVector{<:AbstractFloat},
    zs :: AbstractVector{<:AbstractFloat}
    ) :: Tuple{AbstractFloat,<:AbstractVector{<:AbstractFloat}}

    m = length(xs)
    n = length(ys)
    o = length(zs)
    if (n != m || n != o)
        error("Input vectors must be of equal length")
    end

    A = [ones(length(xs),1) xs ys zs]

    _, R = qr(A) 
    B = [ R[2:size(R)[1],2] R[2:size(R)[1],3] R[2:size(R)[1],4] ]

    _, _, V = svd(B)
    n = V[:,3]

    c = - (R[1,2] * n[1] + R[1,3] * n[2] + R[1,4] * n[3]) / R[1,1]

    return (c,n)

end