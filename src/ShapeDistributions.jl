module ShapeDistributions

using GeometryBasics
using FileIO
using LinearAlgebra
using Distances
using StatsBase

include("./sampling.jl")
export points_sampling,point_sampling
include("./utils.jl")
include("./shape_function.jl")
export d1fn,d2fn,d3fn,d4fn,a3fn
include("./distances.jl")
export distance
include("./sphere.jl")
export icosphere
end
