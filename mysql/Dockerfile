FROM mysql:5.7.32
MAINTAINER Changfeng Ji <jichf@qq.com>

RUN echo 'key_buffer_size = 32M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'max_allowed_packet = 16M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'sort_buffer_size = 2M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'net_buffer_length = 16K' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'read_buffer_size = 2M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'read_rnd_buffer_size = 8M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'myisam_sort_buffer_size = 64M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'thread_cache_size = 16' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'query_cache_size = 64M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'group_concat_max_len = 102400' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'innodb_buffer_pool_size = 500M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'innodb_log_file_size = 100M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'innodb_log_buffer_size = 16M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'innodb_flush_log_at_trx_commit = 1' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'innodb_lock_wait_timeout = 50' >> /etc/mysql/mysql.conf.d/mysqld.cnf

RUN echo 'server-id = 1' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'log-bin = mysql-bin' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'binlog_format = ROW' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'binlog_row_image = full' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'binlog_cache_size = 2M' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'expire_logs_days = 30' >> /etc/mysql/mysql.conf.d/mysqld.cnf

RUN echo 'innodb_monitor_enable=all' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'performance_schema=ON' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'log_output=file' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'slow_query_log=ON' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'long_query_time=3' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'log_slow_admin_statements=ON' >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo 'log_slow_slave_statements=ON' >> /etc/mysql/mysql.conf.d/mysqld.cnf

CMD ["mysqld"]
