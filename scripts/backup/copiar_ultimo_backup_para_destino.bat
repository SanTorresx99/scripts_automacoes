@echo off
setlocal

:: === CONFIGURAÇÕES GENÉRICAS ===
:: Caminho de origem onde os arquivos .fbk estão (pode ser um compartilhamento de rede)
set ORIGEM=\\CAMINHO\COMPARTILHADO\BACKUPS

:: Caminho de destino onde os arquivos .fbk serão salvos
set DESTINO=C:\CAMINHO\DESTINO\BACKUPS

:: Nome base do banco de dados (sem extensão). Ex: "BANCO_A", "BANCO_B"
set DB1=BANCO1
set DB2=BANCO2

:: === GARANTIR QUE O DESTINO EXISTE ===
if not exist "%DESTINO%" (
    echo Criando diretório de destino...
    mkdir "%DESTINO%"
)

:: === REMOVE OS .FBK EXISTENTES NO DESTINO ===
echo Limpando arquivos .fbk anteriores do destino...
del /f /q "%DESTINO%\*.fbk"

:: === COPIA O ÚLTIMO BACKUP DO DB1 ===
for /f "delims=" %%f in ('dir "%ORIGEM%\%DB1%_*.fbk" /b /o-d') do (
    set "BACKUP_DB1=%%f"
    goto :COPIA_DB1
)
:COPIA_DB1
if defined BACKUP_DB1 (
    echo Copiando %DB1%: %BACKUP_DB1%
    copy /Y "%ORIGEM%\%BACKUP_DB1%" "%DESTINO%\%BACKUP_DB1%"
) else (
    echo Nenhum backup de %DB1% encontrado!
)

:: === COPIA O ÚLTIMO BACKUP DO DB2 ===
for /f "delims=" %%f in ('dir "%ORIGEM%\%DB2%_*.fbk" /b /o-d') do (
    set "BACKUP_DB2=%%f"
    goto :COPIA_DB2
)
:COPIA_DB2
if defined BACKUP_DB2 (
    echo Copiando %DB2%: %BACKUP_DB2%
    copy /Y "%ORIGEM%\%BACKUP_DB2%" "%DESTINO%\%BACKUP_DB2%"
) else (
    echo Nenhum backup de %DB2% encontrado!
)

echo Cópia finalizada.
endlocal
pause
