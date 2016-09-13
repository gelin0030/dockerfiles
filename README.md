# Run Under Mac

## 环境要求

Mac系统，已经安装过以下组件：

- VirtualBox
- git
- Homebrew
- pip

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install wget
sudo easy_install pip
```

## 安装Docker/Boot2Docker/Docker-Compose 推荐直接下载 [docker-for-mac](https://docs.docker.com/docker-for-mac/) 省去安装下列 boot2docker 步骤


```
brew update
brew tap homebrew/binary
brew install docker boot2docker
sudo pip install -U docker-compose
```


初始化Boot2docker，Boot2docker默认会从AWS下载镜像，此处需要翻墙

如果无法翻墙可以手动下载Boot2Docker所需ISO镜像

```
wget http://192.168.11.180/boot2docker.iso -O ~/.boot2docker/boot2docker.iso
```

```
boot2docker init
boot2docker start
```

内存充足的话，建议将虚拟机内存调整到4GB

```
VBoxManage modifyvm boot2docker-vm --memory 4096
```

运行Docker需要设置环境变量，建议在~/.bashrc中加入

```
if [ "`boot2docker status`" = "running" ]; then
    eval "$(boot2docker shellinit)"
fi
```


### 设置Docker镜像，加速下载

Mac下：

```
boot2docker ssh
sudo vi /var/lib/boot2docker/profile
EXTRA_ARGS="--registry-mirror=http://192.168.11.180:5000"
boot2docker restart
```

Ubuntu下:

```
vi /etc/default/docker
DOCKER_OPTS=" --registry-mirror http://192.168.11.180:5000 --insecure-registry 192.168.11.180:5000"
service docker restart
```

## 启动Dockerfiles


Clone本项目

```shell
cd ~
https://github.com/gelin0030/Docker.git
```

下载镜像及构建

```
make init
make build
```

构建及运行环境

```
docker-compose build
docker-compose up
```

绑定域名

```
sudo vim /etc/hosts
加入
192.168.59.103 docker
```

现在可以通过访问`http://docker/`来查看Web服务器根目录

