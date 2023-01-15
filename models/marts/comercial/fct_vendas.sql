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

    , clientes as (
        select 
            sk_cliente
            , id_cliente
            , id_loja
            , id_pessoa
            , nome_pessoa

        from {{ ref('dim_clientes')}}
    )

    , enderecos as (
        select 
            sk_endereco as fk_endereco
            , id_endereco
            , cidade
            , codigo_estado
            , codigo_regiao_pais
            , nome_estado
            , nome_pais 
        from {{ ref('dim_enderecos')}}
    )

    , cartoes_credito as (
        select 
            sk_cartao_credito
            , id_cartao_credito
            , id_negocio
            , tipo_cartao
        from {{ ref('dim_cartoes_credito')}}
        --where id_cartao_credito = 4319
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
            , valor_total
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
            , clientes.sk_cliente as fk_cliente
            , vendas.id_cliente
            , vendas.id_vendedor
            , vendas.id_regiao
            , vendas.id_endereco_pagamento
            , vendas.id_endereco_entrega
            , clientes.id_loja
            , vendas_motivo.id_motivo_venda
            --, vendas.id_metodo_entrega
            , vendas_detalhes.id_oferta_especial
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
            , vendas.valor_total
            , produtos.custo_padrao
            , produtos.preco_de_lista
            --, vendas_detalhes.id_venda
            , vendas_detalhes.quantidade_pedido
            , vendas_detalhes.preco_unitario
            , vendas_detalhes.desconto_preco_unitario
            , vendas_detalhes.data_modificacao_valor
            , produtos.nome_produto
            , produtos.numero_produto
            , produtos.cor_produto
            , produtos.nivel_estoque_seguranca
            , produtos.dias_para_fabricar
            , produtos.linha
            , produtos.classe
            , produtos.estilo
            , clientes.nome_pessoa
            , enderecos.cidade
            , enderecos.codigo_estado
            , enderecos.codigo_regiao_pais
            , enderecos.nome_estado
            , enderecos.nome_pais 

        from vendas
        left join vendas_detalhes on vendas_detalhes.id_venda = vendas.id_venda
        left join produtos on produtos.id_produto = vendas_detalhes.id_produto
        left join clientes on clientes.id_cliente = vendas.id_cliente
        left join enderecos on enderecos.id_endereco = vendas.id_endereco_entrega
        left join cartoes_credito on cartoes_credito.id_cartao_credito = vendas.id_cartao_credito
        left join vendas_motivo1 on vendas_motivo1.id_venda = vendas.id_venda
        left join vendas_motivo on vendas_motivo.id_motivo_venda = vendas_motivo1.id_motivo_venda
    )

select * 
from uniao_tabelas
