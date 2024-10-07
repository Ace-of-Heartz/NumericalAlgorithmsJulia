using GLMakie
using DifferentialEquations
using LinearAlgebra 

x = range(0,20,100)
y = @. cos(x)

a = 1.

X = x -> x 
DX = x -> 1  
Y = y -> cos(y)
DY = y -> -sin(y)

w1 = (t,x,y) -> (X(t) - x) / (norm([X(t) - x, Y(t) - y]))
w2 = (t,x,y) -> (Y(t) - y) / (norm([X(t) - x, Y(t) - y]))  

F = (y,p,t) -> (abs(DX(t) * w1(t,y[1],y[2]) + DY(t) * w2(t,y[1],y[2])) / a ).* [X(t) - y[1],Y(t) - y[2]]

x0 = [1.;1.]
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
