with 
    source_address1 as (
        select 
              cast (addressid as int) as id_endereco
            , cast (stateprovinceid as int) as id_estado
            , cast (city as string) as cidade
            --, addressline1					
            --, addressline2							
            --, postalcode					
            --, spatiallocation					
            --, rowguid					
            --, modifieddate		
        
        from {{ source('erp', 'address') }}
    )
select * 
from source_address1    