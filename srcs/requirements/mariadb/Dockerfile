# descrpt

FROM debian:bookworm

# all update + mar_ser + mkdir + chmod in one layer not use 4 RUNs
RUN apt update && apt install mariadb-server -y \
    && mkdir /run/mysqld && \
    chmod 777 /run/mysqld

# script can be modifyed
COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
