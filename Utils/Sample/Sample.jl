function create_sample(
    xs      :: Array{<:Number},
    f       :: Function,
    noise   :: Function,
) :: Array{<:Number}

ys = @. f(xs) 
ns = noise(size(ys))
end
