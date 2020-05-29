using ShapeDistributions
using FileIO
using GeometryBasics
url = "https://github.com/libigl/libigl-tutorial-data/raw/master/bumpy-cube.obj"
fname = download(url)
shape_mesh = load(File{format"OBJ"}(fname))

verts = coordinates(shape_mesh)
triangles = faces(shape_mesh)
triangles_int = decompose(TriangleFace{Int}, shape_mesh)
areas_array = area.(Ref(verts), triangles)
cumsum_area = similar(areas_array)
cumsum_area = cumsum!(cumsum_area, areas_array)
total_area = cumsum_area[end]
bins = cumsum_area / total_area
sampling_points = points_sampling(shape_mesh, 1000)
ShapeDistributions.point_sampling(shape_mesh, bins)
