function a3fn(verts::AbstractVector{<:AbstractPoint{3,T1}},
            triangles::AbstractVector{<:TriangleFace},
            n_samples::Int) where T1 <: AbstractFloat
    bins = calculate_area_bins(verts, triangles)
    angles = Vector{Float64}(undef, n_samples)
    @inbounds for i in 1:n_samples
        points = [point_sampling(verts, triangles, bins) for _ in 1:3]
        v1 = points[2] - points[1]
        v2 = points[3] - points[1]
        angles[i] = angle_between_vector(v1, v2)
    end
    return angles
end
function a3fn(mesh::Mesh, n_samples::Int)
    verts, triangles = decompose_vertex_and_face(mesh)
    return a3fn(verts, triangles, n_samples)
end
function d1fn(verts::AbstractVector{<:AbstractPoint{3,T1}},
            triangles::AbstractVector{<:TriangleFace},
            n_samples::Int) where T1 <: AbstractFloat
    bins = calculate_area_bins(verts, triangles)
    centroid_point = centroid(verts)
    distances = Vector{Float64}(undef, n_samples)
    @inbounds for i in 1:n_samples
        point = point_sampling(verts, triangles, bins)
        distances[i] = euclidean(centroid_point, point)
    end
    return distances
end
function d1fn(mesh::Mesh, n_samples::Int)
    verts, triangles = decompose_vertex_and_face(mesh)
    return d1fn(verts, triangles, n_samples)
end
function d2fn(verts::AbstractVector{<:AbstractPoint{3,T1}},
            triangles::AbstractVector{<:TriangleFace},
            n_samples::Int) where T1 <: AbstractFloat
    bins = calculate_area_bins(verts, triangles)
    distances = Vector{Float64}(undef, n_samples)
    @inbounds for i in 1:n_samples
        points = [point_sampling(verts, triangles, bins) for _ in 1:2]
        distances[i] = euclidean(points[1], points[2])
    end
    return distances
end
function d2fn(mesh::Mesh, n_samples::Int)
    verts, triangles = decompose_vertex_and_face(mesh)
    return d2fn(verts, triangles, n_samples)
end
function d3fn(verts::AbstractVector{<:AbstractPoint{3,T1}},
            triangles::AbstractVector{<:TriangleFace},
            n_samples::Int) where T1 <: AbstractFloat
    bins = calculate_area_bins(verts, triangles)
    sqrt_areas = Vector{Float64}(undef, n_samples)
    @inbounds for i in 1:n_samples
        points = [point_sampling(verts, triangles, bins) for _ in 1:3]
        area = triangle_area(points[1], points[2], points[3])
        sqrt_areas[i] = sqrt(area)
    end
    return sqrt_areas
end
function d3fn(mesh::Mesh, n_samples::Int)
    verts, triangles = decompose_vertex_and_face(mesh)
    return d3fn(verts, triangles, n_samples)
end
function d4fn(verts::AbstractVector{<:AbstractPoint{3,T1}},
            triangles::AbstractVector{<:TriangleFace},
            n_samples::Int) where T1 <: AbstractFloat
    bins = calculate_area_bins(verts, triangles)
    cbrt_vols = Vector{Float64}(undef, n_samples)
    @inbounds for i in 1:n_samples
        points = [point_sampling(verts, triangles, bins) for _ in 1:4]
        vol = tetrahedron_volume(points[1], points[2], points[3], points[4])
        cbrt_vols[i] = cbrt(vol)
    end
    return cbrt_vols
end
function d4fn(mesh::Mesh, n_samples::Int)
    verts, triangles = decompose_vertex_and_face(mesh)
    return d4fn(verts, triangles, n_samples)
end
