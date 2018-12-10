@echo off
setlocal EnableDelayedExpansion 

set currentPath=%~dp0%

@rem  获取拖进来的文件名
set input=%1

@echo ################################################################
@echo                     音频格式转换脚本                   
@echo                         作者   杨胜安                         
@echo ################################################################


@rem 如果没有拖文件，只是双击，则结束
if %input% == "" (
	echo "请拖动文件到bat文件上" 
	pause
	goto End 
)

@rem 输入的文件有的有引号，有的没有引号，所以判断一下，没有就加上
if ^%input:~0,1% neq ^" (
    set input="%input%"
)

echo %input%

@rem  获取后缀
set houzui=%~x1%
set houzui=%houzui:.=%
echo "后缀 %houzui%"

set formats=mp4 avi flv rmvb rm mov mkv wmv mpeg 3gp ts mts vob swf mpg
set isFormatCorrect=false

for  %%i in (%formats%) do (

   if "!isFormatCorrect!" neq "true" (
      if /i "!houzui!" equ "%%i" (
         set isFormatCorrect=true
      ) 
   )
)
if "%isFormatCorrect%" neq "true" (
	echo "您输入的格式不支持，按任意键退出" 
	pause>nul
 	goto End
)



@rem 设置压缩后的名称， 规则是原名 +  .mp4(转换后的格式)
set pathFilename=%~dpn1%

set newName="%pathFilename%.jpg"


%currentPath:~0,2% 
cd %currentPath%
echo ..\ffmpeg-win64\bin\ffmpeg -ss 00:00:05 -i %input% -y -f image2 -t 0.001 %newName% 

call ..\ffmpeg-win64\bin\ffmpeg -ss 00:00:05 -i %input% -y -f image2 -t 0.001 %newName% 


:End 
@rem echo "结束了 按任意键退出"
