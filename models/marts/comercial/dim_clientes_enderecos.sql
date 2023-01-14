with 
    clientes as (
        select 
            id_cliente
            , id_pessoa
            , id_loja
            , id_regiao
        from  {{ ref('stg_erp__clientes') }}
    )

    , pessoas as (
        select 
            id_negocio
            , primeiro_nome
            , segundo_nome
            , ultimo_nome
            , case 
                when segundo_nome is not null then concat(primeiro_nome,' ',segundo_nome,' ', ultimo_nome)
                when segundo_nome is null then concat(primeiro_nome,' ',ultimo_nome)
            end as nome_pessoa
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
            row_number() over (order by pessoas.id_negocio) as sk_cliente /* por endereço */
            , clientes.id_cliente
            , clientes.id_loja
            , clientes.id_pessoa
            , pessoas.id_negocio
            , pessoas.nome_pessoa
            , endereco1.cidade 
            , endereco4.codigo_estado
            , endereco4.codigo_regiao_pais
            , endereco4.nome_estado
            , endereco5.nome_pais

        from pessoas
        left join endereco2 on endereco2.id_pessoa = pessoas.id_negocio
        left join clientes on clientes.id_pessoa = endereco2.id_pessoa 
        left join endereco3 on endereco3.id_negocio = endereco2.id_negocio
        left join endereco1 on endereco1.id_endereco = endereco3.id_endereco
        left join endereco4 on endereco4.id_estado = endereco1.id_estado
        left join endereco5 on endereco5.codigo_regiao_pais = endereco4.codigo_regiao_pais

    )

select * 
from uniao_tabelas

