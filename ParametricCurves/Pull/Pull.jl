using GLMakie
using DifferentialEquations
using LinearAlgebra 

x = range(start = 0,stop = 50,length = 200)

a = 2

X = x -> sin(x)
dX = x -> cos(x)
Y = y -> cos(y)
dY = y -> -sin(y)

F = ((x,y),p,t) -> (@. (dX(t) * (X(t) - x) + dY(t) * (Y(t) - y)) * [X(t) - x;Y(t) - y] / (a^2))

x0 = [X(0) - a; Y(0)]

ode = ODEProblem(F,x0,(0,50))
sol = solve(ode,Tsit5(),abstol = 1e-10, reltol = 1e-10)

xs = @. X(x)
ys = @. Y(x)

fig = Figure()
Axis(fig[1,1])

lines!(fig[1,1],xs,ys) 

ux = sol[1,1,:]
uy = sol[2,1,:]

lines!(fig[1,1],ux,uy)

return fig
