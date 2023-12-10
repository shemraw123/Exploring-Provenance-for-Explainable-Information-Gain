-- FUNCTION: public.hammingdist(text, text)

-- DROP FUNCTION IF EXISTS public.hammingdist(text, text);

CREATE OR REPLACE FUNCTION public.hammingdist(
	value1 text,
	value2 text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
hamming text;
begin
hamming = '';
CASE WHEN SUBSTRING(value1, 1, 1) = SUBSTRING(value2, 1, 1) then hamming = hamming||'0'; ELSE hamming = hamming ||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 2, 1) = SUBSTRING(value2, 2, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 3, 1) = SUBSTRING(value2, 3, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 4, 1) = SUBSTRING(value2, 4, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 5, 1) = SUBSTRING(value2, 5, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 6, 1) = SUBSTRING(value2, 6, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 7, 1) = SUBSTRING(value2, 7, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 8, 1) = SUBSTRING(value2, 8, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 9, 1) = SUBSTRING(value2, 9, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 10, 1) = SUBSTRING(value2, 10, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 11, 1) = SUBSTRING(value2, 11, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 12, 1) = SUBSTRING(value2, 12, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 13, 1) = SUBSTRING(value2, 13, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 14, 1) = SUBSTRING(value2, 14, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;
CASE WHEN SUBSTRING(value1, 15, 1) = SUBSTRING(value2, 15, 1) then hamming = hamming||'0'; ELSE hamming = hamming||'1'; END CASE;

return hamming;
end;
$BODY$;

ALTER FUNCTION public.hammingdist(text, text)
    OWNER TO postgres;


