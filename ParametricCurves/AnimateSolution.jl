function animate(
    placement,
    xs,ys,
    uxs,uys,
    stepsize,
    )

xn = length(xs); yn = length(ys); uxn = length(uxs); uyn = length(uys);

if (xn != yn || xn != uxn || xn != uyn)
    error("Length of input vectors aren't equal!")
end

points1 = Observable(Point2f[(xs[1],ys[1])])
points2 = Observable(Point2f[(uxs[1],uys[1])])

lines!(placement,points1, color = :red)

lines!(placement,points2, color = :blue) 

frames = zip(xs[1 + stepsize:stepsize:xn],ys[1 + stepsize:stepsize:xn],uxs[1 + stepsize:stepsize:xn],uys[1 + stepsize:stepsize:xn])

record(fig,"chase_anim.gif", frames;
    framerate = framerate) do (x,y,ux,uy)

        new_point1 = Point2f(x,y)
        new_point2 = Point2f(ux,uy)
        points1[] = push!(points1[], new_point1)
        points2[] = push!(points2[], new_point2)
    end
end