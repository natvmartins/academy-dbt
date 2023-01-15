with 
    source_person as (
        select 
            cast (businessentityid as int) as id_pessoa			
            , cast (firstname as string) as primeiro_nome
            , cast (middlename as string) as segundo_nome		
            , cast (lastname as string)	as ultimo_nome
            --, persontype				
            --, namestyle			
            --, title			
            --, suffix				
            --, emailpromotion				
            --, additionalcontactinfo				
            --, demographics				
            --, rowguid				
            --, modifieddate
        
        from {{ source('erp', 'person') }}
    )
select * 
from source_person  