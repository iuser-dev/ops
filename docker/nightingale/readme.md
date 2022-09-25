把 n9.usr.tax.conf 软连接到 /etc/nginx/site

Nginx 设置访问密码

```
apt-get install -y apache2-utils
htpasswd -c /etc/nginx/passwd n9
```

到 https://console.neon.tech/ 创建数据库，然后

```
psql postgres://usrtax:$PGPASSWORD@gentle-bar-717003.cloud.neon.tech:5432/main < initsql_for_postgres/a-n9e-for-Postgres.sql
```

导入报警规则如下

```json
[
  {
    "cate": "",
    "name": "机器负载-CPU较高，请关注",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 3,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "cpu_usage_idle{cpu=\"cpu-total\"} < 25",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "",
    "name": "机器负载-内存较高，请关注",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 2,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "mem_available_percent < 25",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "",
    "name": "监控对象失联",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 1,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "max_over_time(target_up[130s]) == 0",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "prometheus",
    "name": "硬盘-IO繁忙",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 2,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "rate(diskio_io_time[1m])/10 > 99",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "prometheus",
    "name": "硬盘-空间紧张(约3周后写满)",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 1,
    "disabled": 0,
    "prom_for_duration": 180,
    "prom_ql": "predict_linear(disk_free[1h], 21*86400) < 0",
    "prom_eval_interval": 60,
    "enable_stime": "10:30",
    "enable_etime": "16:00",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "",
    "name": "网卡-入向有丢包",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 3,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "increase(net_drop_in[1m]) > 0",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "",
    "name": "网卡-出向有丢包",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 3,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "increase(net_drop_out[1m]) > 0",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  },
  {
    "cate": "",
    "name": "网络连接-TME_WAIT数量超过2万",
    "note": "",
    "prod": "",
    "algorithm": "",
    "algo_params": null,
    "delay": 0,
    "severity": 2,
    "disabled": 0,
    "prom_for_duration": 60,
    "prom_ql": "netstat_tcp_time_wait > 20000",
    "prom_eval_interval": 15,
    "enable_stime": "00:00",
    "enable_etime": "23:59",
    "enable_days_of_week": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "0"
    ],
    "enable_in_bg": 0,
    "notify_recovered": 1,
    "notify_channels": [
      "dingtalk",
      "email",
      "mm",
      "wecom",
      "feishu"
    ],
    "notify_repeat_step": 60,
    "notify_max_number": 0,
    "recover_duration": 0,
    "callbacks": [],
    "runbook_url": "",
    "append_tags": []
  }
]
```
