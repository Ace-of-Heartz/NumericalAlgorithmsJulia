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

# points1 = Observable(Point2f[(xs[1],ys[1])])
# points2 = Observable(Point2f[(uxs[1],uys[1])])

# lines!(fig[1,1],points1,color = :red)

# lines!(fig[1,1],points2, color = :blue) 

# frames = 1:length(uxs);

# print(length(uxs))

# record(fig,"chase_anim.gif",frames;
#     framerate = framerate) do k
#         t = sol.t[k]

#         new_point1 = Point2f(X(t),Y(t))
#         new_point2 = Point2f(uxs[k],uys[k])
#         points1[] = push!(points1[], new_point1)
#         points2[] = push!(points2[], new_point2)
#     end





return fig