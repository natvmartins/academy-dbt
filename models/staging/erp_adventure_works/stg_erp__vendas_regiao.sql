with 
    source_salesterritory as (
        select 
            cast(territoryid as int) as id_regiao	
            , cast(name as string) as nome_regiao			
            , cast(countryregioncode as string) as codigo_pais
            --, group			
            --, salesytd			
            --, saleslastyear			
            --, costytd			
            --, costlastyear			
            --, rowguid			
            --, modifieddate
        
        from {{ source('erp', 'salesterritory') }}
    )
select * 
from salesterritory   