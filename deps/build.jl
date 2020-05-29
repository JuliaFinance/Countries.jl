import Pkg; Pkg.add("JSON3") # Just in case

using JSON3

const src = "https://pkgstore.datahub.io/core/country-codes/country-codes_json/data/471a2e653140ecdd7243cdcacfd66608/country-codes_json.json"

inputname = joinpath(@__DIR__, "country-codes.json")
outputname = joinpath(@__DIR__, "country-data.jl")

# First, check if currency-data.jl already exists
isfile(outputname) && return

# Only download the file from datahub.io if not already present
if !isfile(inputname)
    println("Downloading currency data: ", src)
    download(src, inputname)
end

const country_list = open(io -> JSON3.read(io), inputname)

function genfile(io)
    println(io, "const _country_data = Dict(")
    for c in country_list
        isnothing(c["official_name_en"]) && continue
        isnothing(c["ISO3166-1-Alpha-2"]) && continue
        isnothing(c["ISO4217-currency_alphabetic_code"]) && continue
        country = c["ISO3166-1-Alpha-2"]
        official_name = c["official_name_en"]
        code = c["ISO3166-1-numeric"]
        currencies = Symbol.(split(c["ISO4217-currency_alphabetic_code"],","))
        capital = c["Capital"]
        continent = c["Continent"]
        isdeveloping = isequal(c["Developed / Developing Countries"],"Developing")
        region = c["Region Name"]
        subregion = c["Sub-region Name"]
        print(io, "    :$(country) => (Country{:$(country)}(),",
            "\"$(official_name)\",",
            code,",",
            currencies,",",
            "\"$(capital)\",",
            "\"$(continent)\",",
            isdeveloping,",",
            "\"$(region)\",",
            "\"$(subregion)\"),\n")
    end
    println(io, ")\n")
end

open(io -> genfile(io), outputname, "w")

