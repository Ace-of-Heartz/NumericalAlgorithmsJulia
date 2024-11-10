using GLMakie 

function plot_wireframe(
    subfig,
    ps :: AbstractVector{<:AbstractVector{<:Point}},
    
    )
    for p in ps  
        lines!(subfig,p,color = :blue)
    end 

    for i in eachindex(ps)
        p = map(t -> ps[t][i],1:length(ps))
        lines!(subfig,p,color = :red)
    end
end

function plot_controlpoints(
    subfig,
    ps :: AbstractVector{<:AbstractVector{<:Point}},
)
    scatter!(subfig,collect(Iterators.flatten(ps)))
end

function plot_controlpoints(
    subfig,
    xs,
    ys,
    zs
)
    scatter!(subfig,xs,ys,zs,marker = :x)
end

