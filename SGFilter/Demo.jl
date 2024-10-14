using LinearAlgebra
using GLMakie

include("../Utils/Sample/Sample.jl")
include("SGFilter2D.jl")


function demo()

    # Create initial sample values
    xs = collect(0:0.1:10)
    f = x ->  x^3 * cos(x)
    noise = n -> ( (rand(n,1) .- 0.5) .* 2.0) .* 7.5
    fs = create_sample(xs,f,noise)


    # Settings
    M = 3 
    nL = 10
    nR = 10

    bs = sgfilter2d(xs,fs,M,nL,nR)

    fig = Figure()
    ax  = Axis(fig[1,1])

    print(bs)

    lines!(fig[1,1],xs,f.(xs),color = :green)
    lines!(fig[1,1],xs,fs[:,1], color = :red)
    lines!(fig[1,1],xs,bs, color = :blue)

    return fig
end