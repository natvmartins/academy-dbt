with 
    clientes as (
        select 
            id_cliente
            , id_pessoa
            , id_loja
            , id_regiao
        from  {{ ref('stg_erp__clientes') }}
    )

    , cartao_credito_pessoas as (
        select 
            id_negocio
            , id_cartao_credito
        from {{ ref('stg_erp__cartao_credito_pessoas') }}
    )

    , cartao_credito as (
        select
            id_cartao_credito
            , tipo_cartao
        from {{ ref('stg_erp__cartao_credito') }}
    )

    , pessoas as (
        select 
            id_negocio
            , primeiro_nome
            , segundo_nome
            , ultimo_nome
        from {{ ref('stg_erp__pessoas') }}
    )

    , endereco1 as (
        select 
            id_endereco
            , id_estado
            , cidade
        from {{ ref('stg_erp_1_endereco') }}
    )

    , endereco2 as (
        select 
            id_negocio
            , id_pessoa
        from {{ ref('stg_erp_2_endereco') }}
    )

    , endereco3 as (
        select 
            id_negocio
            , id_endereco
            , id_tipo_endereco
        from {{ ref('stg_erp_3_endereco') }}
    )

    , endereco4 as (
        select 
            id_estado
            , id_regiao
            , codigo_estado
            , codigo_regiao_pais
            , nome_estado

        from {{ ref('stg_erp_4_endereco') }}
    )

    , endereco5 as (
        select 
            codigo_regiao_pais
            , nome_pais
        from {{ ref('stg_erp_5_endereco') }} 
    )

    , uniao_tabelas as (
        select
            clientes.id_cliente
            , clientes.id_pessoa
            , endereco2.id_pessoa
            , pessoas.id_negocio
            , cartao_credito_pessoas.id_negocio
            , endereco3.id_negocio
            , endereco2.id_negocio
            , clientes.id_loja
            , clientes.id_regiao
            , cartao_credito_pessoas.id_cartao_credito
            , cartao_credito.id_cartao_credito
            , cartao_credito.tipo_cartao
            , endereco1.id_endereco
            , endereco3.id_endereco
            , endereco1.id_estado
            , endereco3.id_tipo_endereco
            , pessoas.primeiro_nome
            , pessoas.segundo_nome
            , pessoas.ultimo_nome
            , endereco1.cidade 
            , endereco4.id_estado
            , endereco4.id_regiao
            , endereco4.codigo_estado
            , endereco4.codigo_regiao_pais
            , endereco4.nome_estado
            , endereco5.codigo_regiao_pais
            , endereco5.nome_pais

        from pessoas
        left join endereco2 on endereco2.id_pessoa = pessoas.id_negocio
        left join clientes on clientes.id_pessoa = endereco2.id_pessoa 
        left join cartao_credito_pessoas on cartao_credito_pessoas.id_negocio = pessoas.id_negocio
        left join cartao_credito on cartao_credito.id_cartao_credito = cartao_credito_pessoas.id_cartao_credito
        left join endereco3 on endereco3.id_negocio = endereco2.id_negocio
        left join endereco1 on endereco1.id_endereco = endereco3.id_endereco
        left join endereco4 on endereco4.id_estado = endereco1.id_estado
        left join endereco5 on endereco5.codigo_regiao_pais = endereco4.codigo_regiao_pais

    )

select * 
from uniao_tabelas
