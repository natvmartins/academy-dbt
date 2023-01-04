with 
    source_countryregion as (
        select 
            cast(countryregioncode as string) as codigo_regiao_pais		
            , cast(name as string) as nome_pais
            --, modifieddate
       
        from {{ source('erp', 'countryregion') }}
    )
select * 
from source_countryregion