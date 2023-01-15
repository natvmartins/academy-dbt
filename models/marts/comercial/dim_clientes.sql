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
            id_pessoa
            , primeiro_nome
            , segundo_nome
            , ultimo_nome
            , case 
                when segundo_nome is not null then concat(primeiro_nome,' ',segundo_nome,' ', ultimo_nome)
                when segundo_nome is null then concat(primeiro_nome,' ',ultimo_nome)
            end as nome_pessoa
        from {{ ref('stg_erp__pessoas') }}
    )

    , uniao_tabelas as (
        select
            row_number() over (order by clientes.id_cliente) as sk_cliente 
            , clientes.id_cliente
            , clientes.id_loja
            , clientes.id_pessoa
            , pessoas.nome_pessoa

        from pessoas
        left join clientes on clientes.id_pessoa = pessoas.id_pessoa 
    )

select * 
from uniao_tabelas

