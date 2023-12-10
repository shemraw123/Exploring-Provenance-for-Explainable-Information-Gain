./one_query_result_pg.sh ./sensor_queries/q3_1k.sql > ./results_sensor/sensor_q3_1k.txt
./one_query_result_pg.sh ./sensor_queries/q3_10k.sql > ./results_sensor/sensor_q3_10k.txt
./one_query_result_pg.sh ./sensor_queries/q3_100k.sql > ./results_sensor/sensor_q3_100k.txt
./one_query_result_pg.sh ./sensor_queries/q3_1m.sql > ./results_sensor/sensor_q3_1m.txt
./one_query_result_pg.sh ./sensor_queries/q3_4m.sql > ./results_sensor/sensor_q3_4m.txt

./one_query_result_pg.sh ./sensor_queries/q3_1k_noExpl.sql > ./results_sensor/q3_1k_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q3_10k_noExpl.sql > ./results_sensor/q3_10k_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q3_100k_noExpl.sql > ./results_sensor/q3_100k_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q3_1m_noExpl.sql > ./results_sensor/q3_1m_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q3_4m_noExpl.sql > ./results_sensor/q3_4m_noExpl.txt