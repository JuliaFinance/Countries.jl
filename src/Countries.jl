module Countries

# Data obtained from https://datahub.io/core/country-codes
# Consider downloading data in build.jl?

using DelimitedFiles
using Currencies

export Currencies

const (data,headers) = readdlm(joinpath(@__DIR__,"data","country-codes.csv"),',',header=true)

struct Country{T} 
    function Country{T}() where T
        c = new()
        list[T] = c
        return c
    end
end
const list = Dict{Symbol,Country}()

const (nrow,ncol) = size(data)
for i in 1:nrow
    country = data[i,7]
    if length(country) == 2
        @eval begin
            $(Symbol(country)) = Country{Symbol($(country))}()
            name(::Country{Symbol($(country))}) = $(data[i,3])
            code(::Country{Symbol($(country))}) = $(data[i,9])
            capital(::Country{Symbol($(country))}) = $(data[i,29])
            continent(::Country{Symbol($(country))}) = $(data[i,30])
            isdeveloping(::Country{Symbol($(country))}) = isequal($(data[i,32]),"Developing")
            region(::Country{Symbol($(country))}) = $(data[i,50])
            subregion(::Country{Symbol($(country))}) = $(data[i,53])
            Base.show(io::Base.IO,::Country{Symbol($(country))}) = print(io,$(country))
            Base.show(io::Base.IO,::MIME"text/plain",::Country{Symbol($(country))}) = print(io,$(country))
        end
        ccys = Vector{Currencies.Currency}()
        currencies = split(data[i,10],",")
        for currency in currencies
            if isdefined(Currencies,Symbol(currency))
                @eval ccy = Currencies.$(Symbol(currency))
                push!(ccys,ccy)
            end
        end
        @eval currencies(::Country{Symbol($(country))}) = $(ccys)
    end
end

end # module
