@echo off
setlocal EnableDelayedExpansion 


set currentPath=%~dp0%

set width=
set height=
set audioSimpleRate=44100

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
@echo
@rem ���û�����ļ���ֻ��˫���������
if %input% == "" (
	echo "���϶��ļ���bat�ļ���" 
	goto End 
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
@echo "�ǲ�������Ҫ�Ĳ�����ȷ������'y' Ȼ��س��� ���ǰ�����������س�"
set /p isOk=
if "%isOk%" neq "y" (
	goto End
)




@rem  ��ȡ��׺
set houzui="%~x1%"
set newName=


@rem ����ѹ��������ƣ� ������ԭ�� + _ѹ���� .mp4(ԭ���ĺ�׺)
set pathFilename=%~dpn1%
if "%outPutFormat%" neq "" (
	@rem set yasuo="_ѹ����."
	set newName="%pathFilename%_ѹ����.%outPutFormat%"
) else (
	if %houzui% equ ".mp4" (
		set newName=%input:.mp4=_ѹ����.mp4%
	) else (
		if  %houzui% equ ".flv" (
			set newName=%input:.flv=_ѹ����.flv%
		) else (
			if  %houzui% equ ".avi" (
				set newName=%input:.avi=_ѹ����.avi%
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

@rem call ffmpeg.exe -i %input% -ab %audioBitRate%k -b %bitRate%k -r %fps% -s "%width%x%height%" %newName% 

@rem @echo %command%

call %command%

:End 
@rem echo "������ ��������˳�"



