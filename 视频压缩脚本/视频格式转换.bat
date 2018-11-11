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

@echo "��������Ҫ�������Ƶ��ʽ���ƣ��� mp4, avi, flv, rmvb �ȣ�Ȼ��س�"
set /p outPutFormat=


set formats=mp4 avi flv rmvb rm mov mkv wmv mpeg 3gp ts mts vob swf
set isFormatCorrect=false

for  %%i in (%formats%) do (

   if "!isFormatCorrect!" neq "true" (
      if /i "!outPutFormat!" equ "%%i" (
         set isFormatCorrect=true
      ) 
   )
)

if "%isFormatCorrect%" neq "true" (
	echo "������ĸ�ʽ��֧�֣���������˳�" 
	pause>nul
 	goto End
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
 

call ffmpeg -i %input%  %newName% 

:End 
@rem echo "������ ��������˳�"
