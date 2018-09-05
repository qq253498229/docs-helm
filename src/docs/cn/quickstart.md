# 快速开始

本章节介绍了如何快速开始使用Helm。

- [先决条件](#先决条件)
  - [安装Kubernetes或者拥有群集的访问权](#安装Kubernetes或者拥有群集的访问权)
  - [了解安全上下文](#了解安全上下文)
- [安装Helm](#安装Helm)
- [初始化Helm并安装Tiller](#初始化Helm并安装Tiller)
- [安装Chart示例](#安装Chart示例)
- [了解版本](#了解版本)
- [卸载一个版本](#卸载一个版本)
- [阅读帮助文本](#阅读帮助文本)

## 先决条件

要想成功并且正确安全地使用Helm，需要满足以下先决条件。

1. Kubernetes集群
2. 确定要应用于安装的安全配置（如果有）
3. 安装和配置好集群端的Helm和Tiller服务。

### 安装Kubernetes或者拥有群集的访问权

- 您必须提前安装Kubernetes。 对于Helm的最新版本，我们推荐Kubernetes的最新稳定版本，在大多数情况下是最新的次要版本。
- 您还应该有一个本地配置的`kubectl`副本。

注意：Kubernetes1.6版本之前对基于角色的访问控制（RBAC）的支持有限或不支持。

Helm会通过读取您的Kubernetes配置文件（通常是 `$HOME/.kube/config`）来找出安装Tiller的位置。
这与`kubectl`使用的文件相同。

要找出Tiller将安装到哪个群集，您可以运行

`kubectl config current-context` 或 `kubectl cluster-info`.

结果如下：

```console
$ kubectl config current-context
my-cluster
```

### 了解安全上下文

与所有强大的工具一样，请确保为您的方案正确安装它。

如果您在拥有完全控制权的群集上使用Helm, 例如 minikube 或是一个不担心共享文件的私人网络集群, 那么默认安装方式 -- 它不提供任何安全配置 -- 就不错, 并且这也是最简单的。
无需其他安全步骤即可安装Helm, [安装 Helm](#安装Helm) 然后 [初始化 Helm](#初始化Helm并安装Tiller)。

但是，如果您的群集暴露到公网的，或者您与其他群组共享群集 -- 生产集群属于这一类 -- 您就必须采取额外的步骤，以防止粗心或恶意用户来破坏群集或其数据. 要启用Helm在生产环境和其他多用户方案中的安全配置，请查看[Helm安全的安装方式](securing_installation.html)

如果您的群集启用了基于角色的访问控制（RBAC），在下一步之前您可能需要[配置服务帐户和规则](rbac.html)。

## 安装Helm

下载Helm客户端的二进制版本。
您可以使用像 `homebrew` 这样的工具安装, 也可以查看 [官方的版本发布页面](https://github.com/kubernetes/helm/releases) 下载。

有关更多详细信息或其他选项，请查看[安装指南](install.html).

## 初始化Helm并安装Tiller

在准备好 Helm 之后, 就可以初始化本地cli, 然后使用下面的步骤在您的Kubernetes集群中安装:

```console
$ helm init
```

这个步骤会将Tiller安装到您使用 `kubectl config current-context` 看到的Kubernetes集群中。

**提示:** 想在不同的集群安装？请使用 `--kube-context` 选项。

**提示:** 当您想要升级Tiller的时候, 只需运行 `helm init --upgrade`。

默认情况下，安装Tiller时没有启用身份验证。
要了解有关为Tiller配置强TLS身份验证的更多信息，请参阅[Tiller TLS指南](tiller_ssl.html)。

## 安装Chart示例

要安装 chart, 您可以运行 `helm install` 命令。 
Helm有几种方法可以发现并安装chart，但最简单的方法是使用官方的 `stable` charts。

```console
$ helm repo update              # 确保我们已经获取到最新的Charts列表
$ helm install stable/mysql
Released smiling-penguin
```

在上面的例子中, `stable/mysql` 这个 chart 被发布了, 我们新发布的名称为 `smiling-penguin`。
通过运行 `helm inspect stable/mysql` ，您可以简单地了解这个MySQL chart的功能。

每当您安装chart时，都会创建一个新版本。
因此，可以将多个chart分多次安装到同一个集群中。
每个chart都可以独立管理和升级。

`helm install` 命令是一个具有许多功能的非常强大的命令。
要了解有关它的更多信息，请查看[使用Helm指南](using_helm.html)

## 了解版本

使用Helm可以快速查看已发布的内容：

```console
$ helm ls
NAME             VERSION   UPDATED                   STATUS    CHART
smiling-penguin  1         Wed Sep 28 12:59:46 2016  DEPLOYED  mysql-0.1.0
```

`helm list` 命令会显示所有已部署版本的列表。

## 卸载一个版本

要卸载一个版本版，请使用 `helm delete` 命令：

```console
$ helm delete smiling-penguin
Removed smiling-penguin
```

这将从Kubernetes中卸载`smiling-penguin`，但您仍然可以查看有关该版本的信息：

```console
$ helm status smiling-penguin
Status: DELETED
...
```

因为Helm会在您删除它们后跟踪它们，所以您仍然可以查看集群的历史记录，甚至取消删除一个版本（使用`helm rollback`）。

## 阅读帮助文本

要了解有关可用Helm命令的更多信息，请使用`helm help`，或在输入一个命令后，加上`-h`标志：

```console
$ helm get -h
```
