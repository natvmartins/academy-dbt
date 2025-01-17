with 
    source_salesorderheader as (
        select 
            cast(salesorderid as int) as id_venda				
            , cast(customerid as int) as id_cliente		
            , cast(salespersonid as int) as id_vendedor	
            , cast(territoryid as int) as id_regiao
            , cast(billtoaddressid as int) as id_endereco_pagamento	
            , cast(shiptoaddressid as int) as id_endereco_entrega
            , cast(shipmethodid as int) as id_metodo_entrega
            , cast(creditcardid as int) as id_cartao_credito
            , cast(orderdate as timestamp) as data_pedido
            , cast(duedate as timestamp) as data_limite
            , cast(shipdate as timestamp) as data_entrega	
            , cast(status as int) as status		
            , cast(subtotal as numeric) as sub_total	
            , cast(taxamt as numeric) as valor_taxa
            , cast(freight as numeric) as valor_frete	
            , cast(totaldue as numeric) as valor_total
            --, onlineorderflag 
            --, revisionnumber            
            --, purchaseordernumber			
            --, accountnumber						
            --, creditcardapprovalcode			
            --, currencyrateid						
            --, comment			
            --, rowguid			
            --, modifieddate
        
        from {{ source('erp', 'salesorderheader') }}
    )
select * 
from source_salesorderheader   