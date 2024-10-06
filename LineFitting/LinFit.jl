include("Common.jl")

function linfit(
    xs :: AbstractVector{<:AbstractFloat}, 
    ys :: AbstractVector{<:AbstractFloat}
)
    m = length(xs)
    n = length(ys)

    if (n != m)
        error("Input vectors must be of equal length")
    end
    A = [ones(n,1) xs ys]

    _, R = qr(A)
    
    B = [R[2,2] R[2,3]; R[3,2] R[3,3]]

    _, _, V = svd(B)

    n = V[:,2]

    c = - (R[1, 2] * n[1] + R[1, 3] * n[2]) / R[1, 1]

    return (c,n)

end    