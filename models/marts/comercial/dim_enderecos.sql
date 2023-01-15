with
    endereco_cidade as (
        select 
            id_endereco
            , id_estado
            , cidade
        from {{ ref('stg_erp__endereco_cidade') }}
    )

    , endereco_estado as (
        select 
            id_estado
            , id_regiao
            , codigo_estado
            , codigo_regiao_pais
            , nome_estado

        from {{ ref('stg_erp__endereco_estado') }}
    )

    , endereco_pais as (
        select 
            codigo_regiao_pais
            , nome_pais
        from {{ ref('stg_erp__endereco_pais') }} 
    )

    , uniao_tabelas as (
        select
            row_number() over (order by endereco_cidade.id_endereco) as sk_endereco
            , endereco_cidade.id_endereco
            , endereco_cidade.cidade 
            , endereco_estado.codigo_estado
            , endereco_estado.nome_estado
            , endereco_pais.codigo_regiao_pais
            , endereco_pais.nome_pais

        from endereco_cidade
        left join endereco_estado on endereco_estado.id_estado = endereco_cidade.id_estado
        left join endereco_pais on endereco_pais.codigo_regiao_pais = endereco_estado.codigo_regiao_pais

    )

select * 
from uniao_tabelas