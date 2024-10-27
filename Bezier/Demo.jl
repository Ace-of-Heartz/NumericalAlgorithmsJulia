using GLMakie 
using LinearAlgebra

include("Bezier.jl")



"""
Demo()

A simple function for demonstrating an arbitrary Bezier curves plot with simple explanations. 
"""
function Demo()

    xs = [
        [0,0],
        [5,4 ],
        [10,-7 ],
        [12.5,-9],
        [20.5,11]
    ]

    fig = Figure(size = (1600,1400))
    ax1 = Axis(fig[1,1])
    ax2 = Axis(fig[2,1])

    ts = bezier2d(xs)
    ts_sub = bezier2d(xs,0.5,0.005)

    new_xs = constr_sub_curve(xs,0.5);
    new_ts = bezier2d(new_xs,1,0.01)


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