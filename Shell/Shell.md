# 命令行命令

### 系统差别

##### 



### 目录与文件

##### 目录访问

> Windows用 \ ，PowerShell和Mac用 /

- 查看当前目

  - cmd：`echo %cd%`
  - PowerShell：`pwd`
  - Mac：`pwd`

- 切换磁盘：`D:`

- 访问目录：`cd 操作`

  | 操作符       | 操作                 |
  | ------------ | -------------------- |
  | cd ~         | 当前用户目录         |
  | cd /         | 根目录               |
  | cd -         | 上次访问的目录       |
  | cd ..        | 上一级目录           |
  | cd C:\xxxx   | 当前磁盘的指定文件夹 |
  | cd /d E:\xxx | 其他磁盘的指定文件夹 |

- 查看当前路径下文件

  > 也可用于查找
  >
  > **只有当目标非空文件夹才会有结果**

  - cmd：`dir`
  - PowerShell：`dir` 或 `ls`
  - Mac：`ls`


##### 目录操作

- 创建目录：`mkdir` 或 `md`

  > Mac只支持mkdir
  >
  > 可以同时创建多个文件夹，目录之间用空格分隔

  | 操作符                               | 操作                         |
  | ------------------------------------ | ---------------------------- |
  | mkdir 目录相对路径 或 .\目录相对路径 | 在当前目录下创建             |
  | mkdir \目录相对路径                  | 在磁盘根目录下创建           |
  | mkdir -p 目录相对路径                | 递归创建路径中不存在的文件夹 |

- 在浏览器中打开

  - cmd、PowerShell：`start 目录路径`

- 删除目录

  - cmd：`rd` 

    | 命令      | 功能                 |
    | --------- | -------------------- |
    | rd xxx    | 只能删除空目录       |
    | rd /s xxx |                      |
    | rd xxx /s | 删除目录下的所有文件 |

  - PowerShell：`rd` 或  `rm`

  - Mac：

- 移动目录

  - cmd、PowerShell：`move 目录路径 目标路径`
  - Mac：`mv 目录路径 目标路径`

- PowerShell复制目录：`copy 目录路径 目标路径`

##### 文件操作

- 创建：`cd > 文件.后缀`

- 删除

  > 可以用 `*.后缀` 删除全部拥有某后缀的文件

  - cmd：`del 文件名.后缀`
  - PowerShell：`del 文件名.后缀` 或 `rm 文件名.后缀`
  - Mac：`rm 文件名.后缀`

- 剪切/移动

  - cmd：`move 文件名.后缀 目标目录`
  - PowerShell：2种都行
  - Mac：`move 文件.后缀 目标`

- 复制：`copy -选项 参数`

  ```shell
  # 可同时选择多个选项，例如：-rfv
  
  -a：此参数的效果和同时指定"-dpR"参数相同；
   
  -d：当复制符号连接时，把目标文件或目录也建立为符号连接，并指向与源文件或目录连接的原始文件或目录；
   
  -f：强行复制文件或目录，不论目标文件或目录是否已存在；
   
  -i：覆盖既有文件之前先询问用户；
   
  -l：对源文件建立硬连接，而非复制文件；
   
  -p：保留源文件或目录的属性；
   
  -R/r：递归处理，将指定目录下的所有文件与子目录一并处理；
   
  -s：对源文件建立符号连接，而非复制文件；
   
  -u：使用这项参数后只会在源文件的更改时间较目标文件更新时或是名称相互对应的目标文件并不存在时，才复制文件；
   
  -S：在备份文件时，用指定的后缀“SUFFIX”代替文件的默认后缀；
   
  -b：覆盖已存在的文件目标前将目标文件备份；
   
  -v：详细显示命令执行的操作。
  ```

- 

- 创建文件：`touch 文件名`

##### 文件内容操编辑

- 编辑内容：`vim 文件名`

- 查看内容

  - 最后一页：`cat 文件名`

  - 逐行、逐页查看：`more 文件名` 或 `less 文件名`

    > Enter换行，Space翻页，q退出
    >
    > less支持PageDown和PageUp，可以按键盘上下方向键显示上下内容,more不能通过上下方向键控制显示
    >
    > less **不必读整个文件**，加载速度会比more更快
    >
    > less **退出后shell不会留下刚显示的内容**，而more退出后会在shell上留下刚显示的内容

