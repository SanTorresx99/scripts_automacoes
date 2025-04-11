@echo off
:: === CONFIGURAÇÕES DO BACKUP ===
set DB_PATH=C:\Caminho\para\BANCOFDB.FDB
set BACKUP_DIR=C:\Caminho\para\backups
set USER=SYSDBA
set PASS=masterkey
set GBAK_PATH="C:\Program Files\Firebird\Firebird_3_0\gbak.exe"

:: === DATA E HORA ===
for /f %%i in ('wmic os get LocalDateTime ^| find "."') do set datetime=%%i
set DATESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%
set BACKUP_FILE=%BACKUP_DIR%\BANCOFDB_%DATESTAMP%.fbk

:: === CRIA DIRETÓRIO DE BACKUP CASO NÃO EXISTA ===
if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
)

:: === EXECUTA BACKUP COM -g (banco em uso) ===
echo Iniciando backup em %DATESTAMP%...
%GBAK_PATH% -b -g -user %USER% -pass %PASS% "%DB_PATH%" "%BACKUP_FILE%"

if %ERRORLEVEL% EQU 0 (
    echo Backup finalizado com sucesso: %BACKUP_FILE%
    echo [%DATESTAMP%] Sucesso: %BACKUP_FILE% >> "%BACKUP_DIR%\backup_log.txt"
) else (
    echo ERRO no backup!
    echo [%DATESTAMP%] ERRO no backup! >> "%BACKUP_DIR%\backup_log.txt"
)

:: === LIMPA BACKUPS ANTIGOS (7+ dias) ===
forfiles /p "%BACKUP_DIR%" /m *.fbk /d -7 /c "cmd /c del @path"

exit /b
