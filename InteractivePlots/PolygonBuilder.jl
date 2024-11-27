using GLMakie 
using LinearAlgebra

IS_EXITING = false
POINTS :: AbstractArray{<:Point} = Observable(Point2f[])
FIG = Figure()

function get_new_point()
    pick()
end

function plot()
    scatter!(FIG[1,1],POINTS)    
    lines!(FIG[1,1],POINTS)
end

function init() :: Figure
    Axis(FIG[1,1])

    return FIG
end

function init_events() 
    on(events(FIG).mouse_buttons, priority = 2) do event  
    end
end

function main()
    init()    
    init_events()
end

FIG