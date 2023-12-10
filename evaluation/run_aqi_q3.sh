#./one_query_result_pg.sh ./aqi_queries/q3_1k.sql > ./results/q3_1k.txt
#./one_query_result_pg.sh ./aqi_queries/q3_10k.sql > ./results/q3_10k.txt
#./one_query_result_pg.sh ./aqi_queries/q3_100k.sql > ./results/q3_100k.txt
#./one_query_result_pg.sh ./aqi_queries/q3_1m.sql > ./results/q3_1m.txt

###########################

./one_query_result_pg.sh ./aqi_queries/q3_1k_noExpl.sql > ./results/q3_1k_noExpl.txt
./one_query_result_pg.sh ./aqi_queries/q3_10k_noExpl.sql > ./results/q3_10k_noExpl.txt
./one_query_result_pg.sh ./aqi_queries/q3_100k_noExpl.sql > ./results/q3_100k_noExpl.txt
./one_query_result_pg.sh ./aqi_queries/q3_1m_noExpl.sql > ./results/q3_1m_noExpl.txt

