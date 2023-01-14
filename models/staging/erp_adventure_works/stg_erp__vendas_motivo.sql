with 
    source_salesreason as (
        select 
            cast (salesreasonid as int) as id_motivo_venda
            , cast (name as string) as motivo_venda
            , cast (reasontype as string) as tipo_motivo_venda
            --, modifieddate	
        
        from {{ source('erp', 'salesreason') }}
    )
select * 
from source_salesreason   