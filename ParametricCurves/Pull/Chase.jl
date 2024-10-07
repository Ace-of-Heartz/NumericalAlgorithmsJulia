include("../Common.jl")
using GLMakie

w = 0.5 # Speed of "dog" object
tspan = (1,50); trange = range(0,50)
u0 = [0.0; 0.0]

X = x -> x
Y = x -> sin(x)

F = ((x,y),p,t) -> (@. w / norm([X(t) - x; Y(t) - y]) * [X(t) - x; Y(t) - y]) 

prob = ODEProblem(F,u0,tspan)
sol = solve(prob)

xs = @. X(trange); ys = @. Y(trange)
uxs = sol[1,1,:]
uys = sol[2,1,:]


fig = Figure()
axis = Axis(fig[1,1])

scatter!(fig[1,1],xs,ys,color = :red)
scatter!(fig[1,1],uxs,uys, color = :blue) 

return fig