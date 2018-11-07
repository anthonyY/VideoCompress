@echo off
setlocal EnableDelayedExpansion 


set currentPath=%~dp0%

set width=
set height=
set audioSimpleRate=44100
set bitRate=
set audioBitRate=
set audioSimpleRate=
set fps=
set outPutFormat=
::读取配置文件

for /f "tokens=1,2 delims==" %%i in (%currentPath%/config.properties) do (
	if "%%i"=="bitRate" set bitRate=%%j
	if "%%i"=="width" set width=%%j
	if "%%i"=="height" set height=%%j
	if "%%i"=="fps" set fps=%%j
	if "%%i"=="audioBitRate" set audioBitRate=%%j
	if "%%i"=="audioSimpleRate" set audioSimpleRate=%%j	
	if "%%i"=="outPutFormat" set outPutFormat=%%j
)


@rem  获取拖进来的文件名
set input=%1

@echo ################################################################
@echo                     视频压缩和转码脚本                   
@echo                         作者   杨胜安                         
@echo ################################################################

@rem 如果没有拖文件，只是双击，则结束
if %input% == "" (
	echo "请拖动文件到bat文件上" 
	goto End 
)
@rem 输入的文件有的有引号，有的没有引号，所以判断一下，没有就加上
if %input:~0,1% neq ^" (
    set input="%input%"
)

@echo "您要压缩的文件是：%input%"
if "%width%" neq "" (
	@echo "宽：%width%"
)
if "%height%" neq "" (
	@echo "高：%height%"
)
if "%bitRate%" neq "" (
	@echo "视频比特率：%bitRate%kbps"
)
if "%audioBitRate%" neq "" (
	@echo "音频比特率：%audioBitRate%kbps"
)
if "%fps%" neq "" (
	@echo "帧率：%fps%"
)
if "%audioSimpleRate%" neq "" (
	@echo "音频采样率：%audioSimpleRate%"
)

if "%outPutFormat%" neq "" (
	@echo "输出格式：%outPutFormat%"
)
@rem @echo "是不是你想要的参数，确认输入'y' 然后回车， 不是按其他任意键回车"
@rem set /p isOk=
@rem if "%isOk%" neq "y" (
@rem	goto End
@rem )




@rem  获取后缀
set houzui="%~x1%"
echo %houzui%

set newName=
set formats=mp4 avi flv mpeg mpg rmvb rm mov mkv wmv 3gp ts mts vob

@rem 设置压缩后的名称， 规则是原名 + _压缩后 .mp4(原来的后缀)
set pathFilename=%~dpn1%
if "%outPutFormat%" neq "" (
	@rem set yasuo="_压缩后."
	set newName="%pathFilename%_压缩后.%outPutFormat%"
) else (
    set isSetOutputName=
    for  %%i in (%formats%) do (
        if "%isSetOutputName%" neq "true" (
            if /i !houzui! equ ".%%i" (
                set newName=!pathFilename!_压缩后.!outPutFormat!
                set isSetOutputName=true
            ) 
        )
    )
)

set isSetNewName=false
if exist %newName% (
    for /l %%i in (1,1,10) do (
        set tempName="!pathFilename!_压缩后(%%i).!outPutFormat!"
        if not exist !tempName! (
            if "!isSetNewName!" neq "true" (
                 @rem echo !tempName! 不存在
                 set newName="!pathFilename!_压缩后(%%i).!outPutFormat!"
                 set isSetNewName=true
            )
        )		
    )
)

set command=ffmpeg.exe -i %input% 

if "%bitRate%" neq "" (
	set command=%command% -b %bitRate%k
)
if "%audioBitRate%" neq "" (
	set command=%command% -ab %audioBitRate%k
)
if "%fps%" neq "" (
	set command=%command% -r %fps% 
)
if "%audioSimpleRate%" neq "" (
	set command=%command% -ar %audioSimpleRate% 
)
if "%width%" neq "" (
	if "%height%" neq "" (
		set command=%command% -s %width%x%height% 
	)
)
set command=%command% %newName%

@rem echo %command%
@rem pause
@rem call ffmpeg.exe -i %input% -ab %audioBitRate%k -b %bitRate%k -r %fps% -s "%width%x%height%" %newName% 


call %command%

:End 
@rem echo "结束了 按任意键退出"



