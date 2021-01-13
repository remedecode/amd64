用于在内核中注册 qemu user 使用。https://github.com/multiarch/qemu-user-static

使用如下命令构建 Docker 镜像：

```bash
docker build -t registry.icp.com:5000/multiarch/qemu-user-register:1.0.0 .
```

仓库地址：[registry.icp.com:5000/multiarch/qemu-user-register](http://registry.icp.com:5000/harbor/projects/1250/repositories/multiarch%2Fqemu-user-register)

使用如下命令即可在内核注册相关命令：

```bash
docker run --privileged --rm registry.icp.com:5000/multiarch/qemu-user-register:1.0.0
```

或者使用 `--reset` 命令清除已注册的内容后重新注册：

```bash
docker run --privileged --rm registry.icp.com:5000/multiarch/qemu-user-register:1.0.0 --reset
```

`--privileged` 是让 Docker 容器拥有真正的 root 权限，这样才可以对相关文件进行写入。

---

如果在 Pod 中运行容器，也需要增加真正的 root 权限。

参考：https://www.orchome.com/1305

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
spec:
  containers:
    - name: hello-world-container
      # The container definition
      # ...
      securityContext:
        privileged: true
```