- 检索内容：`grep [options] pattern file`

  > global regular expression print

  ```shell
  # 从test开头文件中，查找含有start的行
  grep "start" test*
  # 查看包含https的行，并展示前1行(-A)，后1行(-B)
  grep -A 1 -B 1 "https" wget-log
  ```

- 数据统计：`awk [options] 'cmd' file`

  > **一次读取一行** 文本，按输入分隔符进行切片，切成多个组成部分。
  >
  > **将切片直接保存在内建的变量中**，$1,$2…($0表示行的全部)。
  >
  > 支持对单个切片的判断，支持循环判断，默认分隔符为空格。

- 

##### 权限

- 查看权限：`ls -l 文件名`

  ```shell
  -rw-r--r-x 1 king staff 51 3 14 17:42 Helloworld.sh
  ```

  - 文件类型

    - 文件：`-`
    - 文件夹：`d`

  - 权限

    > 当前用户、组成员、其他用户

  - 文件inode数量

  - 当前用户

  - 组名称

  - 文件大小

    > 单位是 byte

  - 最后修改时间

  - 文件名

- 修改权限：`chmod [用户][操作][权限] 文件名`

  - 用户
    - 文件拥有者：u
    - 组：g
    - 其他用户：o
    - 全部：a
  - 操作
    - 增加：+
    - 取消：-
    - 设定：=
  - 权限：r w x

##### 执行

> ``

------







# Shell脚本

### 变量

> 是指此脚本使用/bin/bash来解释执行。其中，#!是一个特殊的表示符，后面紧跟着解释此脚本的shell路径

##### 系统变量

> 都以 `$` 为前缀

```shell
# Shell常见的变量之一系统变量，主要是用于对参数判断和命令返回值判断时使用，系统变量详解如下：

$0 		当前脚本的名称；
$n 		当前脚本的第n个参数,n=1,2,…9；
$* 		当前脚本的所有参数(不包括程序本身)；
$# 		当前脚本的参数个数(不包括程序本身)；
$? 		指令或程序执行完后的状态，返回0表示执行成功；
$$ 		程序本身的PID号。
```

##### 环境变量

```shell
#Shell常见的变量之二环境变量，主要是在程序运行时需要设置，环境变量详解如下：

PATH  		命令所示路径，以冒号为分割；
HOME  		打印用户家目录；
SHELL 		显示当前Shell类型；
USER  		打印当前用户名；
ID    		打印当前用户id信息；
PWD   		显示当前所在路径；
TERM  		打印当前终端类型；
HOSTNAME    显示当前主机名；
PS1         定义主机命令提示符的；
HISTSIZE    历史命令大小，可通过 HISTTIMEFORMAT 变量设置命令执行时间;
RANDOM      随机生成一个 0 至 32767 的整数;
HOSTNAME    主机名
```

##### 用户变量

- 定义：`名称=值`
- 取值/使用：`$名称`



### 基础语法

##### 执行命令行操作

> 直接输入即可

```shell
#!/bin/bash

cd /Users/king/CardSango
pwd
ls
```

![image-20230420173907203](C:\Users\Administrator\Documents\Transfer-Station\WorkNote\开发.assets\image-20230420173907203.png)



##### 输出 echo

- 程序

  ```shell
  echo "$0 Hello world! $1 $2"
  
  # 字体颜色
  for i in {31..37}; do
  echo -e "\033[$i;40mHello world!\033[0m"
  done
  # 背景颜色
  for i in {41..47}; do
  echo -e "\033[47;${i}mHello world!\033[0m"
  done
  # 显示方式
  for i in {1..8}; do
  echo -e "\033[$i;31;40mHello world!\033[0m"
  done
  ```

- 结果
  ![image-20230315145405086](C:\Users\Administrator\Documents\Transfer-Station\WorkNote\开发.assets\image-20230315145405086.png)

##### 数学运算

```shell
let add=$add+1
((add++))
```

##### 流程控制

