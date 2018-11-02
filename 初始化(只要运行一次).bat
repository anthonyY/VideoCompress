@echo off



set ENV_PATH=%PATH%
@echo ====当前环境变量：

@rem @echo %ENV_PATH%
 


set currentPath=%cd%
set FFMPEG_PATH=%currentPath%\ffmpeg-win64\bin
echo %FFMPEG_PATH%
@echo %PATH% | findstr /c:%FFMPEG_PATH%>nul
echo "errorlevel  = %errorlevel%"


if "%errorlevel%" == "0" (
 	echo "已包含"

 ) else (
	echo "不包含"
	
	setx  "PATH" "%FFMPEG_PATH%;%ENV_PATH%
 /m<nul"
	echo ====新环境变量：


)
@echo %PATH%

echo "初始化完成"
pause 