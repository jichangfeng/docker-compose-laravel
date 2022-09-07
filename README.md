# docker-compose-laravel
用于 laravel 开发的 docker-compose 运行环境

**常用的 Docker 操作命令：**
```
# 构建，启动项目中的 全部/部分 服务容器
docker-compose up -d
docker-compose up -d nginx php-fpm mysql redis
# 重启项目中的 全部/部分 服务容器
docker-compose restart
docker-compose restart nginx php-fpm mysql redis
# 停止并移除项目中的 全部/部分 服务容器
docker-compose rm -f -s
docker-compose rm -f -s nginx php-fpm mysql redis
# 列出项目中的服务容器
docker-compose ps
# 查看项目中的服务容器内运行的进程
docker-compose top
# 进入项目中正在运行的服务容器
docker-compose exec php-fpm bash
# 启动并进入项目中的服务容器，--rm 表示退出容器后自动删除容器
docker-compose run --rm php-cli bash
......
```

**提供的 Docker 容器服务：**
 - mysql 5.7.32
  >- 端口：33060 -> 转发到 3306
  >- 用户名：root
  >- 密码：nosmoking
 - postgres 12.4
  >- 端口：54320 -> 转发到 5432
  >- 用户名：postgres
  >- 密码：nosmoking
 - redis 5.0.9
  >- 端口：63790 -> 转发到 6379
 - phpredisadmin
  >- 端口：6380 -> 转发到 6380
  >- 用户名：admin
  >- 密码：nosmoking
 - beanstalkd 1.10
  >- 端口：11300 -> 转发到 11300
 - beanstalkd-console
  >- 端口：2080 -> 转发到 2080
  >- 用户名：admin
  >- 密码：nosmoking
 - gearmand 1.1.19.1
  >- 端口：4730 -> 转发到 4730
 - php-fpm 7.3.23
 - php-cli 7.3.23
 - nginx 1.18.0
  >- 端口：8000 -> 转发到 80
  >- 端口：44300 -> 转发到 443
 - composer latest-stable
 - node lts

**使用 Docker 导出/导入镜像：**
```
# 导出
docker save docker-compose-laravel_mysql:latest -o docker-compose-laravel_mysql-latest.tar
docker save docker-compose-laravel_postgres:latest -o docker-compose-laravel_postgres-latest.tar
docker save docker-compose-laravel_redis:latest -o docker-compose-laravel_redis-latest.tar
docker save docker-compose-laravel_phpredisadmin:latest -o docker-compose-laravel_phpredisadmin-latest.tar
docker save docker-compose-laravel_beanstalkd:latest -o docker-compose-laravel_beanstalkd-latest.tar
docker save docker-compose-laravel_beanstalkd-console:latest -o docker-compose-laravel_beanstalkd-console-latest.tar
docker save docker-compose-laravel_gearmand:latest -o docker-compose-laravel_gearmand-latest.tar
docker save docker-compose-laravel_php-fpm:latest -o docker-compose-laravel_php-fpm-latest.tar
docker save docker-compose-laravel_php-cli:latest -o docker-compose-laravel_php-cli-latest.tar
docker save docker-compose-laravel_nginx:latest -o docker-compose-laravel_nginx-latest.tar
docker save docker-compose-laravel_composer:latest -o docker-compose-laravel_composer-latest.tar
docker save docker-compose-laravel_node:latest -o docker-compose-laravel_node-latest.tar
#
# 导入
docker load -i docker-compose-laravel_mysql-latest.tar
docker load -i docker-compose-laravel_postgres-latest.tar
docker load -i docker-compose-laravel_redis-latest.tar
docker load -i docker-compose-laravel_phpredisadmin-latest.tar
docker load -i docker-compose-laravel_beanstalkd-latest.tar
docker load -i docker-compose-laravel_beanstalkd-console-latest.tar
docker load -i docker-compose-laravel_gearmand-latest.tar
docker load -i docker-compose-laravel_php-fpm-latest.tar
docker load -i docker-compose-laravel_php-cli-latest.tar
docker load -i docker-compose-laravel_nginx-latest.tar
docker load -i docker-compose-laravel_composer-latest.tar
docker load -i docker-compose-laravel_node-latest.tar
```

**使用 phpRedisAdmin 管理工具：**
 - 用PHP编写的用于管理Redis数据库的简单Web界面。
 - 访问地址：`http://127.0.0.1:6380`（其中 127.0.0.1 为Docker容器可访问IP）
 - 访问用户名、密码：`admin nosmoking`
 - 添加Redis数据库：
