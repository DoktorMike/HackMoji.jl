using HackMoji
using Documenter

makedocs(;
    modules=[HackMoji],
    authors="Michael Green <micke.green@gmail.com> and contributors",
    repo="https://github.com/DoktorMike/HackMoji.jl/blob/{commit}{path}#L{line}",
    sitename="HackMoji.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://DoktorMike.github.io/HackMoji.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/DoktorMike/HackMoji.jl",
)
