##
using ShapeDistributions
using FileIO
using GeometryBasics
# using Makie
# using Plots
using Distributions
using StatsBase
using LinearAlgebra
using Statistics
##
url = "https://github.com/libigl/libigl-tutorial-data/raw/master/bumpy-cube.obj"
fname = download(url)
mesh1 = load(File{format"OBJ"}(fname))
##
mesh1 = load("./data/airplane1.obj")
mesh2 = load("./data/airplane2.obj")
res1 = a3fn(mesh1, 1000)
res2 = a3fn(mesh2, 1000)
val_range = range(0, stop = 3.3, length = 200)
hist1 = fit(Histogram, res1, val_range)
hist2 = fit(Histogram, res2, val_range)

##
verts = coordinates(mesh1)
triangles = faces(mesh1)
triangles_int = decompose(TriangleFace{Int}, shape_mesh)
areas_array = area.(Ref(verts), triangles)
cumsum_area = similar(areas_array)
cumsum_area = cumsum!(cumsum_area, areas_array)
total_area = cumsum_area[end]
bins = cumsum_area / total_area
sampling_points = points_sampling(shape_mesh, 1000)
ShapeDistributions.point_sampling(shape_mesh, bins)
res_a3 = a3fn(shape_mesh, 10000)

##
using Profile
Profile.clear()
@profile d4fn(verts, triangles, 1000)
# @profile points_sampling(shape_mesh, 1000)
owntime(stackframe_filter = stackframe->stackframe.func == :D4fn)
##
owntime(stackframe_filter = stackframe->stackframe.func == :point_sampling)
##
radius = 1.0f0
origin = Point3f0(0, 0, 0)
mesh = icosphere(4, radius)
verts = coordinates(mesh)
triangles = faces(mesh)
sampling_points = points_sampling(mesh, 10000)
areas_array = area.(Ref(verts), triangles)
cumsum_area = similar(areas_array)
cumsum_area = cumsum!(cumsum_area, areas_array)
total_area = cumsum_area[end]
bins = cumsum_area / total_area
n_samples = 10000
res_a3 = a3fn(mesh, n_samples)
res_d1 = d1fn(mesh, n_samples)
res_d2 = d2fn(mesh, n_samples)
res_d3 = d3fn(mesh, n_samples)
res_d4 = d4fn(mesh, n_samples)
##
