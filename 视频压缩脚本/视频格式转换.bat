@echo off
setlocal EnableDelayedExpansion 

@rem set currentPath=%~dp0%

@rem  ��ȡ�Ͻ������ļ���
set input=%1

@echo ################################################################
@echo                     ��Ƶ��ʽת���ű�                   
@echo                         ����   ��ʤ��                         
@echo ################################################################


@rem ���û�����ļ���ֻ��˫���������
if %input% == "" (
	echo "���϶��ļ���bat�ļ���" 
	pause
	goto End 
)
echo %input%


@rem  ��ȡ��׺
set houzui="%~x1%"
set houzui=%houzui:.=%
echo "��׺ %houzui%"
set newName=

@echo "��������Ҫ�������Ƶ��ʽ���ƣ��� mp4, avi, flv, rmvb �ȣ�Ȼ��س�"
set /p outPutFormat=
if /i "%outPutFormat%" equ %houzui% (
	echo "�����õ������ʽ��ԭ�ļ���ʽһ�£�����Ҫת�����밴������˳�"
	pause>nul
	goto :End
)


if /i  "%outPutFormat%" neq "mp4" (
if /i "%outPutFormat%" neq "avi" (
if /i "%outPutFormat%" neq "flv" (
if /i "%outPutFormat%" neq "rmvb" (
if /i "%outPutFormat%" neq "rm" (
if /i "%outPutFormat%" neq "mov" (
if /i "%outPutFormat%" neq "mkv" (
if /i "%outPutFormat%" neq "wmv" (
if /i "%outPutFormat%" neq "mpeg" (
if /i "%outPutFormat%" neq "3gp" (
if /i "%outPutFormat%" neq "ts" (
if /i "%outPutFormat%" neq "mts" (
if /i "%outPutFormat%" neq "vob" (
	echo "������ĸ�ʽ��֧�֣���������˳�" 
	pause>nul
	goto End
)
)
)
)
)
)
)
)
)
)
)
)
)

@rem ����ѹ��������ƣ� ������ԭ�� +  .mp4(ת����ĸ�ʽ)
set pathFilename=%~dpn1%

set newName="%pathFilename%.%outPutFormat%"
set isSetNewName=false
if exist %newName% (
	@rem echo "%newName% �Ѵ���"
	for /l %%i in (1,1,10) do (
		set tempName="!pathFilename!(%%i).!outPutFormat!"
		if not exist !tempName! (
			if "!isSetNewName!" neq "true" (
				@rem echo !tempName! ������
				set newName="!pathFilename!(%%i).!outPutFormat!"
				set isSetNewName=true
			)
		)
		
	)
)

echo  ffmpeg -i  %input% %newName%
@rem echo ffmpeg -i %input%  %newName%


call ffmpeg -i %input%  %newName% 

:End 
@rem echo "������ ��������˳�"
