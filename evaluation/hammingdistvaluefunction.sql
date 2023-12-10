

-- FUNCTION: public.hammingdistvalue(text)

-- DROP FUNCTION IF EXISTS public.hammingdistvalue(text);

CREATE OR REPLACE FUNCTION public.hammingdistvalue(
	value1 text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
hamming int;
begin
hamming = 0;
CASE WHEN SUBSTRING(value1, 1, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 2, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 3, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 4, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 5, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 6, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 7, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 8, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 9, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 10, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 11, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 12, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 13, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 14, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
CASE WHEN SUBSTRING(value1, 15, 1) = '1' then hamming=hamming+1; ELSE hamming = hamming+0; END CASE;
	
return hamming;
end;
$BODY$;

ALTER FUNCTION public.hammingdistvalue(text)
    OWNER TO postgres;


