./one_query_result_pg.sh ./aqi_queries/q_1k_compare_noExpl.sql > ./results/q_1k_noExpl.txt
./one_query_result_pg.sh ./aqi_queries/q_10k_compare_noExpl.sql > ./results/q_10k_noExpl.txt
./one_query_result_pg.sh ./aqi_queries/q_100k_compare_noExpl.sql > ./results/q_100k_noExpl.txt
./one_query_result_pg.sh ./aqi_queries/q_1m_compare_noExpl.sql > ./results/q_1m_noExpl.txt

############################

./one_query_result_pg.sh ./aqi_queries/q_1k_compare.sql > ./results/q_1k.txt
./one_query_result_pg.sh ./aqi_queries/q_10k_compare.sql > ./results/q_10k.txt
./one_query_result_pg.sh ./aqi_queries/q_100k_compare.sql > ./results/q_100k.txt
./one_query_result_pg.sh ./aqi_queries/q_1m_compare.sql > ./results/q_1m.txt

