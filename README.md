# 视频压缩脚本教程

本项目基于FFmpeg ，源码都在了，什么语言环境都不用配置，只需要加一个环境变量，暂时只支持Windows，不支持mac和linux，后续再考虑支持这些系统。

## 一. 视频压缩脚本



* 第一步 得到FFmpeg.zip文件 

```
    git clone https://github.com/anthonyY/VideoCompress.git
    或
    git clone https://gitlab.aiitec.org/Anthony/VideoCompress.git  //（需要权限）
   
```

* 双击执行初始化脚本，瞬间即可完成，按任意键退出，只需执行一次，以后就不用执行了
  注意，非开发人员可以使用这种方式，开发人员不建议使用这种方式，有可能有问题，其实这一步就是加入环境变量，在path环境变量上 加上当前项目下的 \ffmpeg-win64\bin 即可。执行脚本的话，如果你的所有环境变量的字符串长度加起来超过1024，则会有部分内容被截取，导致某个软件使用不了，所有建议自己加入环境变量，就不会有这个问题，看不懂的就是非开发人员，环境变量肯定很少，直接双击脚本就行了。 

  ![init](https://lingmu111-10012243.cos.ap-shanghai.myqcloud.com/init.png)

  ![env](https://lingmu111-10012243.cos.ap-shanghai.myqcloud.com/env.png)

* 打开 “视频压缩脚本” 文件夹，可以看到 “config.properties” 和 “视频压缩和转码.bat” 两个文件 
* 打开 config.properties 文件（用记事本打开），看到如下配置：
    * bitRate=5120 视频比特率  单位kbps
      这个是最重要的，值调大点就更清晰，资源内存占用就更大，调小就更模糊，内存更小。

    * outPutFormat=mp4 输出格式  可以不设置
      如果不设置，以原来的格式输出，比如原来是mp4,压缩后还是mp4,如果设置了，就变成设置后的格式（flv格式是最小但是又比较清晰的格式，可以尝试，mp4是最通用的格式）

    * ~~width=1920 视频宽度 默认和原视频一致，无需设置~~

    * ~~height=1080 视频高度 默认和原视频一致，无需设置~~

    * ~~fps=29  帧率，默认和原视频一致，无需设置~~

    * ~~audioBitRate=256  默认和原视频一致，无需设置~~
      ~~音频比特率 320 256 224 192 128 96 64 32 24 影响音频质量，一般256 到 128，单位kbps~~

    * ~~audioSimpleRate=44100 音频取样率，默认44100，无需设置~~ 

      ![config](https://lingmu111-10012243.cos.ap-shanghai.myqcloud.com/config1.png)
      此配置文件设置 bitRate 和 outputFormat 即可，宽、高、帧率、音频比特率应与原文件一致，不设置即可，视频比特率一般可以设置为原文件的一半，**所有这些选项的值均不应该大于原文件的值**。部分文件已经经过很强压缩的，再压缩会很模糊，或者甚至越压缩越大，所以如果是一些网站上下载的视频不建议再次压缩，自己拍的视频压缩效果显著，我手机拍的26m的视频压缩到6m都还是很清晰。



* 配置文件设置完成后，把要压缩的文件拖到 视频压缩和转码.bat 文件上，即可开始压缩。压缩后的文件保存在源文件目录下，生成的文件自动命名为 “原名_压缩后.mp4/flv/avi”
  ![tuodong](https://lingmu111-10012243.cos.ap-shanghai.myqcloud.com/tuodong.png)
* 注意事项：
    * 初始化(只要运行一次).bat 这个文件只能放在FFmpeg根目录下，不可以移动到其他目录，
    * config.properties 和 视频压缩和转码.bat 文件可以移到方便的地方，但是两者必须在同一目录。
    * 配置文件config.properties 里的每一行如果左边又# 代表不生效，如果想生效，请把#删除 



## 视频格式转换脚本

* 把视频文件拖动到 视频格式转换.bat 上
* 弹出命令窗口提示输入要输出的视频格式名称，输入要转换的格式，如： “avi/mp4/flv/rmvb” 等，即可开始转换
* 自动生成文件 视频频原名.输入的格式， 如原名为  “斗牛.avi”, 输出格式为“mp4”，那么生成的文件是 “斗牛.mp4”



## 三. 音频格式转换脚本

- 把音频文件拖动到 音频格式转换.bat 上
- 弹出命令窗口提示输入要输出的音频格式名称，输入要转换的格式，如： “mp3/m4a/aac” 等，即可开始转换
- 自动生成文件 音频原名.输入的格式， 如原名为  “丢久不见长相思.m4a”, 输出格式为“mp3”，那么生成的文件是 “丢久不见长相思.mp3”



## 四. 视频截图脚本

- 把视频文件拖动到 视频转换.bat 上，即可自动截图，自动生成文件： 视频原名.jpg 文件



------------
