with 
    source_salesorderheadersalesreason as (
        select 
            cast(salesorderid as int) as id_venda
            , cast(salesreasonid as int) as id_motivo_venda
        
        from {{ source('erp', 'salesorderheadersalesreason') }}
    )
select * 
from source_salesorderheadersalesreason   

