# Git Note

### 个人token

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



### 常用命令

> 以下命令皆需Git Bash **进入库目录后** 使用

##### 1. 初始化库：`git init`

> 将当前目录初始化为git库

##### 2. 查看库状态：`git status`

##### 3. **内容操作

- 添加到库缓存：`git add x`xx

  > 对于文件：file.type
  >
  > 对于文件夹：dir 或 "中文名称"

- 提交库更改：`git commit -m "提交说明"`

##### 5. 查看操作日志：`git log`

##### 6. 分支操作

- 查看/新建分支：`git branch (参数)` 

  > `* xxx` 代表当前所在的分支
  >
  > 添加参数 `分支名称` 即可创建新的分支

- 切换/新建分支：`git checkout (参数) 分支名称`

  > 添加参数 `-新分支名称` 即可一次完成新建与切换

- 将目标分支合并到当前分支：`git merge 分支名称`

- 删除分支：`git branch -d 名称`

  > 使用 `-D` 可进行强制删除

- 为当前分支添加标签：`git tag xxx`

##### 7. **远程库操作

- 下载：`git pull origin 分支名称`
- 上传：`git push origin 分支名称`



### SSH绑定GitHub

##### 1. 在本地生成SSH Key：`ssh-keygen -t rsa`

##### 2. 在GitHub上绑定key

- 复制本地 `id_rsa.pub` 中的key
  - Windows：C:\Users\xxx\.ssh
  - Mac：~/.ssh
- Settings -- SSH and GPG Keys -- New SSH Key

##### 3. 验证：`ssh -T git@github.com`



### 克隆远程库

##### 1. 复制远程库地址

##### 2. 克隆库到本地：`git clone 库地址`

> 应该在库在本地位置的 **上一级** 使用，相当于把库文件夹下载下来

##### 4. 上传到远程库：`git push origin 分支名称`

> 默认的自定义远程库代称为 `origin`
>
> 实际流程为：add --> commit --> push



### 绑定本地库

> 两个库名称无需一致

##### 1. 在本地库文件夹中进行git初始化

##### 2. 连接远程库：`git remote add origin 库地址`

> `origin` 为默认的自定义远程库代称

##### 3. 进行pull或push

















