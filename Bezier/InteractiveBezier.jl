using GLMakie 
using LinearAlgebra

include("Bezier.jl")
include("BezierGen.jl")

function demo()
    
    control_points = Observable(Point2f[]) 
    

    step = 0.001
    ts = Observable(Point2f[])

    fig = Figure()
    axCurr = Axis(fig[1,1])


    controlpoint = scatter!(fig[1,1],control_points)
    controlpoint_lin = lines!(fig[1,1],control_points)
    lin = lines!(fig[1,1],ts)
    
    on(events(fig).mousebutton, priority = 2) do event  
        if event.button == Mouse.left && event.action == Mouse.press 
            if Keyboard.a in events(fig).keyboardstate
                push!(control_points[],mouseposition(axCurr))
                ts[] = bezier(control_points[],1,step)

                notify(control_points)
                notify(ts)
                return Consume(true)
            end
        else
            return Consume(false)
        end
    end

    Legend(fig[1,2],[controlpoint,controlpoint_lin,lin],["Control points","Lines between control points","Bezier-curve"])

    return fig
end

demo()