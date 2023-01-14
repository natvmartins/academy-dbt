with 
    source_store as (
        select 
            cast(businessentityid as int) as id_loja
            , cast(name as string) as nome_loja			
            , cast(salespersonid as int) as id_vendedor			
            --, demographics			
            --, rowguid			
            --, modifieddate
       
        from {{ source('erp', 'store') }}
    )
select * 
from source_store
