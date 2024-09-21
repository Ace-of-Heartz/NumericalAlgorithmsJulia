include("Common.jl")

function linpoints(
    n :: AbstractVector{<:AbstractFloat},
    c :: AbstractFloat,
    range :: LinRange{<:AbstractFloat,<:Integer},
    noise :: AbstractFloat
    ) 

    (n1, n2) = n ./ norm(n,2)
    
    v = [-n2, n1]

    p = n .* -c;

    t = collect(range)

    vt = t * v'
    pt = ones(length(t),1) * p'

    ps = vt + pt ;

    ns = (rand(length(range),2) .- 0.5) * 2 * noise  
    
    
    return ps + ns;
end


