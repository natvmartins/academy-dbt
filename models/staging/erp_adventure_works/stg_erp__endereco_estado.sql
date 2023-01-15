with 
    source_stateprovince as (
        select 
            cast(stateprovinceid as int ) as id_estado 	
            , cast(territoryid as int) as id_regiao		
            , cast(stateprovincecode as string) as codigo_estado 			
            , cast(countryregioncode as string) as codigo_regiao_pais	
            , cast(name as string) as nome_estado
            --, isonlystateprovinceflag		
            --, rowguid			
            --, modifieddate
       
        from {{ source('erp', 'stateprovince') }}
    )
select * 
from source_stateprovince