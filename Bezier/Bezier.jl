
function de_casteljau(t,xs)
    n = length(xs)
    
    bs_old = xs
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

function de_casteljau_mtx(t,xs)
    n = length(xs)

    mtx = ones(n,n) .* xs

    for j = 2:n 
        for i = j:n 
            mtx[i,j] = mtx[(i-1),j-1] .* (1-t) + mtx[i,j-1] .* t  
        end
    end

    return mtx

end

function constr_sub_curve(
    xs,
    t :: Number 
    ) 
    
    ns = 1:1:length(xs)
    new_xs = map(n -> de_casteljau(t,xs[1:n]),ns)

    return new_xs
end

function elevate(xs)
    n = length(xs)

    new_xs = ones(n + 1)

    new_xs[1] = xs[0]
    new_xs[n+1] = xs[n]
    
    for k = 2:n
        new_xs[k] = k/(n+1) *  xs[k-1] + (1 - k/(n+1)) * xs[k]
    end

    return new_xs
end

function bezier2d(
    xs,
    t_max = 1,
    t_step = 0.01
) 
    frames = 0:t_step:t_max    
    ts  = map(t -> de_casteljau(t,xs),frames)
    return ts
end



