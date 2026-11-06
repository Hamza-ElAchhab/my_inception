#!/bin/bash

# add description



# بعض الـ Shells تقوم بتحسين (optimization)
# we run with exec form for dont depand on the optimise of shell
# cause it can fork() and dont replace shell with shell even it is one proccess, no need fork()



# test -f /var/lib/mysql/.initializeddsf && echo "sdf"
if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql &
    sleep 5

    mariadb --execute "CREATE DATABASE ${DATABASE_NAME};"
    mariadb --execute "CREATE USER ${DATABASE_USER_NAME}@'%' IDENTIFIED BY '${DATABASE_USER_PASSWORD}';"
    mariadb --execute "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO ${DATABASE_USER_NAME}@'%';"
    # *.* first for all tables then sep then all tables

    mariadb-admin shutdown
    touch /var/lib/mysql/.initialized
fi

# we specify mysql use, cause it by default runs with root
exec mariadbd --user=mysql --bind-address=0.0.0.0


# exec form
# bash just parsing script for get (cmd and argms), then for a parsed part will use fork() + exec() for,
# the cmd then be killed the return to the script for parse another part
# Bash parses: كيحلّل السطر ويستخرج الـ command والـ arguments.
# fork(): كينشئ Child Process.
# exec(): الـ Child Process كيشغّل البرنامج المطلوب، مثلاً mkdir.
# Execution: البرنامج كينفّذ المهمة ديالو.
# Exit: ملي كيسالي، الـ Child Process كيخرج.
# wait(): Bash كيتلقى حالة الخروج ديالو، ومن بعد كيكمل تنفيذ الـ script.
# take care exec() will executable in the same pid, that we use fork() for make another process and replace it





# the base config path
# /etc/mysql/mariadb.cnf
# other configs --> /etc/mysql/mariadb.conf.d/...

# by default it use 127 and 3306
# listening : means the service use a net sock accept TCP CONNECTION only in 3306

# TCP listening socket.
# الـ TCP Listening Socket هي واحد endpoint كينشئها Linux process باش تستقبل
#  TCP connections جاية من processes أخرى، سواء من نفس الجهاز أو من Network.