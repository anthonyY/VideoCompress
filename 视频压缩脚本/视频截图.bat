@echo off
setlocal EnableDelayedExpansion 

set currentPath=%~dp0%

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
if ^%input:~0,1% neq ^" (
    set input="%input%"
)

echo %input%

@rem  ��ȡ��׺
set houzui=%~x1%
set houzui=%houzui:.=%
echo "��׺ %houzui%"

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
	echo "������ĸ�ʽ��֧�֣���������˳�" 
	pause>nul
 	goto End
)



@rem ����ѹ��������ƣ� ������ԭ�� +  .mp4(ת����ĸ�ʽ)
set pathFilename=%~dpn1%

set newName="%pathFilename%.jpg"


%currentPath:~0,2% 
cd %currentPath%
echo ..\ffmpeg-win64\bin\ffmpeg -ss 00:00:05 -i %input% -y -f image2 -t 0.001 %newName% 

call ..\ffmpeg-win64\bin\ffmpeg -ss 00:00:05 -i %input% -y -f image2 -t 0.001 %newName% 


:End 
@rem echo "������ ��������˳�"
