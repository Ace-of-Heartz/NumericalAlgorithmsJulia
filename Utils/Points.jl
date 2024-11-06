function get_points(
    n :: Number,
    dim :: Number = 2,
    distance :: AbstractArray{<:Number} = [0.1,0.1],
    limit :: AbstractArray{<:Tuple{<:Number,<:Number} } = [(0,1),(0,1),(0,1)],
    )

    ps = map(range(0,n * distance,n),distance)


end

function get_points(
    n :: Number,
    f::Function,
    dim :: Number = 2, 
    distance :: AbstractArray{<:Number} = [0.1,0.1],
    limit :: AbstractArray{<:Tuple{<:Number,<:Number} } = [(0,1),(0,1)],
)
    (xs,ys) = map(i -> range(limit[i][1],min(n * distance[i],limit[i][2]),n),eachindex(distance))

    xs = collect(xs)
    ys = collect(ys)
    zs = [f(X,Y) for X ∈ xs, Y ∈ ys]

    return (xs,ys,zs)
end