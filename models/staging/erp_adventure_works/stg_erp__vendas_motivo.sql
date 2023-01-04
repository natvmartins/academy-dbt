with 
    source_salesreason as (
        select 
            cast (salesreasonid as int) as id_motivo_venda
            , cast (name as string) as id_nome_venda
            , cast (reasontype as string) as id_tipo_motivo_venda
            --, modifieddate	
        
        from {{ source('erp', 'salesreason') }}
    )
select * 
from source_salesreason   