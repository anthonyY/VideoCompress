@echo off
setlocal EnableDelayedExpansion 


set currentPath=%~dp0%

set width=
set height=
set audioSimpleRate=44100
set bitRate=
set audioBitRate=
set audioSimpleRate=
set fps=
set outPutFormat=
::��ȡ�����ļ�

for /f "tokens=1,2 delims==" %%i in (%currentPath%/config.properties) do (
	if "%%i"=="bitRate" set bitRate=%%j
	if "%%i"=="width" set width=%%j
	if "%%i"=="height" set height=%%j
	if "%%i"=="fps" set fps=%%j
	if "%%i"=="audioBitRate" set audioBitRate=%%j
	if "%%i"=="audioSimpleRate" set audioSimpleRate=%%j	
	if "%%i"=="outPutFormat" set outPutFormat=%%j
)


@rem  ��ȡ�Ͻ������ļ���
set input=%1

@echo ################################################################
@echo                     ��Ƶѹ����ת��ű�                   
@echo                         ����   ��ʤ��                         
@echo ################################################################

@rem ���û�����ļ���ֻ��˫���������
if %input% == "" (
	echo "���϶��ļ���bat�ļ���" 
	goto End 
)
@rem ������ļ��е������ţ��е�û�����ţ������ж�һ�£�û�оͼ���
if %input:~0,1% neq ^" (
    set input="%input%"
)

@echo "��Ҫѹ�����ļ��ǣ�%input%"
if "%width%" neq "" (
	@echo "��%width%"
)
if "%height%" neq "" (
	@echo "�ߣ�%height%"
)
if "%bitRate%" neq "" (
	@echo "��Ƶ�����ʣ�%bitRate%kbps"
)
if "%audioBitRate%" neq "" (
	@echo "��Ƶ�����ʣ�%audioBitRate%kbps"
)
if "%fps%" neq "" (
	@echo "֡�ʣ�%fps%"
)
if "%audioSimpleRate%" neq "" (
	@echo "��Ƶ�����ʣ�%audioSimpleRate%"
)

if "%outPutFormat%" neq "" (
	@echo "�����ʽ��%outPutFormat%"
)
@rem @echo "�ǲ�������Ҫ�Ĳ�����ȷ������'y' Ȼ��س��� ���ǰ�����������س�"
@rem set /p isOk=
@rem if "%isOk%" neq "y" (
@rem	goto End
@rem )




@rem  ��ȡ��׺
set houzui="%~x1%"
echo %houzui%

set newName=
set formats=mp4 avi flv mpeg mpg rmvb rm mov mkv wmv 3gp ts mts vob

@rem ����ѹ��������ƣ� ������ԭ�� + _ѹ���� .mp4(ԭ���ĺ�׺)
set pathFilename=%~dpn1%
if "%outPutFormat%" neq "" (
	@rem set yasuo="_ѹ����."
	set newName="%pathFilename%_ѹ����.%outPutFormat%"
) else (
    set isSetOutputName=
    for  %%i in (%formats%) do (
        if "%isSetOutputName%" neq "true" (
            if /i !houzui! equ ".%%i" (
                set newName=!pathFilename!_ѹ����.!outPutFormat!
                set isSetOutputName=true
            ) 
        )
    )
)

set isSetNewName=false
if exist %newName% (
    for /l %%i in (1,1,10) do (
        set tempName="!pathFilename!_ѹ����(%%i).!outPutFormat!"
        if not exist !tempName! (
            if "!isSetNewName!" neq "true" (
                 @rem echo !tempName! ������
                 set newName="!pathFilename!_ѹ����(%%i).!outPutFormat!"
                 set isSetNewName=true
            )
        )		
    )
)

set command=ffmpeg.exe -i %input% 

if "%bitRate%" neq "" (
	set command=%command% -b %bitRate%k
)
if "%audioBitRate%" neq "" (
	set command=%command% -ab %audioBitRate%k
)
if "%fps%" neq "" (
	set command=%command% -r %fps% 
)
if "%audioSimpleRate%" neq "" (
	set command=%command% -ar %audioSimpleRate% 
)
if "%width%" neq "" (
	if "%height%" neq "" (
		set command=%command% -s %width%x%height% 
	)
)
set command=%command% %newName%

@rem echo %command%
@rem pause
@rem call ffmpeg.exe -i %input% -ab %audioBitRate%k -b %bitRate%k -r %fps% -s "%width%x%height%" %newName% 


call %command%

:End 
@rem echo "������ ��������˳�"



