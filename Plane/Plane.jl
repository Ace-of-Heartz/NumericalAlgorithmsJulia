include("PlanePoints.jl");
include("PlaneFit.jl")
include("PlanePlot.jl")

function Demo()
    # Parameters: 
    n = [1.,1.,1.];
    c = -2.;
    rangeX = LinRange(-5.,5.,20);
    rangeY = LinRange(-5.,5.,20);
    noise = 0.3;

    ps = planepoints(n,c,rangeX,rangeY,noise);
    xs, ys, zs = get_sep_coords(ps);
    
    c, n = planefit(xs,ys,zs);

    plotplane_withpoints(xs,ys,zs,c,n,(-5.,5.),(-5.,5.));

end