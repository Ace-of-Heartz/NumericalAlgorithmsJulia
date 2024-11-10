function get_points(
    n :: Number,
    f :: Function,
    distance :: Number = 0.1,
    limit :: Tuple{<:Number,<:Number} = (0,1),
    )

    xs = range(limit[1],min(n * distance,limit[2]),n)
    ys = f.(xs)

    return (xs,ys)
end

function get_points(
    n :: Number,
    f :: Function,
    g :: Function,
    distance :: Number = 0.1,
    limit :: Tuple{<:Number,<:Number} = (0,1),
    )

    xs = range(limit[1],min(n * distance,limit[2]),n)
    ys = f.(xs)
    zs = g.(xs,ys)


    return (xs,ys)
end

function get_surface_points(
    n :: AbstractArray{<:Number},
    f::Function,
    distances :: AbstractArray{<:Number} = [0.1,0.1],
    limits :: AbstractArray{<:Tuple{<:Number,<:Number} } = [(0,1),(0,1)],
)
    (xs,ys) = map(i -> range(limits[i][1],min(n[i] * distances[i],limits[i][2]),n[i]),eachindex(distances))

    xs = collect(xs)
    ys = collect(ys)
    zs = [f(X,Y) for X ∈ xs, Y ∈ ys]

    return (xs,ys,zs)
end