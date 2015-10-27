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
  s.source_files  = "DWCategory/**/*" #需要被集成的代码文件夹
  s.requires_arc = true   #项目是否使用 ARC
end