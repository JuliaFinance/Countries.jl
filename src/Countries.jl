"""
Countries

This package provides the `Country` singleton type, based on the ISO 3166 standard
together with ten methods:

- `symbol`: The 2-character ISO 3166 alpha symbol of the country.
- `country`: The singleton type instance for a particular country symbol
- `name`: The full name of the country.
- `code`: The ISO 3166 code for the country.
- `currencies`: An array of ISO 4167 alpha currency symbols for the country.
- `capital`: The capital of the country.
- `continent`: The continent of the country.
- `isdeveloping`: Whether the country is developed or is developing (boolean).
- `region`: The region of the country.
- `subregion`: The subregion of the country.

See README.md for the full documentation

Copyright 2019-2020, Eric Forgy, Scott P. Jones and other contributors

Licensed under MIT License, see LICENSE.md
"""
module Countries

export Country

"""
This is a singleton type, intended to be used as a label for dispatch purposes
"""
struct Country{S} end
Country(
    symbol::Symbol,
    name::AbstractString,
    code::Integer,
    capital::AbstractString,
    continent::AbstractString,
    isdeveloping::Bool,
    region::AbstractString,
    subregion::AbstractString) = 
    (get!(_country_data, symbol) do
        (
            Country{symbol}(),
            name,
            code,
            capital,
            continent,
            isdeveloping,
            region,
            subregion
        )
    end)[1]

include(joinpath(@__DIR__, "..", "deps", "country-data.jl"))

for (s,(country,_,_,_,_,_,_,_,_)) in _country_data
    @eval const $s = $country
end

"""
Returns the 2-character ISO 3166 alpha symbol associated with the country
"""
function symbol end

"""
Returns an instance of the singleton type Country{symbol}
"""
function country end

"""
Returns the name associated with this value
"""
function name end

"""
Returns the ISO 3166 numeric code associated with this value
"""
function code end

"""
Returns the capital associated with this value
"""
function capital end

"""
Returns the continent associated with this value
"""
function continent end

"""
Returns `true` if the country is developing and `false` if developed.
"""
function isdeveloping end

"""
Returns the region associated with this value
"""
function region end

"""
Returns the subregion associated with this value
"""
function subregion end

symbol(::Country{S}) where {S} = S
country(S::Symbol) = _country_data[S][1]
ms = [:name, :code, :currencies, :capital, :continent, :isdeveloping, :region, :subregion]
for (i,m) in enumerate(ms)
    @eval $m(S::Symbol) = _country_data[S][$(i+1)]
    @eval $m(::Country{S}) where {S} = $m(S)
end

allsymbols()  = keys(_country_data)
allpairs() = pairs(_country_data)

end # module Countries
