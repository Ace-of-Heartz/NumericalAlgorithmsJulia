function mtx_surface(
    mtx #:: AbstractMatrix
) :: Tuple{<:AbstractVector{<:Point},<:AbstractVector{<:Number} }



m = length(mtx)
n = length(mtx[1])
offsetX = 1; offsetY = 1

vertices = []
indices = []

for i = 1:m 
    for j = 1:n 
        push!(vertices,mtx[i][j])
    end
end

for i = 1:m-1 
    for j = 1:n-1 
        push!(indices, (i - 1) * m + j)
        push!(indices, (i + offsetY - 1) * m + j)
        push!(indices, (i + offsetY - 1) * m + j + offsetX)
        push!(indices, (i - 1) * m + j + offsetX)
    end
end

return (vertices,indices)
end