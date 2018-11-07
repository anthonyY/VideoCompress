@echo off
setlocal EnableDelayedExpansion 

@rem set currentPath=%~dp0%

@rem  ��ȡ�Ͻ������ļ���
set input=%1
set inputStartTime=%2
set inputDuration=%3

@echo ################################################################
@echo                     ��Ƶ�ü��ű�                   
@echo                         ����   ��ʤ��                         
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


@rem ���û�����ļ���ֻ��˫���������
if %input% == "" (
	echo "���϶��ļ���bat�ļ���" 
	pause
	goto End 
)
@rem ������ļ��е������ţ��е�û�����ţ������ж�һ�£�û�оͼ���
if %input:~0,1% neq ^" (
    set input="%input%"
)

echo %input%


@rem  ��ȡ��׺
set houzui="%~x1%"
set houzui=%houzui:.=%

echo "��׺ %houzui%"
set newName=



set pathFilename=%~dpn1%

set newName="%pathFilename%_cut.%houzui%"
set isSetNewName=false
if exist %newName% (
	@rem echo "%newName% �Ѵ���"
	for /l %%i in (1,1,10) do (
		set tempName="!pathFilename!(%%i)_cut.!houzui!"
		if not exist !tempName! (
			if "!isSetNewName!" neq "true" (
				@rem echo !tempName! ������
				set newName="!pathFilename!(%%i)_cut.!houzui!"
				set isSetNewName=true
			)
		)
		
	)
)

echo  ffmpeg -ss %startTime% -t %duration% -accurate_seek -i %input% -codec copy -avoid_negative_ts 1 %newName%



call ffmpeg -ss  %startTime% -t %duration% -accurate_seek -i %input% -codec copy -avoid_negative_ts 1 %newName%

:End 
@rem echo "������ ��������˳�"
