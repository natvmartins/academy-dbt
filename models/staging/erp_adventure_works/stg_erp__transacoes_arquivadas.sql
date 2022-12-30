with 
    source_transactionhistoryarchive as (
        select 
            cast(transactionid as int) as id_transacao		
            , cast(productid as int) as id_produto
            , cast(referenceorderid as int) as id_ordem_referencia
            , cast(referenceorderlineid as int) as id_ordem_linha_referencia
            , cast(transactiondate as date) as data_transacao
            , cast(transactiontype as string) as tipo_transacao
            , cast(quantity as int) as quantidade
            , cast(actualcost as numeric) as custo_atual
        
        from {{ source('erp', 'transactionhistoryarchive') }}
    )
select * 
from source_transactionhistoryarchive  