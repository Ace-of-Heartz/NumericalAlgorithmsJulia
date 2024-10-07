using GLMakie
using DifferentialEquations

x = range(0,15,100)
y = @. cos(x)

a = 1.

X = x -> x 
Y = (y) -> cos(y)
F = (y,p,t) -> sqrt()

x0 = 0


ode = ODEProblem(F,p,x0)
sol = solve(ode)

plot(sol)