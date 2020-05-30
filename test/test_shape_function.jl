function test_shape_function()
    radius = 1.0f0
    origin = Point3f0(0, 0, 0)
    mesh = icosphere(4, radius)
    n_samples = 10000
    min_all = 0
    max_a3 = pi
    max_d1 = 1.0f0
    max_d2 = 2.0f0
    # max_d3 =
    # max_d4 =
    res_a3 = a3fn(mesh, n_samples)
    res_d1 = d1fn(mesh, n_samples)
    res_d2 = d2fn(mesh, n_samples)
    res_d3 = d3fn(mesh, n_samples)
    res_d4 = d4fn(mesh, n_samples)
    @test isapprox(mean(res_d1), 1.0f0, atol = 0.001)
    @test isapprox(std(res_d1), 0.0f0, atol = 0.001)
end

