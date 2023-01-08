with 
    source_workorder as (
        select 
            cast(workorderid as int) as id_pedido		
            , cast(productid as int) as id_produto	
            , cast(orderqty as int) as quantidade_pedido
            , cast(scrappedqty as int) as quantidade_sucateada
            --, cast(startdate as date) as data_inicial
            --, cast(enddate as date) as data_final
            --, cast(duedate as date) as data_limite
            --, scrapreasonid	
        
        from {{ source('erp', 'workorder') }}
    )
select * 
from source_workorder   