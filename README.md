# mpv-configuration
本仓库包含我目前正在使用的MPV播放器配置信息，还囊括一些由其他作者开发的脚本文件  
This repository contains the configuration of MPV Player that I am using, including some scripts written by other authors  
  
## Windows 10平台，MPV多媒体播放器的配置文件位于 %AppData%\mpv 路径下：
```
mpv
|-mpv.conf
|-input.conf
|-watch_later[optional]
  |-...
|-scripts[optional]
  |-...
|-shaders[optional]
  |-...
```
```mpv.conf```：MPV Player配置文件，主要是自定义窗口、音视频编解码、字幕、OSD表现行为等相关配置  
```input.conf```：MPV Player配置文件，主要是自定义按键映射等相关配置  
```watch_later```：配合save-position-on-quit使用存放最近一次退出时的播放位置。但实际表现欠佳，默认不开启  
```scripts```：顾名思义，用于存放第三方拓展脚本，启动MPV播放器会自动加载目录下的所有脚本  
```shaders```：存放视频渲染着色器，本仓库中该目录下的着色器均为Anime4K项目所开发的实时渲染着色器  
  
本仓库中所有的配置项都有相应的注释说明，大部分是翻译自MPV Player官方手册提供的帮助参考，我尽可能地谨慎翻译了这些内容用于注释，可能存在漏译、错译的情况。  
如果有打算采用本仓库中的配置，不妨在使用前查看一下配置内容和注释，协助您更好地了解这些配置内容的实际表现。  
  
Notes: 本仓库中所有的配置内容仅仅是根据我个人使用习惯进行设定，您可以参考相应注释或MPV Player官方文档进行自定义  
</br>
</br>
## 多媒体播放器软件
### MPV Player
特别鸣谢：MPV Player开发团队

项目地址：[mpv](https://github.com/mpv-player/mpv)
</br>
</br>
## 功能拓展脚本
### mpv-playlist-navigator
特别鸣谢：Dave Rogers drogers141

项目地址：[mpv-playlist-navigator](https://github.com/drogers141/mpv-playlist-navigator)

备注：我尽可能地翻译、补充了脚本文件中的注释内容，以便快速了解各代码段的功能进行自定义修改
      所以本仓库收录的脚本与原项目有一定的差异，但整体功能不变。
</br>
</br>
## 实时渲染着色器
### Anime4K v4.0.1 stable
特别鸣谢：Anime4K开发团队

项目地址：[Anime4K](https://github.com/bloc97/Anime4K)
