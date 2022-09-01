# 搜素引擎优化

## 又拍云边缘规则

### https

```
$WHEN($EQ($_SCHEME,http)) $REDIRECT(https://$_HOST/$1,301)
```

优先级 1
break [✓] 

### spider

```
$WHEN(
  $MATCH(
    $LOWER($_HEADER_user_agent),
    'bot\\b|spider\\b|yandex|facebookexternalhit|embedly|quora link preview|outbrain|vkShare|whatsapp'
  ),
  $NOT(
    $MATCH(
      $LOWER($_URI), '\\.'
    )
  )
) $REDIRECT(https://htm.$_HOST/$1,301)
```

优先级 2
break [✓] 

![](https://raw.githubusercontent.com/gcxfd/img/gh-pages/P7xqOu.png)

### 单页面应用不包含 . 的 url 都重写到 / 

```
$WHEN($NOT($MATCH($LOWER($_URI), '\\.'))) /
```

优先级 3
break [✓] 

![](https://raw.githubusercontent.com/gcxfd/img/gh-pages/d6osYJ.png)

## 阿里云函数

用阿里云函数配合又拍云 CDN、阿里云 CDN 对单页面应用做搜索引擎爬虫 SEO 静态化 

这里是基于阿里云函数的 puppeteer 静态化脚本

配合又拍云的边缘规则做可以基于 CDN 的 SEO

测试代码：

* `curl --user-agent "Googlebot"  https://iuser.link`
* `curl  https://iuser.link`

nginx 配置 [参见这里](./nginx.conf)

## 泛域名解析重定向

可以用阿里云 CDN 的边缘规则 

![](https://tqimg.github.io/20200428235128.png)

```
rewrite(concat('https://iuser.link',$request_uri), 'enhance_redirect', 301)
```

这样可以完全隐藏服务器的真实 IP，防止被攻击

### 阿里云证书上传

Let’s Encrypt 客户端
官方推荐的是 certbot, 但谈到泛域名的支持，acme.sh 是我知道的最快支持的，故而选择后者

CDN 证书上传
git9527/aliyun-cdn-https-cert-updater

SLB 证书上传
taichunmin/aliyun-slb-letsencrypt

shell 脚本及注释如下

```
# 上传到CDN需要这个name，name相同会上传失败，这里每次带上时间戳
name=wzzcn_net_`date +%s`
# 阿里云的AccessKey
ali_key=xxxxx
ali_secret=xxxxxxxxxxxxxxxxxx
# 证书路径
key_file=/etc/ssl/my/wzzcn_net/key.pem
cert_file=/etc/ssl/my/wzzcn_net/cert.pem
# 上传证书到CDN，-d参数指定到哪个域名，我这里是到一个泛域名，灵活修改此参数
/usr/bin/python /usr/local/scripts/aliyun/cdn/updater.py -n $name -i $ali_key -s $ali_secret -p $key_file -c $cert_file -d .wzzcn.net
# 上传到SLB，需要指定SLB的ID
/usr/bin/python /usr/local/scripts/aliyun/slb/https.py -i $ali_key -s $ali_secret -p $key_file -c $cert_file -n $name -l "slb的ID" --zone "cn-shanghai"
```
