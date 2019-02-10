module Countries

# Data obtained from https://datahub.io/core/country-codes
# Consider downloading data in build.jl?

using ISOCurrencies, DelimitedFiles

struct Country
    name::String
    code::Int
    currency::Currencies.Currency
    capital::String
    continent::String
    developed::Bool
    region::String
    subregion::String
end

const (data,headers) = readdlm(joinpath(@__DIR__,"data","country-codes.csv"),',',header=true)

const (nrow,ncol) = size(data)
for i in 1:nrow
    country = data[i,7]
    currency = data[i,10]
    # This will ignore countries with more than one official currency
    if ((length(country) == 2) & isdefined(Currencies,Symbol(currency)))
        @eval $(Symbol(data[i,7])) = Country(
            $(data[i,3]),
            $(data[i,9]),
            Currencies.$(Symbol(currency)),
            $(data[i,29]),
            $(data[i,30]),
            $(isequal(data[i,32],"Developed")),
            $(data[i,50]),
            $(data[i,53])
        )
    end
end

end # module
