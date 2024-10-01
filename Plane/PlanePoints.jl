include("Common.jl")

function planepoints(
    n :: AbstractVector{<:Number},
    c :: Number,
    rangeX :: LinRange{<:Number},
    rangeY :: LinRange{<:Number},
    noise :: Number
    ) :: AbstractVecOrMat{<:Number}
    n = n / norm(n,2)

    tx = collect(rangeX);
    ty = collect(rangeY)

    m1 = length(tx)
    m2 = length(ty) 

    tx = repeat(tx,inner = m2)
    ty = repeat(ty,outer = m1)

    p = n .* -c

    n1, n2, n3 = n

    i =  [-n2,n1,n3]   
    j = cross(i,n)

    txs = tx * i'
    tys = ty * j'

    ts = txs + tys

    ps = ones(m1 * m2,1) * p' + ts
    
    ns = (rand(m1 * m2,3) .- 0.5) .* 2. .* noise

    return ps + ns
end

function get_sep_coords(ps :: AbstractVecOrMat{<:Number}) :: Tuple{<:AbstractVector{<:Number},<:AbstractVector{<:Number},<:AbstractVector{<:Number}}
    return (ps[:,1],ps[:,2],ps[:,3])
end