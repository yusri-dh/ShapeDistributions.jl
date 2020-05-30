function point_sampling_triangle(v1, v2, v3)
    r1, r2 = rand(2)
    sqrt_r1 = sqrt(r1)
    point = (1 - sqrt_r1) * v1
    point += sqrt_r1 * (1 - r2) * v2
    point += sqrt_r1 * r2 * v3
    return point
end

function point_sampling(
    verts::AbstractVector{<:AbstractPoint{3,T1}},
    triangles::AbstractVector{<:TriangleFace},
    bins::AbstractVector{<:Real}) where T1 <: AbstractFloat
    # @assert issorted(bins) "Last argument must be sorted in increasing order"
    # @assert isapprox(bins[end], 1.0) "The last element must be 1.0"
    random_number = rand()
    idx = searchsortedfirst(bins, random_number)
    face = triangles[idx]
    v1, v2, v3 = verts[face[1]], verts[face[2]], verts[face[3]]
    point = point_sampling_triangle(v1, v2, v3)
    return point
end


function points_sampling(
    verts::AbstractVector{<:AbstractPoint{3,T1}},
    triangles::AbstractVector{<:TriangleFace},
    n_sample::Int) where T1 <: AbstractFloat
    @assert n_sample > 0 "n must be a positive integer"
    areas_array = area.(Ref(verts), triangles)
    cumsum_area = similar(areas_array)
    cumsum_area = cumsum!(cumsum_area, areas_array)
    total_area = cumsum_area[end]
    bins = cumsum_area / total_area
    random_numbers = rand(n_sample)
    idx = searchsortedfirst.(Ref(bins), random_numbers)
    selected_triangles = triangles[idx]
    points = Vector{Point{3,T1}}(undef, n_sample)
    for i in 1:n_sample
        face = selected_triangles[i]
        v1, v2, v3 = verts[face[1]], verts[face[2]], verts[face[3]]
        points[i] = point_sampling_triangle(v1, v2, v3)
    end
    return points
end

function points_sampling(mesh::Mesh, n_sample)
    verts = coordinates(mesh)
    triangles = faces(mesh)
    return points_sampling(verts, triangles, n_sample)
end
