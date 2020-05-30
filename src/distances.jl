function distance(distfn, x::Vector{<:Number}, y::Vector{<:Number}, nbins = 200)
    min_x, max_x = extrema(x)
    min_y, max_y = extrema(y)
    min_val = min(min_x, min_y)
    max_val = max(max_x, max_y)
    val_range = range(min_val, stop = max_val, length = nbins)
    hist_x = fit(Histogram, x, val_range)
    hist_y = fit(Histogram, y, val_range)
    hist_x = normalize(hist_x, mode = :density)
    hist_y = normalize(hist_y, mode = :density)
    distance = distfn(hist_x.weights, hist_y.weights)
    return distance
end


