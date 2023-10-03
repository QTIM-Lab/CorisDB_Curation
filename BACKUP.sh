DATE=$(date +%m-%d-%Y)
mkdir -p /home/bearceb/BACKUPS/coris_db_$DATE/
cp -r /home/bearceb/coris_db/* /home/bearceb/BACKUPS/coris_db_$DATE/

# ls /home/bearceb/BACKUPS/
# ls /home/bearceb/BACKUPS/coris_db_$DATE/
# ls /home/bearceb/BACKUPS/coris_db_$DATE/postgres
# ls /home/bearceb/BACKUPS/coris_db_$DATE/postgres/important_queries_and_stats
# ls /home/bearceb/BACKUPS/coris_db_$DATE/postgres/important_queries_and_stats/queries
# ls /home/bearceb/BACKUPS/coris_db_$DATE/postgres/important_queries_and_stats/queries/Glaucoma