- 条件

  - 格式

    ```shell
    if [表达式]; then
    	#...
    elif [表达式]; then
    	#...
    else
    	#...
    fi
    ```

  - 常用运算符

    - 数学运算

      ```shell
      -eq		等于，应用于整型比较 equal;
      -ne		不等于，应用于整型比较 not equal;
      -lt		小于，应用于整型比较 letter;
      -gt		大于，应用于整型比较 greater;
      -le		小于或等于，应用于整型比较;
      -ge 	大于或等于，应用于整型比较;
      ```

    - 逻辑运算

      ```shell
      -a		双方都成立（and） 逻辑表达式 –a 逻辑表达式;
      -o		单方成立（or） 逻辑表达式 –o 逻辑表达式;
      ||      单方成立;
      &&      双方都成立表达式。
      ```

    - 其他

      ```shell
      -f	 	判断文件是否存在 eg: if [ -f filename ];
      -d	 	判断目录是否存在 eg: if [ -d dir     ];
      -z		空字符串;
      -x      是否具有可执行权限
      ```

  - 示例

    - 判断目录是否存在

      ```shell
      #!/bin/bash
      # this is check directory 
      # by author rivers on 2021-9.27 
      if  [  !  -d  /data/rivers  -a  !  -d  /tmp/rivers  ]；then
      	mkdir  -p  /data/rivers  
      fi
      ```

    - 判断输入的成绩是否有误

      ```shell
      #!/bin/bash
      # 输入成绩，判断
      
      grade=$1
      
      if [ ! -n "$1" ]; then
          echo "没有输入"
      elif [ $grade -ge 0 ]; then
          echo $grade
      else
          echo "成绩有误！"
      fi
      ```

- 循环

  - for

    - 格式

      ```shell
      for 变量 in 取值列表; do
      	#...
      done
      ```

    - 取值列表

      ```shell
      #数字
      for i in {31..37}; do
          #...
      done
      ```

    - 示例

  - while

    ```shell
    while [表达式]; do
    	#...
    done
    ```

  - 示例

    ```shell
    #示例 1：在死循环中，满足条件终止循环
    while true; do
      let N++
      if [ $N -eq 5 ]; then
        break
    fi
      echo $N
    done
    #输出： 1 2 3 4
    
    #示例 2：举例子说明 continue 用法
    N=0
    while [ $N -lt 5 ]; do
      let N++
    if [ $N -eq 3 ]; then
      continue
    fi
      echo $N
    done
    #输出： 1 2 4
    
    # 打印 1-100 数字
    i=0
    while ((i<=100))
    do
            echo  $i
            i=`expr $i + 1`
    done
    ```

- 选择

  - case

    ```shell
    #!/bin/bash
    
    choice=$1
    case $choice in
        1)
            echo "1";;
        2)
            echo "2";;
        *)  
            echo "无效"
    esac
    
    choice=$2
    case $choice in
        a)
            echo "A";;
        b)
            echo "B";;
        *)  
            echo "无效"
    esac
    ```

    ![image-20230315161558853](C:\Users\Administrator\Documents\Transfer-Station\WorkNote\开发.assets\image-20230315161558853.png)

  - select

##### 函数

> Shell编程函数默认不能将参数传入（）内部，Shell函数参数传递在调用函数名称传递，
>
> 例如：`name args1 args2`

```shell
#!/bin/bash

func() 
{
    VAR=$((1+$1))
    return $VAR
    echo "This is a function."
}
func 2
echo $?		# 输出 3
```

##### 其他

- 管道：`|`

  > 可以将一条命令执行的结果传递给下一条命令

  ```shell
  cat a.txt | grep ">" | wc -l
  
  # cat是打开一个文本文件的命令，|是管道，就是将cat命令的结果传给下一个命令，这里是grep
  # grep是搜索命令，这里所有匹配“>” ，并将结果传给wc命令
  # wc命令是统计命令，如文件的字符数等，wc -l是统计行数
  
  
  cat $list_file | grep "Resources" |awk -F "Resources" '{print($2)}' | grep -v ^$ > ./filetmp
  # 查看list_file保存的文件的内容
  # 查找有"Resource"的行
  # 将这些行以Resource进行切分，将切分结果的第二个元素保存在结果集
  # 反选，将内容保存在./filetmp
  ```

  



### 数据结构

##### 数组

- 定义

  - 直接初始化：`arr=(1 2 3)`
  - 新建并添加元素：`arr[index]=元素`

- 遍历

  ```shell
  #!/bin/bash
  
  arr=("dsh" "htm" "zrq" "cwf")
  
  for ((i=0;i<${#arr[*]};i++)); do
      echo ${arr[$i]}
  done
  
  
  for name in ${arr[*]}; do
      echo $name
  done
  ```

- 