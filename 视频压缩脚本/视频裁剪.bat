@echo off
setlocal EnableDelayedExpansion 

@rem set currentPath=%~dp0%

@rem  获取拖进来的文件名
set input=%1
set inputStartTime=%2
set inputDuration=%3

@echo ################################################################
@echo                     音频裁剪脚本                   
@echo                         作者   杨胜安                         
@echo ################################################################

set startTime=0
set duration=10
for /f "tokens=1,2 delims==" %%i in (%currentPath%/config.properties) do (
	if "%%i"=="startTime" set startTime=%%j
	if "%%i"=="duration" set duration=%%j
)
if "%inputStartTime%" neq "" (
	set startTime=%inputStartTime%
)
if "%inputDuration%" neq "" (
	set duration=%inputDuration%
)


@rem 如果没有拖文件，只是双击，则结束
if %input% == "" (
	echo "请拖动文件到bat文件上" 
	pause
	goto End 
)
@rem 输入的文件有的有引号，有的没有引号，所以判断一下，没有就加上
if %input:~0,1% neq ^" (
    set input="%input%"
)

echo %input%


@rem  获取后缀
set houzui="%~x1%"
set houzui=%houzui:.=%

echo "后缀 %houzui%"
set newName=



set pathFilename=%~dpn1%

set newName="%pathFilename%_cut.%houzui%"
set isSetNewName=false
if exist %newName% (
	@rem echo "%newName% 已存在"
	for /l %%i in (1,1,10) do (
		set tempName="!pathFilename!(%%i)_cut.!houzui!"
		if not exist !tempName! (
			if "!isSetNewName!" neq "true" (
				@rem echo !tempName! 不存在
				set newName="!pathFilename!(%%i)_cut.!houzui!"
				set isSetNewName=true
			)
		)
		
	)
)

echo  ffmpeg -ss %startTime% -t %duration% -accurate_seek -i %input% -codec copy -avoid_negative_ts 1 %newName%



call ffmpeg -ss  %startTime% -t %duration% -accurate_seek -i %input% -codec copy -avoid_negative_ts 1 %newName%

:End 
@rem echo "结束了 按任意键退出"
