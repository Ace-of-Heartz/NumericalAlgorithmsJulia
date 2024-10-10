include("../Common.jl")
using GLMakie

w = 0.8 # Speed of "dog" object
tspan = (0,50); trange = range(0,stop = 50,length = 500)
u0 = [1.0;pi/2];

X = x -> x
Y = x -> sin(x)

F = ((x,y),p,t) -> (@. w * normalize([X(t) - x; Y(t) - y]))

prob = ODEProblem(F,u0,tspan)
sol = solve(prob,Tsit5(),abstol = 1e-5,reltol=1e-5)

xs = @. X(trange); ys = @. Y(trange)
uxs = sol[1,1,:]
uys = sol[2,1,:]


nframes = 30
framerate = 24

fig = Figure()
axis = Axis(fig[1, 1])

points = Observable(Point2f[(0,0)])

lineplot = lines(points,color = :red)

record(fig,"chase_anim.gif",(xs,ys);
    framerate = framerate) do frame 
        new_point = Point2f(frame)
        points[] = push!(points[],new_point)
    end


lines!(fig[1,1],uxs,uys, color = :blue) 

return fig