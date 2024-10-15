using GLMakie 

function plot_bezier2d(
    xs :: Array{<:Number}
)
    t = Observable(0)

    frames = 1:0.2:10

    fig = Figure()
    record(fig[1,1],frames,
        framerate = 24) do t
            bs_old = xs 
            bs_new = []
            for j = 1:n 
                for i = 1:n-j 
                    push!(bs_new,bs_old[i] * (1 - t) + bs_old[i + 1] * t) 
                end
                bs_old = bs_new
                bs_new = []
            end
        end 





end