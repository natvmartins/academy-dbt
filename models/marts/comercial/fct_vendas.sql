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

    , vendas_detalhes as (
        select
            id_venda
            , id_detalhes_venda
            , quantidade_pedido
            , id_produto
            , id_oferta_especial
            , preco_unitario
            , desconto_preco_unitario
            , data_modificacao_valor
        from {{ ref('stg_erp__vendas_detalhes')}} 
    )

    , vendas_motivo as (
        select 
            id_motivo_venda
            , motivo_venda
            , tipo_motivo_venda
        from {{ ref('stg_erp__vendas_motivo')}}
    )

    , vendas_motivo1 as (
        select 
            id_venda
            , id_motivo_venda
        from {{ ref('stg_erp_1_vendas_motivo')}}
    )

    , uniao_tabelas as (
        select 
             vendas.id_venda
            , vendas_detalhes.id_detalhes_venda
            , produtos.sk_produto as fk_produto
            , vendas_detalhes.id_produto
            , produtos.id_subcategoria_produto
            , clientes_enderecos.sk_cliente as fk_cliente
            , vendas.id_cliente
            , vendas.id_vendedor
            , vendas.id_regiao
            , vendas.id_endereco_pagamento
            , vendas.id_endereco_entrega
            , clientes_enderecos.id_loja
            , vendas_motivo.id_motivo_venda
            --, vendas.id_metodo_entrega
            , cartoes_credito.sk_cartao_credito as fk_cartao_credito
            , vendas.id_cartao_credito
            , cartoes_credito.tipo_cartao
            , vendas_motivo.motivo_venda
            , vendas_motivo.tipo_motivo_venda
            , vendas.data_pedido
            , vendas.data_limite
            , vendas.data_entrega
            , vendas.status
            , vendas.sub_total
            , vendas.valor_taxa
            , vendas.valor_frete
            , vendas.valot_total
            , produtos.custo_padrao
            , produtos.preco_de_lista
            --, vendas_detalhes.id_venda
            , vendas_detalhes.quantidade_pedido
            , vendas_detalhes.id_oferta_especial
            , vendas_detalhes.preco_unitario
            , vendas_detalhes.desconto_preco_unitario
            , vendas_detalhes.data_modificacao_valor
            , produtos.id_subcategoria_produto
            , produtos.nome_produto
            , produtos.numero_produto
            , produtos.cor_produto
            , produtos.nivel_estoque_seguranca
            , produtos.dias_para_fabricar
            , produtos.linha
            , produtos.classe
            , produtos.estilo
            , clientes_enderecos.nome_pessoa
            , clientes_enderecos.cidade
            , clientes_enderecos.codigo_estado
            , clientes_enderecos.codigo_regiao_pais
            , clientes_enderecos.nome_estado
            , clientes_enderecos.nome_pais 

        from vendas
        left join vendas_detalhes on vendas_detalhes.id_venda = vendas.id_venda
        left join produtos on produtos.id_produto = vendas_detalhes.id_produto
        left join clientes_enderecos on clientes_enderecos.id_cliente = vendas.id_cliente
        left join cartoes_credito on cartoes_credito.id_negocio = vendas.id_cliente
        left join vendas_motivo1 on vendas_motivo1.id_venda = vendas.id_venda
        left join vendas_motivo on vendas_motivo.id_motivo_venda = vendas_motivo1.id_motivo_venda
    )

select * 
from uniao_tabelas

/* resultados referente a cartao de credito e motivo da venda nao estao retornando */