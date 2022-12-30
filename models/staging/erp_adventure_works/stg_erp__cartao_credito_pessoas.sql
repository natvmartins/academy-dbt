with 
    source_personcreditcard as (
        select 
            cast(businessentityid as int) as id_negocio
            , cast(creditcardid as int) as id_cartao_credito		
            --, modifieddate	
        
        from {{ source('erp', 'personcreditcard') }}
    )
select * 
from source_personcreditcard