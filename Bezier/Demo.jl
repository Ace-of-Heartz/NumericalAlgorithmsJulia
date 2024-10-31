using GLMakie 
using LinearAlgebra

include("Bezier.jl")



"""
Demo2D()

A simple function for demonstrating an arbitrary Bezier curve's plot in 2D with simple explanations. 
"""
function demo2d()

    xs = Point2f[
        [0,0],
        [5,4 ],
        [10,-7 ],
        [12.5,-9],
        [20.5,11]
    ]

    fig = Figure(size = (1600,1400))
    ax1 = Axis(fig[1,1])
    ax2 = Axis(fig[2,1])

    ts = bezier(xs)
    ts_sub = bezier(xs,0.5,0.005)

    new_xs = constr_sub_curve(0.5,xs);
    new_ts = bezier(new_xs,1,0.01)


    scatter!(fig[1,1],
        map(x -> Point2f(x),xs),
        color = :red,
        markersize = 15,
        marker = :xcross,
        label = "Control points of original Bézier-curve"
        )

    scatter!(fig[1,1],
        map(x -> Point2f(x),new_xs),
        color = :blue,
        markersize = 10,
        marker = :xcross,
        label = "Control points of Bézier-curve between [0,0.5] "
        )

    lines!(fig[1,1],
        ts,
        color = :black,
        linewidth = 2,
        label = "Original Bézier-curve"
        )

    lines!(fig[1,1],
        new_ts,
        color = :orange,
        linewidth = 5,
        label = "Bézier-curve between [0,0.5]"
        )

    Legend(fig[1,2],ax1)

    # Second plot
    n = length(xs)

    xx = map(x -> x[1],xs)
    yy = map(x -> x[2],xs)
    limits!(ax2,
        minimum(xx),
        maximum(xx),
        minimum(yy),
        maximum(yy),
    )

    lines!(fig[2,1],
    ts,
    color = :black,
    linewidth = 2,
    label = "Bézier-curve")
    
    lines!(fig[2,1],xx,yy,color = :red, linewidth = 2, linestyle = :dash)

    pss = []
    lss = []
    for i = 1:n

        ps = Observable(Point2f[])
        ls = Observable(Point2f[])
        
        push!(pss,ps)
        push!(lss,ls)

        scatter!(fig[2,1],ps)
        lines!(fig[2,1],ls)
    end
   
    frames = 0:0.01:1

    record(fig,"bezier.gif", frames;
    framerate = 24) do (t)
        mtx = de_casteljau_mtx(t,xs)
        for i = 1:n
            pss[i][] = mtx[i:n,i]
            lss[i][] = mtx[i:n,i]
        end
    end


    Legend(fig[2,2],ax2)

    return fig
end



"""
Demo3D()

A simple function for demonstrating an arbitrary Bezier curve's plot in 3D with simple explanations. 
"""
function demo3d()
    xs = Point3f[
        [0,0,0],
        [5,4,0],
        [10,-7,-2 ],
        [12.5,-9,3],
        [20.5,11,5]
    ]

    fig = Figure(size = (1600,1400))
    ax1 = Axis3(fig[1,1])
    ax2 = Axis3(fig[2,1], elevation = 0.25 * π)

    ts = bezier(xs)
    ts_sub = bezier(xs,0.5,0.005)

    new_xs = constr_sub_curve(0.5,xs);
    new_ts = bezier(new_xs,1,0.01)


    scatter!(fig[1,1],
        map(x -> Point3f(x),xs),
        color = :red,
        markersize = 15,
        marker = :xcross,
        label = "Control points of original Bézier-curve"
        )

    scatter!(fig[1,1],
        map(x -> Point3f(x),new_xs),
        color = :blue,
        markersize = 10,
        marker = :xcross,
        label = "Control points of Bézier-curve between [0,0.5] "
        )

    lines!(fig[1,1],
        ts,
        color = :black,
        linewidth = 2,
        label = "Original Bézier-curve"
        )

    lines!(fig[1,1],
        new_ts,
        color = :orange,
        linewidth = 5,
        label = "Bézier-curve between [0,0.5]"
        )

    Legend(fig[1,2],ax1)

    # Second plot
    n = length(xs)

    xx = map(x -> x[1],xs)
    yy = map(x -> x[2],xs)
    zz = map(x -> x[3],xs)
    limits!(ax2,
        minimum(xx),
        maximum(xx),
        minimum(yy),
        maximum(yy),
        minimum(zz),
        maximum(zz)
    )

    lines!(fig[2,1],
    ts,
    color = :black,
    linewidth = 2,
    label = "Bézier-curve")
    
    lines!(fig[2,1],xx,yy,zz,color = :red, linewidth = 2, linestyle = :dash)

    pss = []
    lss = []
    for i = 1:n

        ps = Observable(Point3f[])
        ls = Observable(Point3f[])
        
        push!(pss,ps)
        push!(lss,ls)

        scatter!(fig[2,1],ps)
        lines!(fig[2,1],ls)
    end
   
    frames = 0:0.01:1

    record(fig,"bezier.gif", frames;
    framerate = 24) do (t)
        mtx = de_casteljau_mtx(t,xs)
        for i = 1:n
            pss[i][] = mtx[i:n,i]
            lss[i][] = mtx[i:n,i]
        end
    end


    Legend(fig[2,2],ax2)

    return fig
end

function demo3d_surface()
    ps = [
            Point3f[
                [0.,-1,0.],
                [1.,-1,0.],
                [2.,-1,0.]
            ],
            Point3f[
                [0.,0.,0.],
                [1.,0.,2.],
                [2.,0.,0.]
            ],
            Point3f[
                [0.,1.,0.],
                [1.,1.,0.],
                [2.,1.,0.]
            ],
        ]

    fig = Figure()
    ax1 = Axis3(fig[1,1])
    ax2 = Axis3(fig[1,2])
    
    ts = bezier_surface(ps,1,0.01,1,0.01)

    # Iterators.flatten() is very inefficient, possibly find another solution later
    points = collect(Iterators.flatten(ps))
    scatter!(fig[1,1],points)

    meshscatter!(fig[1,1],collect(Iterators.flatten(ts)), color = :red, markersize = 0.01)
    
    new_ps = constr_sub_curve(
        0.5,
        0.5,
        ps
    )

    scatter!(fig[1,2],collect(Iterators.flatten(ps)))
    
    

    return fig
end