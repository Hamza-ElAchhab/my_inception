FROM debian:bookworm
# add description


RUN apt update && apt install mariadb-server -y \
    && mkdir /run/mysqld && \
    chmod 777 /run/mysqld



COPY tools/script.sh /script.sh

RUN chmod +x /script.sh



ENTRYPOINT ["/script.sh"]



# /var/lib/mysql

# CMD for the first default cmd, execute when you creates the cntr, if you have 3 CMDs will use last one
# entrypoint runs the main proccess and cmd for give him arguments


# case 1:
# كلشي داخل ENTRYPOINT
# ENTRYPOINT ["echo", "Hello"]


# case 2:
# نفرّقو ENTRYPOINT و CMD
# ENTRYPOINT ["echo"]
# CMD ["Hello"]


# find the defrrents.
# if you use all in the entrypoint will be a fixed fully cmd
# if not you will can override the CMD/

# when use every one of them
# CMD : with a default cmd , that will be can overridded when will run the img, docker run my-image echo bye
# CMD ["mariadbd"] docker run my-db bash this will change the main


# ENTRYPOIN : when will you want to be the program is the main proccess.
# ENTRYPOINT: إلا بغيتي تفرض برنامج معيّن يكون هو الرئيسي ديال الـ container.

# both of them support exec from and shell form

