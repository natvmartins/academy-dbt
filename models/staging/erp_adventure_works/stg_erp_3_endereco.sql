with 
    source_address3 as (
        select 
            cast(businessentityid as int) as id_negocio
            , cast(addressid as int) as id_endereco
            , cast(addresstypeid as int) as id_tipo_endereco
            --, rowguid		
            --, modifieddate
       
        from {{ source('erp', 'businessentityaddress') }}
    )
select * 
from source_address3