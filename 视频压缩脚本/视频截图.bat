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
set houzui=%~x1%
set houzui=%houzui:.=%
echo "��׺ %houzui%"
if /i  "%houzui%" neq "mp4" (
if /i "%houzui%" neq "avi" (
if /i "%houzui%" neq "flv" (
if /i "%houzui%" neq "rmvb" (
if /i "%houzui%" neq "rm" (
if /i "%houzui%" neq "mov" (
if /i "%houzui%" neq "mkv" (
if /i "%houzui%" neq "wmv" (
if /i "%houzui%" neq "mpeg" (
if /i "%houzui%" neq "3gp" (
if /i "%houzui%" neq "ts" (
if /i "%houzui%" neq "mts" (
if /i "%houzui%" neq "vob" (
	echo "��������ļ���ʽ��֧�֣���������˳�" 
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

set newName="%pathFilename%.jpg"



echo ffmpeg -ss 00:00:05 -i %input% -y -f image2 -t 0.001 %newName% 

call ffmpeg -ss 00:00:05 -i %input% -y -f image2 -t 0.001 %newName% 


:End 
@rem echo "������ ��������˳�"
