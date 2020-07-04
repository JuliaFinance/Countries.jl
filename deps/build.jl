const outputname = joinpath(@__DIR__, "country-data.jl")

# First, check if currency-data.jl already exists
isfile(outputname) && exit()

using JSON3

const src = "https://pkgstore.datahub.io/core/country-codes/country-codes_json/data/471a2e653140ecdd7243cdcacfd66608/country-codes_json.json"

inputname = joinpath(@__DIR__, "country-codes.json")

const country_list = Dict{String,Tuple}()

function genfile(io)
    for c in country_data
        (cntry = c["ISO3166-1-Alpha-2"]) === nothing && continue
        (nm = c["official_name_en"]) === nothing && continue
        (cd = c["ISO3166-1-numeric"]) === nothing && continue
        ccy_str = c["ISO4217-currency_alphabetic_code"]
        ccy = ccy_str === nothing ? Symbol[] : Symbol.(split(ccy_str,","))
        d = c["Dial"]
        cap = c["Capital"]
        cont = c["Continent"]
        isdev = isequal(c["Developed / Developing Countries"],"Developing")
        reg = c["Region Name"]
        sreg = c["Sub-region Name"]

        country_list[cntry] = (nm,cd,ccy,d,cap,cont,isdev,reg,sreg)
    end
    println(io, "const _country_data = Dict(")
    for (c, val) in country_list
        # println(io, "    :$curr => (Currency{:$curr}, $(val[1]), $(lpad(val[2], 4)), \"$(val[3])\"),")
        
        print(io, "    :$c => (Country{:$c},",
            "\"$(val[1])\",",
            val[2],",",
            val[3],",",
            "\"$(val[4])\",",
            "\"$(val[5])\",",
            "\"$(val[6])\",",
            val[7],",",
            "\"$(val[8])\",",
            "\"$(val[9])\"),\n")
    end
    println(io, ")\n")

    #     print(io, "    :$(country) => (Country{:$(country)},",
    #         "\"$(official_name)\",",
    #         code,",",
    #         currencies,",",
    #         "\"$(dial)\",",
    #         "\"$(capital)\",",
    #         "\"$(continent)\",",
    #         isdeveloping,",",
    #         "\"$(region)\",",
    #         "\"$(subregion)\"),\n")
    # end
    # println(io, ")\n")
end

const country_data = open(io -> JSON3.read(io), inputname)

open(io -> genfile(io), outputname, "w")

