@echo off
setlocal EnableDelayedExpansion 

@rem set currentPath=%~dp0%

@rem  ��ȡ�Ͻ������ļ���
set input=%1

@echo ################################################################
@echo                     ��Ƶ��ʽת���ű�                   
@echo                         ����   ��ʤ��                         
@echo ################################################################
@echo

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

@echo "��������Ҫ����ĸ�ʽ���ƣ��� mp3, wav, m4a, aac �ȣ�Ȼ��س�"
set /p outPutFormat=
if /i "%outPutFormat%" neq %houzui% (
	echo "�����õ������ʽ��ԭ�ļ���ʽһ�£�����Ҫת�����밴������˳�"
	pause>nul
	goto :End
)
if /i "%outPutFormat%" neq "mp3" (
	if /i "%outPutFormat%" neq "wav" (

		if /i "%outPutFormat%" neq "m4a" (
			if /i "%outPutFormat%" neq "aac" (
				echo "������ĸ�ʽ��֧�֣���������˳�" 
				pause>nul
				goto End
			)
		)
	)
)
@rem ����ѹ��������ƣ� ������ԭ�� +  .mp3(ת����ĸ�ʽ)
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
@rem echo ffmpeg -i %input%  %newName%

call ffmpeg -i %input%  %newName% 

:End 
@rem echo "������ ��������˳�"
