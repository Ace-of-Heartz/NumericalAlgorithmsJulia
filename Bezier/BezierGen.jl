using GLMakie

include("Bezier.jl")
include("../Utils/Points.jl")

function gen_bezier_2d(
    n :: Number,
    f :: Function = ((x) -> 0),
    yNoise :: Number = 1,
    xNoise :: Number = 1,
    #distance :: Number = 0.1,
    limit :: Tuple{<:Number,<:Number} = (0,1),
)
    xs,ys = get_points(n,f,limit)
    xs += (rand(length(xs)) .* 2 .-1) .* xNoise; ys += (rand(length(ys)) .* 2 .-1) .* yNoise;

    ps = map(i -> Point2f(xs[i],ys[i]),eachindex(xs))

    ts = bezier(ps)

    fig = Figure()
    ax = Axis(fig[1,1])

    scatter!(fig[1,1],
    ps,
    marker = :xcross
    )

    lines!(fig[1,1],
    ps,
    color = :blue,
    )

    lines!(fig[1,1],
    ts,
    color = :black,
    )

    return fig
end

function gen_bezier_3d(
    n :: Number,
    f :: Function = ((x) -> 0),
    g :: Function = ((x,y) -> 0),
    yNoise :: Number = 1,
    xNoise :: Number = 1,
    zNoise :: Number = 1,
    #distance :: Number = 0.1,
    limit :: Tuple{<:Number,<:Number} = (0,1),
)
    xs,ys,zs = get_points(n,f,g,limit)
    xs += (rand(length(xs)) .* 2 .-1) .* xNoise; ys += (rand(length(ys)) .* 2 .-1) .* yNoise; zs += (rand(length(zs)) .* 2 .-1) .* zNoise;

    ps = map(i -> Point3f(xs[i],ys[i],zs[i]),eachindex(xs))

    ts = bezier(ps)

    fig = Figure()
    ax1 = Axis3(fig[1,1])

    scatter!(fig[1,1],
        ps,
        color = :blue,
        marker = :xcross 
    )

    lines!(fig[1,1],
    ps,
    color = :red
    )
    lines!(fig[1,1],
        ts,
        color = :black
    )



    return fig
end

"""
function gen_bezier_surf(n, noise, f, distance, limits), where\n
    n        :: Number - Number of points per dimension 
    noise    :: Symmetrical noise to use on the Z dimension.
    f        :: Function used to generate the Z components of the controlpoints.
    distance :: Array the length of the dimensions used. Specifies the distance between the controlpoints of the different dimensions.
    limits   :: Array the length of the dimensions used. Specifies the lower and upper limits of controlpoints.

"""
function gen_bezier_surf(
    n :: AbstractArray{<:Number},
    noise :: Number = 1,
    f :: Function = ((x,y) -> 0),
    #distance :: AbstractArray{<:Number} = [0.1,0.1],
    limits :: AbstractArray{<:Tuple{<:Number,<:Number} } = [(0,1),(0,1)],
    )

    ps = get_surface_points(n,f,limits)

    xs,ys,zs = ps

    zNoise = (rand(size(zs)[1],size(zs)[2]) .* 2 .-1) .* noise
    print(zNoise)
    zs += zNoise

    ps = map(i -> map(j ->Point3f(xs[i],ys[j],zs[i,j]), eachindex(ys)),eachindex(xs))

    ts = bezier_surface(ps)
    

    fig = Figure()
    ax1 = Axis3(fig[1,1])
    ax2 = Axis3(fig[1,2])

    scatter!(fig[1,1],collect(Iterators.flatten(ts)),color = :orange)


    scatter!(fig[1,1],xs,ys,zs,marker = :x)

    surface!(fig[1,2],xs,ys,zs,alpha = 0.3)
    for p in ps  
        lines!(fig[1,2],p,color = :blue)
    end 

    for i in eachindex(ps[1])
        p = map(t -> ps[t][i],1:length(ps))
        lines!(fig[1,2],p,color = :red)
    end

    scatter!(fig[1,2],xs,ys,zs)


    return fig
end