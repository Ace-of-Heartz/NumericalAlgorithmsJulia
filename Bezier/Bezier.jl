using GLMakie 

function de_casteljau(t,xs)
    n = length(xs)
    
    bs_old = xs
    bs_new = []
    for j = 1:n
        for i = 1:n-j
            push!(bs_new, bs_old[i+1] .* (1 - t) + bs_old[ini] .* t)
        end

        if length(bs_new) == 0
            break
        end
        print("BS Old: $bs_old\nBS New: $bs_new\n")
        bs_old = bs_new
        bs_new = []

    end
    
    return Point2f(bs_old[1])
end

function plot_bezier2d(
    xs 
)
    ps = Observable(de_casteljau(0,xs));

    frames = 0:0.2:10
    
    fig = Figure()
    ax = Axis(fig[1,1])

    lines!(fig[1,1],ps)
    
    record(fig,"Bezier.gif",frames;
        framerate = 24) do k
            b = de_casteljau(k,xs)
            ps[] = push!(ps[],b)
        end 
end

