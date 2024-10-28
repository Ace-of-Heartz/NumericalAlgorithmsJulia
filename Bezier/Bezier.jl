

"""
    de_casteljau(t,xs) :: AbstractMatrix{<:AbstractVector{<:Number}}, where 
    t :: Number - t ∈ [0,1]
    ps :: AbstractVector{<:AbstractVector{<:Number}} - Two dimensional controlpoints of the Bézier-curve

    Calculates and returns a point of the specified Bézier-curve at value `t`.
     
"""
function de_casteljau(
    t :: Number,
    ps :: AbstractVector{<:AbstractVector{<:Number}}
    ) :: Point
    n = length(ps)
    
    bs_old = ps
    bs_new = []
    for j = 1:n
        for i = 1:n-j
            push!(bs_new, bs_old[i] .* (1 - t) + bs_old[i+1] .* t)
        end

        if length(bs_new) == 0
            break
        end
        bs_old = bs_new
        bs_new = []

    end
    
    return Point2f(bs_old[1])
end

"""
    de_casteljau_mtx(t,xs) :: AbstractMatrix{<:AbstractVector{<:Number}}, where 
    t :: Number - t ∈ [0,1]
    ps :: AbstractVector{<:AbstractVector{<:Number}} - Two dimensional controlpoints of the Bézier-curve
    
    Calculates and returns the lower triangularmatrix form of the results of the De-Casteljau algorithm.
    Do not use this for calculating the Bézier-curve itself. 
    Use the `de_casteljau(t,xs)` function for that.
     
"""
function de_casteljau_mtx(
    t :: Number,
    ps :: AbstractVector{<:AbstractVector{<:Number}}
    ) :: AbstractMatrix{<:AbstractVector{<:Number}}
    n = length(ps)

    mtx = ones(n,n) .* ps

    for j = 2:n 
        for i = j:n 
            mtx[i,j] = mtx[(i-1),j-1] .* (1-t) + mtx[i,j-1] .* t  
        end
    end

    return mtx

end

"""
    constr_sub_curve(t,ps) :: AbstractVector{<:AbstractVector{<:Number}}, where 
    t :: Number - t ∈ [0,1]
    ps :: AbstractVector{<:AbstractVector{<:Number}} - Two dimensional controlpoints of the Bézier-curve

    Constructs the controlpoints of a Bézier-curve ranging from 0 to `t`, while also approximating the original Bézier-curve in this range.
     
"""
function constr_sub_curve(
    t :: Number,
    ps :: AbstractVector{<:AbstractVector{<:Number}},
    ) :: AbstractVector{<:AbstractVector{<:Number}}
    
    ns = 1:1:length(ps)
    new_ps = map(n -> de_casteljau(t,ps[1:n]),ns)

    return new_ps
end


"""
    elevate_bezier(xs) :: AbstractVector{<:AbstractVector{<:Number}}, where 
    ps :: AbstractVector{<:AbstractVector{<:Number}} - Two dimensional controls points of Bézier-curves

    Elevates the degree of an `n` degree Bézier-curve by 1.
      
"""
function elevate_bezier(
    ps :: AbstractVector{<:AbstractVector{<:Number}}
    ) :: AbstractVector{<:AbstractVector{<:Number}}
    n = length(ps)

    new_xs = ones(n + 1)

    new_xs[1] = ps[0]
    new_xs[n+1] = ps[n]
    
    for k = 2:n
        new_xs[k] = k/(n+1) *  ps[k-1] + (1 - k/(n+1)) * ps[k]
    end

    return new_xs
end


"""
    bezier2d(xs,t_max,t_step) :: AbstractVector{<:Point}, where 
    ps :: AbstractVector{<:AbstractVector{<:Number}} - Two dimensional controlpoints of the Bézier-curve.
    t_max :: Number - Maximum value of `t` ∈ [0,1], with which the function calculates the points of the curve.
    t_step :: Number - Stepsize between the `t` ∈ [0,1] values. Lower values result in smoother curves, while higher values require less computation.

    Calculates the points of the specified Bézier-curve.
     
"""
function bezier2d(
    ps :: AbstractVector{<:AbstractVector{<:Number}},
    t_max  :: Number = 1,
    t_step :: Number = 0.01 
) :: AbstractVector{<:Point}
    frames = 0:t_step:t_max    
    ts  = map(t -> de_casteljau(t,ps),frames)
    return ts
end



