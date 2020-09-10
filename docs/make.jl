using DenseSynchrony
using Documenter

makedocs(;
    modules=[DenseSynchrony],
    authors="anandijain <anandj@uchicago.edu> and contributors",
    repo="https://github.com/anandijain/DenseSynchrony.jl/blob/{commit}{path}#L{line}",
    sitename="DenseSynchrony.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://anandijain.github.io/DenseSynchrony.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/anandijain/DenseSynchrony.jl",
)
