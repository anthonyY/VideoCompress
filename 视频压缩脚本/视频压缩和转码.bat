@echo off
setlocal EnableDelayedExpansion 


set currentPath=%~dp0%



::读取配置文件

for /f "tokens=1,2 delims==" %%i in (%currentPath%/config.properties) do (
	if "%%i"=="bitRate" set bitRate=%%jk
	if "%%i"=="width" set width=%%j
	if "%%i"=="height" set height=%%j
	if "%%i"=="fps" set fps=%%j
	if "%%i"=="audioBitRate" set audioBitRate=%%jk
	if "%%i"=="audioSimpleRate" set audioSimpleRate=%%j	
	if "%%i"=="outPutFormat" set outPutFormat=%%j

	
)


@rem  获取拖进来的文件名
set input=%1

@echo ################################################################
@echo                     视频压缩和转码脚本                   
@echo                         作者   杨胜安                         
@echo ################################################################
@echo
@rem 如果没有拖文件，只是双击，则结束
if %input% == "" (
	echo "请拖动文件到bat文件上" 
	goto End 
)

@echo "您要压缩的文件是：%input%"
@echo "宽：%width%"
@echo "高：%height%"
@echo "视频比特率：%bitRate%bps"
@echo "帧率：%fps%"
@echo "音频比特率：%audioBitRate%bps"
if "%outPutFormat%" neq "" (
	@echo "输出格式：%outPutFormat%"
)
@echo "是不是你想要的参数，确认输入'y' 然后回车， 不是按其他任意键回车"
set /p isOk=
if "%isOk%" neq "y" (
	goto End
)




@rem  获取后缀
set houzui="%~x1%"
set newName=


@rem 设置压缩后的名称， 规则是原名 + _压缩后 .mp4(原来的后缀)
set pathFilename=%~dpn1%
if "%outPutFormat%" neq "" (
	@rem set yasuo="_压缩后."
	set newName="%pathFilename%_压缩后.%outPutFormat%"
) else (
	if %houzui% equ ".mp4" (
		set newName=%input:.mp4=_压缩后.mp4%
	) else (
		if  %houzui% equ ".flv" (
			set newName=%input:.flv=_压缩后.flv%
		) else (
			if  %houzui% equ ".avi" (
				set newName=%input:.avi=_压缩后.avi%
			)
		)
	)
)



call ffmpeg.exe -i %input% -ab %audioBitRate% -b %bitRate% -r %fps% -s "%width%x%height%" %newName% 



:End 
@rem echo "结束了 按任意键退出"



