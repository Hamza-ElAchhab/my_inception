# install the base img then ...

# latest is not forbidden
# the tag latest can today give you a filesystem
# and next month another one
# just the compnay change latest to point on another one.


FROM debian:bookworm


RUN apt update && apt install mariadb-server -y \
    && mkdir /run/mysqld && \
    chmod 777 /run/mysqld

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
