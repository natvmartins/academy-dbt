with
    source_product as (
        select 
            cast (productid as int) as id_produto
            , cast (productsubcategoryid as string) as id_subcategoria_produto
            , cast (name as string) as nome_produto
            , cast (productnumber as string) as numero_produto
            , cast (color as string) as cor_produto
            , cast (safetystocklevel as int) as nivel_estoque_seguranca
            , cast (standardcost as numeric) as custo_padrao
            , cast (listprice as numeric) as preco_de_lista
            , cast (daystomanufacture as numeric) as dias_para_fabricar
            , cast (productline	as string) as linha
            , cast (class as string) as classe
            , cast (style as string) as estilo
            --, makeflag 
            --, finishedgoodsflag
            --, reorderpoint
            --, size
            --, sizeunitmeasurecode
            --, weightunitmeasurecode
            --, weight
            --, sellstartdate
            --, sellenddate	as string
            --, discontinueddate	
            --, rowguid	as string
            --, modifieddate
            --, productmodelid
 
        from {{ source('erp', 'product') }}
    )

select *
from source_product