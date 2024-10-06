include("PlanePoints.jl");
include("PlaneFit.jl")
include("PlanePlot.jl")

function Demo()
    # Parameters: 
    n = [0.,1.,0.5];
    c = -2.;
    rangeX = LinRange(-5.,5.,12);
    rangeY = LinRange(-5.,5.,5);
    noise = 1.5;

    ps = planepoints(n,c,rangeX,rangeY,noise);
    xs, ys, zs = get_sep_coords(ps);
    
    c, n = planefit(xs,ys,zs);

    rangeXMore = LinRange(-8.,8.,90)
    rangeYMore = LinRange(-8.,8.,90)

    plotplane_withpoints(xs,ys,zs,c,n,rangeXMore,rangeYMore);

end