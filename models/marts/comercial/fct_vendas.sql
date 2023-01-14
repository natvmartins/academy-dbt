with 
    produtos as (
        select 
            sk_produto
            , id_produto
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
        from {{ ref('dim_produtos')}}
    )

    , clientes_enderecos as (
        select 
            sk_cliente
            , id_cliente
            , id_loja
            , id_pessoa
            , id_negocio
            , nome_pessoa
            , cidade
            , codigo_estado
            , codigo_regiao_pais
            , nome_estado
            , nome_pais 
        from {{ ref('dim_clientes_enderecos')}}
    )

    , cartoes_credito as (
        select 
            sk_cartao_credito
            , id_cartao_credito
            , id_negocio
            , tipo_cartao
        from {{ ref('dim_cartoes_credito')}}
    )

    , vendas as (
        select 
            id_venda
            , id_cliente
            , id_vendedor
            , id_regiao
            , id_endereco_pagamento
            , id_endereco_entrega
            , id_metodo_entrega
            , id_cartao_credito
            , data_pedido
            , data_limite
            , data_entrega
            , status
            , sub_total
            , valor_taxa
            , valor_frete
            , valot_total
        from {{ ref('stg_erp__vendas')}}
    )

    , uniao_tabelas as (
        select *
        from vendas
        left join produtos on id_produto.produtos = id_produto.vendas
        left join clientes_enderecos on id_cliente = id_cliente.vendas
        left join cartoes_credito on id_negocio.cartao_credito = id_cliente.vendas
    )

select * 
from uniao_tabelas
