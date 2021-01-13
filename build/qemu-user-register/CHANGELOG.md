
#1.1.0

1.1.0 Release 2020-09-30 by wangshibin@inspur.com
1.1.0 主要修改QEMU_BIN_DIR为/kaniko,因为：

##问题：
对于多阶段构建，例如：

FROM registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0

RUN touch /root/wangshibin

FROM registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0

COPY --from=0 /root/wangshibin /root/

RUN ls

##会出现以下问题，构建日志如下：

[Build] [36mINFO[0m[0000] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0000] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0000] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0000] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0001] Built cross stage deps: map[0:[/root/wangshibin]] 
[Build] [36mINFO[0m[0001] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0001] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0001] Executing 0 build triggers                   
[Build] [36mINFO[0m[0001] Unpacking rootfs as cmd RUN touch /root/wangshibin requires it. 
[Build] [36mINFO[0m[0003] RUN touch /root/wangshibin                   
[Build] [36mINFO[0m[0003] Taking snapshot of full filesystem...        
[Build] [36mINFO[0m[0009] Resolving 5773 paths                         
[Build] [36mINFO[0m[0010] cmd: /bin/sh                                 
[Build] [36mINFO[0m[0010] args: [-c touch /root/wangshibin]            
[Build] [36mINFO[0m[0010] Running: [/bin/sh -c touch /root/wangshibin] 
[Build] [36mINFO[0m[0010] Taking snapshot of full filesystem...        
[Build] [36mINFO[0m[0011] Resolving 5774 paths                         
[Build] [36mINFO[0m[0012] Saving file root/wangshibin for later use    
[Build] [36mINFO[0m[0012] Deleting filesystem...                       
[Build] [36mINFO[0m[0012] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0012] Retrieving image manifest registry-jinan-lab.inspurcloud.cn/service/devops/runtime/golang-arm64:2.0.0 
[Build] [36mINFO[0m[0012] Executing 0 build triggers                   
[Build] [36mINFO[0m[0012] Unpacking rootfs as cmd COPY --from=0 /root/wangshibin /root/ requires it. 
[Build] [36mINFO[0m[0014] COPY --from=0 /root/wangshibin /root/        
[Build] [36mINFO[0m[0014] Resolving 1 paths                            
[Build] [36mINFO[0m[0014] Taking snapshot of files...                  
[Build] [36mINFO[0m[0014] RUN ls                                       
[Build] [36mINFO[0m[0014] Taking snapshot of full filesystem...        
[Build] [36mINFO[0m[0020] Resolving 5771 paths                         
[Build] [36mINFO[0m[0020] cmd: /bin/sh                                 
[Build] [36mINFO[0m[0020] args: [-c ls]                                
[Build] [36mINFO[0m[0020] Running: [/bin/sh -c ls]                     
[Build] error building image: error building stage: failed to execute command: starting command: fork/exec /bin/sh: no such file or directory

##分析原因

kaniko,打镜像。
对于多阶段构建（包含多个FROM的Dockerfile）,执行前面阶段的指令后，kaniko会执行一次Deleting filesystem...删除前面解压的文件系统，如构建日志显示

kaniko在删除系统文件时，有个白名单列表，包含/kaniko ,/busybox等一些文件夹和文件，但不包括/usr/bin/qemu-aarch64-static,/usr/bin/qemu-mips64el-static文件，
所以在Deleting filesystem...后，qemu的两个二进制模拟程序也被删除了。就导致了，当后面的FROM语句下包含RUN指令时，由于是arm64架构类的程序，但是缺少模拟程序的情况下，就无法
运行了，即上面的/bin/sh not found问题（不止/bin/sh只要是第二个FROM解压出来的程序都无法运行）。
所以经过分析，有两种解决方案：
一：改kaniko源码，把/usr/bin/qemu-aarch64-static,/usr/bin/qemu-mips64el-static两个程序也作为白名单下的程序，不被删除
二：更改qemu-user-register的QEMU_BIN_DIR变量为/kaniko
综合考虑选择第二种方案，减少kaniko镜像后续升级时的不必要的配置



#1.0.0

1.0.0: 参考1.0.0/README.md介绍