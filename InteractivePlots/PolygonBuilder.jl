using GLMakie 
using LinearAlgebra

IS_EXITING = false
POINTS = Observable(Point2f[])
FIG = Figure()
AX = Axis(FIG[1,1])



function plot()
    scatter!(FIG[1,1],POINTS)    
    lines!(FIG[1,1],POINTS)
end

function init() :: Figure
    plot()
    return FIG
end

function init_events() 
    on(events(FIG).mousebutton, priority = 2) do event  
        if event.button == Mouse.left && event.action == Mouse.press 
            if Keyboard.a in events(FIG).keyboardstate
                if length(POINTS[]) == 0
                    push!(POINTS[],mouseposition(AX))
                    push!(POINTS[],mouseposition(AX))
                else 
                    insert!(POINTS[],length(POINTS[]),mouseposition(AX))
                end

                notify(POINTS)
                return Consume(true)
            end
        else
            return Consume(false)
        end
    end
end

function main()
    init()    
    init_events()
end

main()
FIG