./one_query_result_pg.sh ./sensor_queries/q2_1k.sql > ./results_sensor/sensor_q2_1k.txt
./one_query_result_pg.sh ./sensor_queries/q2_10k.sql > ./results_sensor/sensor_q2_10k.txt
./one_query_result_pg.sh ./sensor_queries/q2_100k.sql > ./results_sensor/sensor_q2_100k.txt
./one_query_result_pg.sh ./sensor_queries/q2_1m.sql > ./results_sensor/sensor_q2_1m.txt
./one_query_result_pg.sh ./sensor_queries/q2_4m.sql > ./results_sensor/sensor_q2_4m.txt

./one_query_result_pg.sh ./sensor_queries/q2_1k_noExpl.sql > ./results_sensor/q2_1k_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q2_10k_noExpl.sql > ./results_sensor/q2_10k_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q2_100k_noExpl.sql > ./results_sensor/q2_100k_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q2_1m_noExpl.sql > ./results_sensor/q2_1m_noExpl.txt
./one_query_result_pg.sh ./sensor_queries/q2_4m_noExpl.sql > ./results_sensor/q2_4m_noExpl.txt