```
 # 修改 docker-compose.yml 文件，在 phpredisadmin 容器服务里设置环境变量，示例如下：
    environment:
      - TZ=Asia/Shanghai
      - ADMIN_USER=admin
      - ADMIN_PASS=nosmoking
      - REDIS_1_HOST=redis
      - REDIS_1_PORT=6379
      - REDIS_2_NAME=beta
      - REDIS_2_HOST=beta.redis.com
      - REDIS_2_PORT=6379
      - REDIS_2_AUTH=abc123
  # 修改之后需重新构建，重新启动 phpredisadmin 容器服务，示例如下：
    docker-compose build phpredisadmin
    docker-compose rm -f -s phpredisadmin
    docker-compose up -d phpredisadmin
```

**使用 beanstalkd-console 管理工具：**
 - 用PHP编写的Beanstalk队列服务器的管理控制台。
 - 访问地址：`http://127.0.0.1:2080`（其中 127.0.0.1 为Docker容器可访问IP）
 - 访问用户名、密码：`admin nosmoking`
 - 添加Beanstalk队列服务器：登录之后在首页点击`Add server`即可操作添加。

**使用 Gearman-Monitor 监控工具：**
 - 用PHP编写的 Gearman 服务器的监控工具。
 - 安装步骤（示例）：
   ```
   docker-compose run --rm php-cli bash
   cd /var/www/code/default
   git clone https://github.com/yugene/Gearman-Monitor.git
   cd Gearman-Monitor
   composer install
   sed -i "s/127.0.0.1/gearmand/g" _config.php
   exit
   ```
 - 访问地址：`http://127.0.0.1:8000/Gearman-Monitor/index.php`（其中 127.0.0.1 为Docker容器可访问IP）
 - 添加 Gearman 服务器：将 Gearman 服务器地址添加到 `_config.php` 。

**使用 Composer 命令：**
 - 语法：
```
# 运行命令后自动删除容器
docker-compose run --rm composer [options] [--] [<command_name>]
#
# 进入容器后再执行命令，退出容器后自动删除容器
docker-compose run --rm php-cli bash
composer [options] [--] [<command_name>]
exit
```
 - 示例：
```
# 自我更新
docker-compose run --rm composer self-update
#
# 安装项目依赖
docker-compose run --rm composer install -d /var/www/code/laravel/blog
#
# 更新项目依赖
docker-compose run --rm composer update -d /var/www/code/laravel/blog
#
# 创建 Laravel 项目
docker-compose run --rm composer create-project -d /var/www/code/laravel --prefer-dist laravel/laravel blog
# 创建 Laravel 项目 - 也可以指定 Laravel 版本
docker-compose run --rm composer create-project -d /var/www/code/laravel --prefer-dist laravel/laravel blog "6.*"
#
# Web 服务器配置
#     复制文件 conf\nginx\conf.d\default.conf 为 conf\nginx\conf.d\blog.conf
#     修改 blog.conf 文件内容“server_name default.www;”为“server_name blog.www;”
#     修改 blog.conf 文件内容“root "/var/www/code/default";” 为“root "/var/www/code/laravel/blog/public";”
#     修改 blog.conf 文件内容“www.default.access.log";”为“www.blog.access.log”
#     修改 blog.conf 文件内容“www.default.error.log";”为“www.blog.error.log”
#     修改 hosts 增加“127.0.0.1 blog.www”（格式：Docker容器可访问IP 域名）
#     重启 docker 后即可访问项目网址“http://blog.www:8000”
```

**使用 Artisan 命令行：**
 - 语法：
```
# 运行命令后自动删除容器
docker-compose run --rm php-cli php /path/to/artisan <command> [options] [arguments]
#
# 进入容器后再执行命令，退出容器后自动删除容器
docker-compose run --rm php-cli bash
php /path/to/artisan <command> [options] [arguments]
exit
```
 - 示例：
```
# 查看所有可用的 Artisan 命令的列表
docker-compose run --rm php-cli php /var/www/code/laravel/blog/artisan list
#
# 运行迁移
docker-compose run --rm php-cli php /var/www/code/laravel/blog/artisan migrate
```

**使用 Node 包管理器命令：**
 - 语法：
```
# 运行命令后自动删除容器
docker-compose run --rm node npm <command>
docker-compose run --rm node cnpm [option] <command>
docker-compose run --rm node yarn [command] [flags]
#
# 进入容器后再执行命令，退出容器后自动删除容器
docker-compose run --rm node bash
npm <command>
cnpm [option] <command>
yarn [command] [flags]
exit
```

### Infrastructure model

![Infrastructure model](.infragenie/infrastructure_model.png)