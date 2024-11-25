function get_points(
    n :: Number,
    f :: Function,
    start :: Number = 0.0,
    distance :: Number = 0.1,
    )

    xs = range(start,n * distance, length = n)
    ys = f.(xs)

    return (xs,ys)
end

function get_points(
    n :: Number,
    f :: Function,
    limit :: Tuple{<:Number,<:Number} = (0,1),
    )

    xs = range(limit[1],limit[2], length = n)
    ys = f.(xs)

    return (xs,ys)
end


function get_points(
    n :: Number,
    f :: Function,
    g :: Function,
    start :: Number = 0.0,
    distance :: Number = 0.1,
    )

    xs = range(start,n * distance, length = n)
    ys = f.(xs)
    zs = g.(xs,ys)


    return (xs,ys)
end

function get_points(
    n :: Number,
    f :: Function,
    g :: Function,
    limit :: Tuple{<:Number,<:Number} = (0,1),
    )

    xs = range(limit[1],limit[2], length = n)
    ys = f.(xs)
    zs = g.(xs,ys)


    return (xs,ys)
end

function get_surface_points(
    n :: AbstractArray{<:Number},
    f :: Function,
    starts :: AbstractArray{<:Number} = [0.0,0.0],
    distances :: AbstractArray{<:Number} = [0.1,0.1],
    
)
    (xs,ys) = map(i -> range(starts[i],n[i] * distances[i],length = n[i]),eachindex(distances))

    xs = collect(xs)
    ys = collect(ys)
    zs = [f(X,Y) for X ∈ xs, Y ∈ ys]

    return (xs,ys,zs)
end

function get_surface_points(
    n :: AbstractArray{<:Number},
    f::Function,
    limits :: AbstractArray{<:Tuple{<:Number,<:Number} } = [(0,1),(0,1)],
)
    (xs,ys) = map(i -> range(limits[i][1],limits[i][2],length = n[i]),eachindex(distances))

    xs = collect(xs)
    ys = collect(ys)
    zs = [f(X,Y) for X ∈ xs, Y ∈ ys]

    return (xs,ys,zs)
end