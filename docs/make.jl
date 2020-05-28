using ShapeDistributions
using Documenter

makedocs(;
    modules=[ShapeDistributions],
    authors="Yusri Dwi Heryanto",
    repo="https://github.com/yusri-dh/ShapeDistributions.jl/blob/{commit}{path}#L{line}",
    sitename="ShapeDistributions.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://yusri-dh.github.io/ShapeDistributions.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/yusri-dh/ShapeDistributions.jl",
)
