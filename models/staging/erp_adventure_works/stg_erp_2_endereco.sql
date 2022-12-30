with 
    source_address2 as (
        select 
            cast (businessentityid as int) as id_negocio		
            , cast (personid as int) as id_pessoa
            --, contacttypeid				
            --, rowguid				
            --, modifieddate
        
        from {{ source('erp', 'businessentitycontact') }}
    )
select * 
from source_address2   