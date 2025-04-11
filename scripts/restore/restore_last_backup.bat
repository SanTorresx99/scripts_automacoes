@echo off
setlocal

:: === CONFIGURAÇÕES GERAIS ===
set REMOTO=\\Caminho\do\servidor\compartilhado\backups
set LOCAL=C:\Caminho\para\database_teste
set USER=SYSDBA
set PASS=masterkey
set GBAK_PATH="C:\Program Files\Firebird\Firebird_3_0\gbak.exe"

:: === ENCONTRA O ARQUIVO .FBK MAIS RECENTE ===
for /f "delims=" %%f in ('dir "%REMOTO%\BANCOFDB_*.fbk" /b /o-d') do (
    set "ULTIMO_BACKUP=%%f"
    goto :ACHOU
)

:ACHOU
echo Último backup encontrado: %ULTIMO_BACKUP%
if not defined ULTIMO_BACKUP (
    echo Nenhum arquivo .fbk encontrado!
    exit /b 1
)

:: === COPIA PARA LOCAL ===
echo Copiando para %LOCAL%\%ULTIMO_BACKUP% ...
copy /Y "%REMOTO%\%ULTIMO_BACKUP%" "%LOCAL%\%ULTIMO_BACKUP%"

:: === REMOVE BASE ANTIGA (se não estiver em uso) ===
if exist "%LOCAL%\BANCOFDB.FDB" (
    echo Apagando base antiga...
    del /f /q "%LOCAL%\BANCOFDB.FDB"
)

:: === RESTAURA BACKUP PARA NOVO .FDB ===
echo Restaurando para %LOCAL%\BANCOFDB.FDB ...
start /wait "" %GBAK_PATH% -c -v -user %USER% -pass %PASS% "%LOCAL%\%ULTIMO_BACKUP%" "%LOCAL%\BANCOFDB.FDB"

if %ERRORLEVEL% EQU 0 (
    echo Restauração concluída com sucesso!
) else (
    echo ERRO na restauração!
)

endlocal
pause
