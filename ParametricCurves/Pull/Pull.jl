using GLMakie
using DifferentialEquations
using LinearAlgebra 

x = range(0,20,100)
y = @. cos(x)

a = 1.

X = x -> x 
dX = x -> 1  
Y = y -> cos(y)
dY = y -> -sin(y)

F = ((x,y),p,t) -> (@. (dX(t) * (X(t) - x) + dY(t) * (Y(t) - y)) * [X(t) - x,Y(t) - y] / a^2)

x0 = [X(0) + a; Y(0)]
p = [1.;1.]

ode = ODEProblem(F,x0,(0,20))
sol = solve(ode)

xs = @. X(x)
ys = @. Y(x)

fig = Figure()
Axis(fig[1,1])

lines!(fig[1,1],xs,ys) 

lines!(fig[1,1],sol[1,:])

return fig
