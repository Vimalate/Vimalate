## nginx下载

**正向代理，客户端不想让服务器知道客户端的ip，所以让代理服务器去访问，再返回给客户端。
反向代理，服务器不想客户端知道是哪个服务器响应的，所以让代理服务器去分配，让空闲的服务器去响应。**

[下载地址](http://nginx.org/en/download.html)

Stable version 稳定版

## nginx 基本命令

解压，双击```双击nginx.exe启动```

cmd 命令启动```start nginx```

- nginx -t  检查配合是否正确
- nginx -s quit/nginx -s stop 关闭
- nginx -s reload 重新加载nginx配置

## location 的匹配规则

共四种方式

```js
location[ = | ~ | ~* | ^~ ] url {

}
```

- = ：精确匹配，用于不含正则表达式的url前，要求字符串与url严格匹配，完全相等时，才能停止向下搜索并处理请求
- ^~：用于不含正则表达式的url前，要求ngin服务器找到表示url和字符串匹配度最高的location后，立即使用此location处理请求，而不再匹配
- ~ ：最佳匹配，用于表示url包含正则表达式，并且区分大小写。
- ~*：与~一样，只是不区分大小写

>如果 url 包含正则表达式，则不需要 ~ 作为开头表示
>nginx的匹配具有优先顺序，一旦匹配上就会立马退出，不再进行向下匹配


[作为一名前端，该如何理解Nginx？](https://juejin.cn/post/7082655545491980301#heading-0)、
[写给前端新人的nginx教程](https://juejin.cn/post/7052952117425733663#heading-6)

```
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip_static  on;
	gzip_proxied expired no-cache no-store private auth;

	#开启动态gzip压缩输出 优先级小于静态，即同时开启后如果存在同名的 .gz 文件则会直接读取，不会进行压缩
	gzip on; 
	#允许压缩的页面的最小字节数,页面字节数从header偷得content-length中获取.默认是0,不管页面多大都进行压缩.建议设置成大于1k的字节数,小于1k可能会越压越大
	gzip_min_length 1k; 
	#设置用于处理请求压缩的缓冲区数量和大小。比如32 4K表示按照内存页（one memory page）大小以4K为单位（即一个系统中内存页为4K），申请32倍的内存空间。建议此项不设置，使用默认值。
	gzip_buffers 32 4k; 
	#压缩版本（默认1.1,目前大部分浏览器已经支持gzip解压.前端如果是squid2.5请使用1.0）
	gzip_http_version 1.1; 
	#压缩等级.1压缩比最小,处理速度快.9压缩比最大,比较消耗cpu资源,处理速度最慢,但是因为压缩比最大,所以包最小,传输速度快
	gzip_comp_level 2; 
	#压缩类型,默认就已经包含text/html,所以下面就不用再写了,写上去也不会有问题,但是会有一个warn.
	gzip_types text/plain application/javascript application/x-javascript text/css application/xml 
			text/javascript application/x-httpd-php image/jpeg image/gif image/png application/vnd.ms-fontobject 
			font/ttf font/opentype font/x-woff image/svg+xml;
	#选项可以让前端的缓存服务器缓存经过gzip压缩的页面.例如:用squid缓存经过nginx压缩的数据
	gzip_vary on;
	#IE6对Gzip不怎么友好，不给它Gzip了
	gzip_disable "MSIE [1-6]\.";

    server {
        listen       8090;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html/dist;
            index  index.html index.htm;
            try_files $uri $uri/ /index.html;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }
    
    	#前端App-demo项目
       server {
        listen       8098;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html/app;
            index  index.html index.htm;
            try_files $uri $uri/ /index.html;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }
    
       #前端主应用
       server {
        listen       9001;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html/web;
            index  index.html index.htm;
            try_files $uri $uri/ /index.html;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }
    
#		server {
		
#		listen       8098;
#        server_name  localhost;
		
#		location = /index.html {
#		  add_header Cache-Control no-cache;
#		  add_header Access-Control-Allow-Origin *;
#		  root  html/app;
#		}
		
#		location / {
#			add_header Access-Control-Allow-Origin *;
#			add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
#			add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';

#			if ($request_method = 'OPTIONS') {
#				return 204;
#			}
#			root html/app;
#			try_files $uri $uri/ /index.html;
#			index  index.html index.htm;
#		}
		
#        error_page   500 502 503 504  /50x.html;
#        location = /50x.html {
#            root   html;
#        }
#	}


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
```