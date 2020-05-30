function test_point_sampling()
    radius = 1.0f0
    origin = Point3f0(0, 0, 0)
    mesh = icosphere(4, radius)
    verts = coordinates(mesh)
    triangles = faces(mesh)
    areas_array = area.(Ref(verts), triangles)
    cumsum_area = similar(areas_array)
    cumsum_area = cumsum!(cumsum_area, areas_array)
    total_area = cumsum_area[end]
    bins = cumsum_area / total_area
    point1 = point_sampling(verts, triangles, bins)
    d_point1 = norm(point1 - origin)
    @test isapprox(d_point1, radius, atol = 0.001)
    points1 = points_sampling(mesh, 10000)
    points_dist = norm.(points1)
    mean_dist = mean(points_dist)
    sd_dist = std(points_dist)
    @test isapprox(mean_dist, 1.0f0, atol = 0.001)
    @test isapprox(sd_dist, 0.0f0, atol = 0.001)
end
