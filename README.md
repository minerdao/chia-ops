# Chia ops

## Chia主节点启动

#### 1. 更新系统
```sh
sudo apt-get update
sudo apt-get upgrade -y
```

#### 2. 安装chia
```sh
mkdir -p chia
cd chia
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain
chmod +x ./install.sh
sh install.sh
```

#### 3. 激活chia环境
**注意，chia所有操作都在这个虚拟环境下执行**
```sh
. ./activate
```

#### 4. 启动并配置Chia相关服务
这里会自动创建一个私钥和公钥，可以不用管，我们只是用来当作全节点服务用。
```sh
# 初始化
chia init

chia keys generate

# 全节点只需要启动node和farmer即可，启动farmer的时候，会自动同时启动wallet
chia start node
chia start farmer

# 查看同步进度
chia show -s
```

## Harvest子节点部署
#### 1. 子节点安装
子节点安装环境同全节点1-3步

#### 2. 初始化chia
```sh
chia init
```

#### 3. 拷贝证书文件
从全节点的`/root/.chia/mainnet/config/ssl`目录下，拷贝`ca`和`daemon`两个文件夹到子节点的任意目录。 
```sh
scp -r /root/.chia/mainnet/config/ssl/daemon chia@x.x.x.x:/home/chia/ssl
scp -r /root/.chia/mainnet/config/ssl/ca chia@x.x.x.x:/home/chia/ssl

# 指定证书文件重新初始化
chia init -c /home/chia/ssl/ca
```

指定子节点连接全节点，其中x.x.x.x为全节点的内网IP：
```sh
chia configure --set-farmer-peer x.x.x.x:8447
```

## 启动P盘任务
全节点和子节点均可启动P盘任务。
#### 1. 安装plotman
```sh
# 激活chia环境
source ~/chia/chia-blockchain/activate

# 安装plotman
pip install --force-reinstall git+https://github.com/ericaltendorf/plotman@main
```

#### 2. 生成配置文件
```sh
plotman config generate

# 创建一个存放plotman日志的目录
mkdir -p /home/chia/chia/logs

# 更改plotman配置文件
vi /home/chia/.config/plotman/plotman.yaml
```
`/home/chia/.config/plotman/plotman.yaml`文件中需要修改以下几个地方：
- `directories`标签中的`tmp`改为本地SSD的挂载点，有几个SSD就填几个路径，SSD最好不要组Raid，直接单盘挂载效率更高；
- `directories`标签中的`dst`改为最终存储plots的路径，如果有专门的存储机器，需要用NFS挂载到本地路径下；
- `directories`标签中的`log`改为存放P盘日志的具体路径；
- `scheduling`中的几个参数说明：
  - `tmpdir_max_jobs`: 每个SSD缓存目录下运行的P盘任务最大数量，需要根据CPU核心和SSD大小计算，每个P盘任务至少需要分配350GB的SSD缓存空间；
  - `global_max_jobs`: 全局最大运行的P盘任务数量；
  - `global_stagger_m`: 多久发送一次任务，单位为分钟；
  - `polling_time_s`: 多久检测一次任务数，单位为秒；
- `plotting`标签中的几个参数说明：
  - `n_threads`: 运行一个P盘任务占用的线程数；
  - `job_buffer`: 运行一个P盘任务占用的内存数，单位为MB；
  - `farmer_pk`: 通过`chia keys show`查看；
  - `pool_pk`: 通过`chia keys show`查看；

其他参数按照默认即可，配置文件中的注释也比较详细，可以仔细研究一下。

#### 3. 开始P盘
```sh
# 创建一个tmux会话
tmux new -s chia -d -n plotman

# 激活chia环境
source ~/chia/chia-blockchain/activate

# 开始P盘
plotman plot
```
完成后，先按Ctrl + B，然后按D将tmux会话放在后台运行。