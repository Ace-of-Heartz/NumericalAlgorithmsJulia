using GLMakie

function plotplane_withpoints(
    xs :: AbstractVector{<:Number},
    ys :: AbstractVector{<:Number},
    zs :: AbstractVector{<:Number},
    c  :: Number,
    n  :: AbstractVector{<:Number},
    rangeX :: Tuple{<:Number,<:Number},
    rangeY :: Tuple{<:Number,<:Number},
    )
    n = n / norm(n,2)

    p = n .* -c

    n1, n2, n3 = n

    i =  [-n2,n1,n3]   
    j = cross(i,n)


    # tx = collect(rangeX)
    # ty = collect(rangeY)

    # m1 = length(tx)
    # m2 = length(ty)

    # tx = repeat(tx,inner = m2)
    # ty = repeat(ty,outer = m1)


    # txs = tx * i'
    # tys = ty * j'

    # ts = txs + tys

    vertices = [rangeX[1] rangeY[1]; rangeX[1] rangeY[2]; rangeX[2] rangeY[1]; rangeX[2] rangeY[2]]

    print(p)
    ps = ones(4,1) * p' + vertices

    print(ps)

    xxs = ps[:,1]
    yys = ps[:,2]
    zzs = ps[:,3]

    f = Figure()

    # tx = [p[1] + rangeX[1] * i[1], p[1] + rangeX[2] * i[1],p[1] + rangeX[1] * j[1], p[1] + rangeX[2] * j[1]]
    # ty = [p[2] + rangeY[1] * i[2], p[2] + rangeY[2] * i[2],p[2] + rangeY[1] * j[2], p[2] + rangeY[2] * j[2]]
    # tz = [p[3] + rangeZ[1] * i[3], p[3] + rangeZ[2] * i[3],p[3] + rangeZ[1] * j[3], p[3] + rangeZ[2] * j[3]]
    ax = Axis3(f[1, 1])
    scatter!(f[1, 1],xs,ys,zs)
    #TODO: Fix surface plot

    #surface!(f[1,1],xxs,yys,zzs)

    return f

end