function centroid(
    verts::AbstractVector{Point{3,T1}},
) where {T1 <: Real}
    centroid_point = reduce(+, verts) / length(verts)
    return centroid_point
end
function centroid(mesh)
    verts = coordinates(mesh)
    centroid_point = centroid(verts)
end
function decompose_vertex_and_face(mesh)
    verts = coordinates(mesh)
    triangles = faces(mesh)
    return verts, triangles
end
function angle_between_vector(v1, v2)
    v1 = v1 / norm(v1)
    v2 = v2 / norm(v2)
    cos_theta = dot(v1, v2)
    if cos_theta >= 1.0
        return 0.0
    end
    theta = acos(cos_theta)
    return theta
end

function calculate_area_bins(verts::AbstractVector{Point{3,T1}},
            triangles::AbstractVector{<:TriangleFace},
            ) where T1 <: AbstractFloat
    areas_array = area.(Ref(verts), triangles)
    cumsum_area = similar(areas_array)
    cumsum_area = cumsum!(cumsum_area, areas_array)
    total_area = cumsum_area[end]
    bins = cumsum_area / total_area
    return bins
end

function triangle_area(p1::T, p2::T, p3::T) where {T <: AbstractVector}
    p1p2 = p2 - p1
    p1p3 = p3 - p1
    area = 0.5 * norm(cross(p1p2, p1p3))
    return area
end

function tetrahedron_volume(v1::T, v2::T, v3::T, v4::T) where {T <: AbstractVector}
    a = v1 - v4
    b = v2 - v4
    c = v3 - v4
    vol = norm(a ⋅ cross(b, c)) / 6
    return vol
end
