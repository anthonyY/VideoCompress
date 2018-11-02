@echo off
setlocal EnableDelayedExpansion 


set currentPath=%~dp0%



::��ȡ�����ļ�

for /f "tokens=1,2 delims==" %%i in (%currentPath%/config.properties) do (
	if "%%i"=="bitRate" set bitRate=%%jk
	if "%%i"=="width" set width=%%j
	if "%%i"=="height" set height=%%j
	if "%%i"=="fps" set fps=%%j
	if "%%i"=="audioBitRate" set audioBitRate=%%jk
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
@echo "��%width%"
@echo "�ߣ�%height%"
@echo "��Ƶ�����ʣ�%bitRate%bps"
@echo "֡�ʣ�%fps%"
@echo "��Ƶ�����ʣ�%audioBitRate%bps"
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



call ffmpeg.exe -i %input% -ab %audioBitRate% -b %bitRate% -r %fps% -s "%width%x%height%" %newName% 



:End 
@rem echo "������ ��������˳�"



