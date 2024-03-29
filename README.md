# mpv-configuration
本仓库包含我目前正在使用的MPV播放器配置，以及一些由其他作者开发的优秀脚本<br>
This repository contains the configuration of MPV Player that I am using, including some scripts written by other authors<br>

## 配置说明
- Windows 10平台，MPV多媒体播放器的配置文件位于 %AppData%\mpv 路径下。不过我建议将全部的配置文件放在与软件本体同级目录下的 portable_config 目录中，作用类似于便携版，可以在完整保留设置的情况下，快速在不同PC间迁移部署。<br>
- 此部分的文档汉化说明可以移步至我的这篇拙作：[FILES ON UNIX/WINDOWS](https://www.bilibili.com/read/cv18772653)<br>

<br>

- ```mpv.conf```：MPV Player配置文件，主要是自定义窗口、音视频编解码、字幕、OSD表现行为等相关配置<br>
- ```input.conf```：MPV Player配置文件，主要是自定义按键映射等相关配置<br>
- ```watch_later```：配合save-position-on-quit使用存放最近一次退出时的播放位置。但实际表现欠佳，默认不开启<br>
- ```scripts```：存放第三方拓展脚本，启动MPV播放器会自动加载目录下的所有脚本<br>
- ```scripts-opts```：存放内置或第三方拓展脚本conf文件，启用脚本时会加载并覆盖原始设置。如果您的脚本支持conf配置文件，推荐通过修改脚本的该文件来调节脚本行为，而不是修改脚本本身<br>
- ```shaders```：存放视频渲染着色器，本仓库中该目录下的着色器均为Anime4K项目所开发的实时渲染着色器<br>
- ```profiles```：存放用户自定义的、适用于不同使用场景的profile策略配置项文件，通常一类策略或配置项对应一个配置文件，同大型项目的文件布局类似，允许您快速定位、修改某个具体的配置内容<br>

<br>

- 本仓库中所有的配置项都有相应的注释说明，大部分是翻译自MPV Player官方手册提供的帮助参考，我尽可能地谨慎翻译了这些内容用于注释，可能存在漏译、错译的情况。如果有打算采用本仓库中的配置，不妨在使用前查看一下配置内容和注释，协助您更好地了解这些配置内容的实际表现。<br>
- **注意**：本仓库中所有的配置内容仅仅是根据我个人使用习惯进行设定，您可以参考相应注释或MPV Player官方文档进行自定义。<br>
- **PS**：我正在尝试利用空余时间，尽可能地摘取并汉化个人认为MPV Player官方软件使用手册中比较重要的章节内容，目前已完成若干小篇幅的章节。但因为时间、精力有限，加之我那连业余都算不上的翻译功底，所以更新进度具有不确定性，不过无特殊情况也不会轻易弃坑。如果您有需要且不嫌弃的话可以移步查阅这些文档：[MPV Player Manual(zh-CN)](https://www.bilibili.com/read/readlist/rl617174)<br>

</br>

## 多媒体播放软件
### MPV Player
特别鸣谢：MPV Player开发团队<br>
项目地址：[mpv](https://github.com/mpv-player/mpv)<br>
用户脚本：[User-Scripts](https://github.com/mpv-player/mpv/wiki/User-Scripts)<br>
本仓库的快捷键设置：<br>
- WHEEL_UP    音量 +2
- WHEEL_DOWN  音量 -2

其余同官方默认<br>

</br>

## 功能拓展脚本
### mpv-playlist-navigator (播放列表扩展)
特别鸣谢：Dave Rogers drogers141<br>
项目地址：[mpv-playlist-navigator](https://github.com/drogers141/mpv-playlist-navigator)<br>
本仓库的快捷键设置：脚本默认 (仿vim)，详情见 [scripts/playlist-navigator/main.lua](scripts/playlist-navigator/main.lua) 底部注释说明<br>
备注：我尽可能地翻译、补充了脚本文件中的注释内容，以便您快速了解各代码段的功能进行自定义修改；微调了脚本的部分行为，所以本仓库收录的脚本与原项目有一定的差异，详情见更新日志。<br>

### Anime4K v4.0.1 stable (实时渲染着色器)
特别鸣谢：Anime4K开发团队<br>
项目地址：[Anime4K](https://github.com/bloc97/Anime4K)<br>
本仓库的快捷键设置：<br>
- Ctrl + 1  模式A
- Ctrl + 2  模式B
- Ctrl + 3  模式C
- Ctrl + 4  模式A+A
- Ctrl + 5  模式B+B
- Ctrl + 6  模式C+A
- Ctrl + 7  模式A
- Ctrl + 8  模式B
- Ctrl + 9  模式C
- Ctrl + 0  清除着色器

详情见 [input.conf](input.conf) 相关注释说明。<br>

### 更多已经或正在尝试汉化的 MPV Player 开源“周边”
特别鸣谢：FinnR (bili-uid: 111138665)<br>
作品地址：[mpv player脚本部分汉化](https://www.bilibili.com/read/cv19251824)<br>

<br>

## 更新日志
之前都忘记写更新日志了（逃<br>
### 2023/02/25
#### 优化
##### MPV Player
- 新增跳转文件播放重置暂停状态配置，位置：[mpv.conf](mpv.conf)
- 自定义窗口标题状态信息显示，位置：[mpv.conf](mpv.conf)
- 从 mpv.conf 配置文件中剥离 profile 配置项至 profiles 目录中并按照独立的文件保存配置，位置：[profiles/](profiles/)
- 剔除或注释若干项与播放器默认行为重复、无效以及废弃的配置项

<br>

### 2022/10/30
#### 优化
##### mpv-playlist-navigator
- 进入搜索输入模式后仅需按下 ESC 一次即可返回上级播放列表

#### 修复
##### mpv-playlist-navigator
- 临时修复搜索结果为空后会导致无法再次进入搜索模式（脚本崩溃）的问题，本方案仅作为临时修补，脚本原作者正在修复中

<br>

### 2022/10/30
#### 优化
##### MPV Player
- OSD字体大小调整为36，位置：[mpv.conf](mpv.conf)
- 视频硬解API方案选择调整为 auto-safe，位置：[mpv.conf](mpv.conf)

##### mpv-playlist-navigator
- 汉化脚本OSD菜单说明 (脚本调试菜单未汉化，一般也用不到)
- 修改OSD背景颜色为紫色、字体大小为24、文字边框颜色为黑色使之更贴合mpv的主题，位置：[scripts/playlist-navigator/main.lua](scripts/playlist-navigator/main.lua)
- 调节列表文件状态指示图标及其行为，个人不太喜欢原先允许图标重叠的样式，现在每种状态的列表文件仅对应一种图标，位置：[scripts/playlist-navigator/playlist.lua](scripts/playlist-navigator/playlist.lua)

最终效果演示：<br>
![Sample](img-sample/mpv-playlist-navigator.png)

#### 修复
##### MPV Player
- audio-display 配置调整为 embedded-first，优先显示音频的内嵌封面，原先设置属于无效参数且在终端中会报错
- 从 mpv.conf 剥离出所有关于 osc 内置脚本的配置项，现已单独转移到 [script-opts/osc.conf](script-opts/osc.conf) 配置文件中，原先设置不符合规范且无法生效

#### 已知问题
##### mpv-playlist-navigator
- 进入搜索输入模式后，需要连续键入两次 ESC 才能退出该模式且不会返回到上级播放列表，原本就自带的“特性”，暂不清楚是Bug还是特意这么设计的，我个人是不怎么喜欢，有时间会尝试着修改这部分的代码逻辑。
- 原作者打算修复的问题：目前文件搜索如果失败后会导致无法再次进入搜索模式
