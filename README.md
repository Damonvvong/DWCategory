# CocoaPods 1.0 + 适配

> CocoaPods 1.0 发布4个多月了。之前的写的笔记过时了，抽空更新一波。同时解决一下图片不能看的问题。鉴于写完之前的总结之后很多人问我怎么弄私有 Pod ，今天会写一下。

# 目录
  - [CocoaPods 1.0 安装及适配 ](https://github.com/Damonvvong/DWCategory#CocoaPods10)
  - [利用 CocoaPods 发布自己的三方库](https://github.com/Damonvvong/DWCategory#CocoaPodsPos)
  - [CocoaPods 1.0 私有 Pods ](https://github.com/Damonvvong/DWCategory#CocoaPodsPPos)


--- 

<a id="CocoaPods10"></a>
## CocoaPods 1.0 安装及适配 

- 如何安装？命令行中输入 `sudo gem install cocoapods`

> 遇到 `Operation not permitted - /usr/bin/pod` 可以参照[这里](http://stackoverflow.com/questions/30812777/cannot-install-cocoa-pods-after-uninstalling-results-in-error/30851030#30851030)

- 有何变化？[没用过旧版的可以忽略]
    - 必须指明 target
    - `:exclusive => true` 和 `link_with` 被去掉了
    - 使用本地的 pod 只能使用 :path
    - pod install 不再更新本地 repo
    - pod install --repo-update 更新本地 repo 在安装 pods
    - ...

---

<a id="CocoaPodsPos"></a>
## 利用 CocoaPods 发布自己的三方库

- 将自己的三方库集成 CocoaPods 只需要三步
    - 1. 初始化项目
    - 2. 创建和编写 podspec
    - 3. 将 podspec 上传到 CocoaPods 的 repo 上

### 1.初始化项目

- 如何初始化可以看[这里](https://github.com/Damonvvong/DWCategory#GitHubInit)
- 原理上 Cocoapods 支持任意源代码管理(例如 git svn)的开源仓库。只要用户可以根据 url 下载到项目的网址都可以。所以不局限于GitHub。但是今天我们以 GitHub 为例。
- 项目初始化结束之后,需要给项目打 `tag` 以便告诉 Cocoapods 自己项目的最新版。每发一版需要一个 tag

```git
// push to remote
git add .
git commit -m "初始化项目"
git push

//add tag 
git tag -m "2rd release" 0.2.0
git push --tags
```

### 2.创建和编写 podspec [ 最重要的一步 ]

- 你可以创建一个名字叫做 XXX.podspec 空文件。 
- 也可以通过 ` pod spec create DWCategory git@github.com:Damonvvong/DWCategory.git ` 创建一个有备注的 podspec
- 编写 podspec 文件：

``` ruby
Pod::Spec.new do |s|

  s.name         = "DWCategory"                           # 名称
  s.version      = "0.2.0"                                # 版本号，git 的 tag
  s.summary      = "一个简单的分类用于测试 Cocoapods 1.0 +"

  s.description  = <<-DESC
                    - 测试 pod
                    - Cocoapods 1.0
                    - description 需要比 summary 长
                   DESC

  s.homepage     = "https://github.com/Damonvvong"
  s.license      = { :type => "MIT", :file => "LICENSE" }                    # 开源协议

  s.author       = { "Damonwong" => "coderonevv@gmail.com" }
  s.platform     = :ios, "8.0"                                               # 支持的平台及版本
  s.source       = { :git => "https://github.com/Damonvvong/DWCategory.git", :tag => "#{s.version}" }
  # 项目地址作为开源项目，这里不能使用 ssh 
  s.source_files  = "DWCategory", "DWCategory/**/*.{h,m}"                    # 模块文件路径配置
  s.exclude_files = "Classes/Exclude"
  s.module_name   = 'DWCategory'                                             # 模块名称
end
```
- 编写完运行 `pod lib lint ` ，出现如下图 运行无误

![](http://7xlv6p.com1.z0.glb.clouddn.com/2016-09-21-14743887788131.jpg)


### 3. 将 podspec 上传到 CocoaPods 的 repo 上

> 利用[Trunk](http://guides.cocoapods.org/making/getting-setup-with-trunk.html)把自己的 DWCategory.podspec 文件上传给 Cocoapods
    

#### 1.注册

```
pod trunk register coderonevv@gmail.com 'Damonwong' --verbose
```
- coderonevv@gmail.com：自己的邮箱
- Damonwong：用户名（最好和.podspec 文件 中一样）

#### 2.检查是否注册成功
- 登录邮箱，确认注册

- 检查注册情况：pod trunk me（看到类似下面，就是成功了）

```
pod trunk me
  - Name:     Damonwong
  - Email:    coderonevv@gmail.com
```

#### 3.上传DWCategory.podspec 到 Cocoapods/repo
- 进入 文件所在文件夹
```
	cd /Users/damon/Desktop/DWCategory 
```
- 上传文件

```
pod trunk push /Users/damon/Desktop/DWCategory 
```
![](http://7xlv6p.com1.z0.glb.clouddn.com/2016-09-21-14743893395429.jpg)

#### 4.上传完成，查找一下

```
pod search DWCategory
```
![](http://7xlv6p.com1.z0.glb.clouddn.com/2016-09-21-14743893649835.jpg)

## Done! 现在可以用 `pod 'DWCategory' ` 来导入了

---

<a id="CocoaPodsPPos"></a>
## CocoaPods 1.0 私有 Pods

- 创建一个私有 pods 需要三个东西
    - 1. 私有的代码管理仓库
    - 2. 私有的 repo 
    - 3. 私有 pod


### 1. 私有的代码管理仓库

- 搭建在自己服务器的源代码管理仓库，例如 GitLab 

### 2. 私有的 repo 【非必要】

- repo 是什么？
    - repo 其实就是一个索引表。一个管理 .podspec 文件夹的索引。下图是从[这里](https://github.com/CocoaPods/Specs) 下载的 master 的目录结构(在下系统的`~/.cocoapods/repos/master`)。Specs 下存放了Cocoapods 几乎所有开源的项目索引。例如 AFNetworking 下有每一个版本(tag)对应的 podspec。
- 所以，我们也要自己先搞一个私有的 repo
    - 1.在私有源代码管理上创建一个空仓库。
    - 2.到本地 在命令行中输入 `pod repo add REPO_NAME SOURCE_URL` 期中REPO_NAME 是你的 repo 名字 例如 DWRepo , SOURCE_URL 是你的 空仓库的 地址。【这一步在本地的`~/.cocoapods/repo` 下初始化了一个 DWRepo,同时 git push 到了 SOURCE_URL】

    ![](http://7xlv6p.com1.z0.glb.clouddn.com/2016-09-21-14744505463235.jpg)

### 3. 私有 pod
- 这一步[这里](https://github.com/Damonvvong/DWCategory#GitHubInit)步骤类似。只需要把代码仓库改为私有的就行。

- 创建和编写 podspec。
    - 这一步大致与 **CocoaPods 1.0 安装及适配 ** 的一致。只需要把 `s.source       = { :git => "改成私有地址" }`即可。记得用 `pod lib lint` 是否有问题
    

-  创建完  podspec 不再是用 trunk 上传自己的 podspec 了。你需要用 `pod repo push DWRepo DWCategory.podspec` 将.podspec 上传到自己的 repo 中。【这一步，先将 DWCategory.podspec 拷贝到了 自己的 repo 中，再将 repo 同步到服务器上】

### ok！Done。

---

### 关于私有 pod

- 你可以按照上面步骤搭建一个 类似 Cocoapods 的 方案
- 其实你可以省略 repo 直接在 pod 的时候添加 code 源 例如 ：

```
    platform :ios, "8.0"

source 'https://github.com/CocoaPods/Specs.git'

target 'CocoaPods2' do
	pod 'DWCategory', :git => '这里写上私有库的源'
end

```
- 当然上面的 :git 可以改为 :path 来导入本地的 库


---

### <a id="GitHubInit"></a>1.在 GitHub 初始化一个分类仓库（DWCategory）

![Category.png](http://7xlv6p.com1.z0.glb.clouddn.com/Category_min.png)

### 2.clone 到本地，配置文件，再上传

- 把 GitHub 上的项目克隆到本地。(打开终端，cd 到桌面)

``` 
git clone git@github.com:Damonvvong/DWCategory.git

```
![Category_Clone](http://7xlv6p.com1.z0.glb.clouddn.com/Category_Clone.png)

> 这里是利用 SSH 方式 clone,配置 SSH[教程传送门](https://help.github.com/articles/generating-ssh-keys/)

- 把自己的分类放入桌面的DWCategory文件夹中,如下。

![Dir](http://7xlv6p.com1.z0.glb.clouddn.com/Dir.png)




> 本文编辑于 2016年9月20日

