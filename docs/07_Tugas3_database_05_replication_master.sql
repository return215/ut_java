CREATE USER 'repl_user'@'%' IDENTIFIED WITH 'mysql_native_password' BY 'repl_password';
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;
