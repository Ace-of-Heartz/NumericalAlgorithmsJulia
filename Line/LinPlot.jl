using GLMakie

function plotline_withpoints(
    xs, 
    ys, 
    c, 
    n, 
    range :: AbstractMatrix{<:AbstractFloat}
)
    n = n / norm(n,2)
    n1, n2 = n 
    v = [-n2,n1]

    p = n .* -c

    f = Figure()


    ax = Axis(f[1, 1])
    scatter!(f[1, 1],xs,ys)

    lines!(f[1,1],[p[1] + range[1] * v[1], p[1] + range[2] * v[1]],
    [p[2] + range[1] * v[2], p[2] + range[2] * v[2]],
    color = "red")
    return f
end