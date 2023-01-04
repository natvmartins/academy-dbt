with 
    source_salesorderdetail as (
        select 
            cast(salesorderid as int) as id_venda			
            , cast(salesorderdetailid as string) as id_detalhes_venda				
            , cast(orderqty as int) as quantidade_pedido
            , cast(productid as int) as  id_produto		
            , cast(specialofferid as int) as  id_oferta_especial	
            , cast(unitprice as numeric) as  preco_unitario	
            , cast(unitpricediscount as numeric) as  desconto_preco_unitario
            --, carriertrackingnumber				
            --, rowguid			
            --, modifieddate
        
        from {{ source('erp', 'salesorderdetail') }}
    )
select * 
from source_salesorderdetail   