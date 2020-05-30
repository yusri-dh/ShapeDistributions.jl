using ShapeDistributions
using GeometryBasics
using LinearAlgebra
using Statistics
using Test
include("test_distances.jl")
include("test_sampling.jl")
include("test_shape_function.jl")
include("test_utils.jl")

@testset "ShapeDistributions.jl" begin
    test_point_sampling()
    test_shape_function()
end
