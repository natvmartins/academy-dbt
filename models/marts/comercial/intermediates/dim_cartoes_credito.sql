with 
    cartao_credito_pessoas as (
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

    , uniao_tabelas as (
        select 
            row_number() over (order by cartao_credito.id_cartao_credito) as sk_cartao_credito
            , cartao_credito.id_cartao_credito
            , cartao_credito_pessoas.id_negocio
            , cartao_credito.tipo_cartao
        from cartao_credito
        left join cartao_credito_pessoas on cartao_credito_pessoas.id_cartao_credito = cartao_credito.id_cartao_credito
    )

select *
from uniao_tabelas