include("LinPoints.jl")
include("LinFit.jl")
include("LinPlot.jl")

n0 = [1.,0.]
c0 = -2.
t = LinRange(-10.,10.,20)
noise = 0.1


ps = linpoints(n0,c0,t,noise)

xs = ps[:,1]
ys = ps[:,2]

c, n = linfit(xs,ys)

lims = [-10.0 10.0]

plotline_withpoints(xs,ys,c,n,lims)