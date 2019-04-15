using Documenter, FinEconResearchUtils

makedocs(;
    modules=[FinEconResearchUtils],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/tbeason/FinEconResearchUtils.jl/blob/{commit}{path}#L{line}",
    sitename="FinEconResearchUtils.jl",
    authors="Tyler Beason",
    assets=[],
)

deploydocs(;
    repo="github.com/tbeason/FinEconResearchUtils.jl",
)
