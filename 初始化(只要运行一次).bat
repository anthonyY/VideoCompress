@echo off



set ENV_PATH=%PATH%
@echo ====��ǰ����������

@rem @echo %ENV_PATH%
 


set currentPath=%cd%
set FFMPEG_PATH=%currentPath%\ffmpeg-win64\bin
echo %FFMPEG_PATH%
@echo %PATH% | findstr /c:%FFMPEG_PATH%>nul
echo "errorlevel  = %errorlevel%"


if "%errorlevel%" == "0" (
 	echo "�Ѱ���"

 ) else (
	echo "������"
	
	setx  "PATH" "%FFMPEG_PATH%;%ENV_PATH%
 /m<nul"
	echo ====�»���������


)
@echo %PATH%

echo "��ʼ�����"
pause 