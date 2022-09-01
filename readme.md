# user.tax 运维

## ubuntu 系统初始化

`bash <(curl -s https://cdn.jsdelivr.net/gh/user-tax-dev/docker_dev_build/ubuntu/boot.sh)`

## 运维系统初始化

```
mkdir -p ~/user
cd ~/user
git clone --depth=1 git@github.com:user-tax-dev/ops.git
cd ops
./init.sh
```
