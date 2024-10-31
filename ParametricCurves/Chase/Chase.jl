include("../Common.jl")
using GLMakie

w = 0.5 # Speed of "dog" object
tspan = (0,50); trange = range(0,stop = 50,length = 500)
u0 = [1.0;pi/2];

X = x -> sqrt(x)
Y = x -> sin(x) 

F = ((x,y),p,t) -> (@. w * normalize([X(t) - x; Y(t) - y]))

prob = ODEProblem(F,u0,tspan)
sol = solve(prob,Tsit5(),abstol = 1e-4,reltol=1e-4)

xs = @. X(trange); ys = @. Y(trange)
uxs = sol[1,1,:]
uys = sol[2,1,:]

framerate = 24

fig = Figure()
axis = Axis(fig[1, 1])

limits!(axis,
    minimum(vcat(xs,uxs)),
    maximum(vcat(xs,uxs)),
    minimum(vcat(ys,uys)),
    maximum(vcat(ys,uys))
    )

animate(fig[1,1],X.(sol.t),Y.(sol.t),uxs,uys,6)

return fig