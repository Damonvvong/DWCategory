---

##导航
- [2015-10-27](https://github.com/Damonvvong/DWCategory#借助 GitHub 托管 Category，利用 CocoaPods 集成到项目中。)

---

#借助 GitHub 托管 Category，利用 CocoaPods 集成到项目中。

###1.在 GitHub 初始化一个分类仓库（DWCategory）

###2.clone 到本地，配置文件，再上传

- 把 GitHub 上的项目克隆到本地。(打开终端，cd 到桌面)

``` 
git clone git@github.com:Damonvvong/DWCategory.git

```
> 这里是利用 SSH 方式 clone,配置 SSH[教程传送门](https://help.github.com/articles/generating-ssh-keys/)

- 把自己的分类放入桌面的DWCategory文件夹中,如下。

- 给仓库创建一个 podspec 文件

```

pod spec create DWCategory git@github.com:Damonvvong/DWCategory.git

```

- 编写 podspec 文件

```
Pod::Spec.new do |s|
  s.name         = "DWCategory"  #名字
  s.version      = "0.1.0"  #版本号
  s.summary      = "Custom Category" #简短的介绍
  s.homepage     = "https://github.com/Damonvvong/DWCategory"   #主页,这里要填写可以访问到的地址，不然验证不通过
  s.license      = "MIT"  #开源协议
  s.author             = { "Damonwong" => "coderonevv@gmail.com" }  #作者信息
  s.social_media_url   = "http://weibo.com/damonone"    #多媒体介绍地址
  s.platform     = :ios, "7.0"    #支持平台及版本
  s.source       = { :git => "https://github.com/Damonvvong/DWCategory.git", :tag => s.version }    #项目地址，这里不支持ssh的地址，验证不通过，只支持HTTP和HTTPS，最好使用HTTPS,
  s.source_files  = "DWCategory/**/*" #代码源文件地址，**/*表示Classes目录及其子目录下所有文件，如果有多个目录下则用逗号分开，如果需要在项目中分组显示，这里也要做相应的设置
  s.requires_arc = true   #项目是否使用 ARC
end

```
- 把当前版本 push 到 GitHub，并上传版本号（podspec 文件的 s.version）

```
// push to remote
git add .
git commit -m "UIView + frame"
git push origin master

//add tag 
git tag -m "first release" 0.1.0
git push --tags
```


- 检查 podspec 文件是否编写正确。

```
pod lib lint

```
- 如果有错误，就把错误修改了，并上传到 GitHub 上

### 利用[Trunk](http://guides.cocoapods.org/making/getting-setup-with-trunk.html)把自己的 DWCategory.podspec 文件上传给 Cocoapods

#####1.注册

```
➜  /Users/damon/Desktop/DWLog git:(master) >pod trunk register coderonevv@gmail.com 'Damonwong' --verbose
```
- coderonevv@gmail.com：自己的邮箱
- Damonwong：用户名（最好和.podspec 文件 中一样）

#####2.检查是否注册成功
- 登录邮箱，确认注册

- 检查注册情况：pod trunk me（看到类似下面，就是成功了）

```
➜  /Users/damon/Desktop/DWLog git:(master) >pod trunk me
  - Name:     Damonwong
  - Email:    coderonevv@gmail.com
```

#####3.上传DWCategory.podspec 到 Cocoapods/repo
- 进入 文件所在文件夹
```
	cd /Users/damon/Desktop/DWCategory 
```
- 上传文件

```
pod trunk push DWCategory.podspec
```

#####4.上传完成，查找一下

```
pod search DWCategory

```

> 下面就可以通过编写Podfile 文件，利用 Cocoapods 集成自己写的文件了

```

platform :ios, "6.0"
pod 'DWCategory'

```

#Done！
