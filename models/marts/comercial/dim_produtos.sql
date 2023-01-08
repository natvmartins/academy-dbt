with    
    produtos as (
        select 
            id_produto
            , id_subcategoria_produto
            , nome_produto
            , numero_produto
            , cor_produto
            , nivel_estoque_seguranca
            , custo_padrao
            , preco_de_lista
            , dias_para_fabricar
            , linha
            , classe
            , estilo
        from {{ ref('stg_erp__produtos') }}
    )

    , transformacao as (
        select
            row_number() over (order by produtos.id_produto) as sk_produto
            , produtos.id_produto
            , produtos.id_subcategoria_produto
            , produtos.nome_produto
            , produtos.numero_produto
            , produtos.cor_produto
            , produtos.nivel_estoque_seguranca
            , produtos.custo_padrao
            , produtos.preco_de_lista
            , produtos.dias_para_fabricar
            , produtos.linha
            , produtos.classe
            , produtos.estilo
        from produtos
    )

select *
from transformacao