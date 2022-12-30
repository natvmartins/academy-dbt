with 
    source_creditcard as (
        select 
            cast(creditcardid as int) as id_cartao_credito		
            , cast(cardtype as string) as tipo_cartao
            --, cardnumber			
            --, expmonth			
            --, expyear			
            --, modifieddate
        
        from {{ source('erp', 'creditcard') }}
    )
select * 
from source_creditcard