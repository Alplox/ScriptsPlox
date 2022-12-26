@echo off
chcp 65001

REM Script Name   : ScriptsPlox.bat
REM Author        : Alplox
REM Created       : 05-12-2022
REM Version       : v0.03
REM Repository    : https://github.com/Alplox/ScriptsPlox
REM Description   : Batch que contiene utilidades para resolución de problemas comunes en equipos que veo en mi trabajo.

REM  --> Revisa permisos
        REM La instrucción de comando cacls.exe es una herramienta de línea de comandos que se utiliza para mostrar 
        REM y modificar los permisos de ACL de un archivo o carpeta. En este caso, el comando cacls.exe se está ejecutando 
        REM con el archivo %SYSTEMROOT%\system32\config\system como parámetro. La variable de entorno %SYSTEMROOT% se expande 
        REM a la ruta de la carpeta raíz del sistema operativo, que es normalmente C:\Windows.

        REM La redirección de salida >nul redirige la salida del comando a nul, que es una ubicación especial que descarta cualquier salida. 
        REM La redirección de error 2>&1 redirige el error de salida del comando a la salida estándar. Esto significa que cualquier 
        REM error que genere el comando se imprimirá en la pantalla junto con la salida del comando.

        REM En resumen, este código ejecuta el comando cacls.exe para mostrar los permisos de ACL del archivo 
        REM %SYSTEMROOT%\system32\config\system. Cualquier salida o error del comando se descarta.

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> Si error, no tenes permisos admin.
    REM La sentencia if comprueba si la variable de entorno errorlevel es diferente de cero. La variable de entorno errorlevel 
    REM se establece automáticamente por el sistema operativo después de ejecutar un comando. Si el comando se ejecuta correctamente,
    REM errorlevel se establece en cero. Si el comando se ejecuta con un error, errorlevel se establece en un valor diferente de cero.

    REM Si errorlevel es diferente de cero, significa que el script necesita permisos de administrador para ejecutarse. En este caso,
    REM se imprime el mensaje "Solicitando permisos de administrador..." y se salta a la etiqueta UACPrompt.

    REM Si errorlevel es igual a cero, significa que el script ya tiene permisos de administrador. En este caso, se salta a la etiqueta gotAdmin.

    REM La etiqueta UACPrompt y la etiqueta gotAdmin son dos etiquetas que deben definirse en algún lugar del script. La etiqueta UACPrompt 
    REM se utiliza para solicitar permisos de administrador al usuario, mientras que la etiqueta gotAdmin se utiliza para ejecutar el código que requiere permisos de administrador.
if '%errorlevel%' NEQ '0' (
    echo Solicitando permisos de administrador...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
        REM La primera instrucción es echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs", 
        REM que crea un archivo VBScript temporal en la carpeta %temp% (que es la carpeta temporal del sistema) con el nombre getadmin.vbs.
        REM El archivo VBScript contiene una única línea de código que crea un objeto Shell.Application, que se asigna a la variable UAC.

        REM La segunda instrucción es set params = %*:"=", que asigna a la variable params los parámetros del script actual. Los parámetros
        REM son los valores que se pasan al script cuando se ejecuta. La opción : indica que se deben eliminar cualquier espacio en blanco al
        REM principio o al final de cada parámetro. La opción "=" indica que se deben eliminar cualquier espacio en blanco al principio o al
        REM final de cada parámetro y que se deben eliminar cualquier doble comilla alrededor de los parámetros.

        REM La tercera instrucción es echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs", 
        REM que añade otra línea al archivo VBScript temporal. Esta línea utiliza el método ShellExecute del objeto Shell.Application 
        REM para ejecutar el comando cmd.exe con los parámetros /c %~s0 %params%. El parámetro /c indica que se debe ejecutar el comando siguiente y luego salir.
        REM El parámetro %~s0 se expande a la ruta completa del archivo batch actual. El parámetro %params% se expande a los parámetros del script actual.
        REM La opción runas indica que se debe ejecutar el comando con permisos de administrador.

        REM La cuarta instrucción es "%temp%\getadmin.vbs", que ejecuta el archivo VBScript temporal. Esto ejecuta el comando cmd.exe con permisos de
        REM administrador y le pasa la ruta completa del archivo batch actual y los parámetros del script actual.

        REM La quinta instrucción es del "%temp%\getadmin.vbs", que elimina el archivo VBScript temporal.

        REM La última instrucción es exit /B, que finaliza la ejecución del script actual.

        REM En resumen, este código batch crea un archivo VBScript temporal que ejecuta el script actual con permisos de administrador y luego elimina el archivo.
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
        REM La primera instrucción es pushd "%CD%", empuja la ruta actual del directorio (es decir, el directorio actual de trabajo) a una pila.
        REM Esto significa que la ruta del directorio actual se guarda temporalmente para que se pueda volver a ella más tarde.

        REM La segunda instrucción es CD /D "%~dp0", cambia el directorio actual de trabajo al directorio donde se encuentra el archivo batch.
        REM La opción /D indica que se debe cambiar también la unidad de disco, si es necesario. La variable %~dp0 se expande a la ruta completa del directorio del archivo batch, incluyendo la unidad de disco.

        REM En resumen, este código batch cambia el directorio actual de trabajo al directorio donde se encuentra el archivo batch y guarda la ruta 
        REM del directorio anterior en una pila para poder volver a él más tarde. Esto es útil si el script necesita cambiar temporalmente al directorio
        REM donde se encuentra el archivo batch para realizar alguna tarea y luego volver al directorio anterior.
    pushd "%CD%"
    CD /D "%~dp0"









REM ███    ███ ███████ ███    ██ ██    ██     ██ ███    ██ ██  ██████ ██  ██████  
REM ████  ████ ██      ████   ██ ██    ██     ██ ████   ██ ██ ██      ██ ██    ██ 
REM ██ ████ ██ █████   ██ ██  ██ ██    ██     ██ ██ ██  ██ ██ ██      ██ ██    ██ 
REM ██  ██  ██ ██      ██  ██ ██ ██    ██     ██ ██  ██ ██ ██ ██      ██ ██    ██ 
REM ██      ██ ███████ ██   ████  ██████      ██ ██   ████ ██  ██████ ██  ██████  

:menu-inicio
cls
mode con: cols=90 lines=45
:::                          ┌───────┐   ╔════════════════════╗
:::                          │ ════ o│   ║                    ║
:::                          ├───────┤   ║    Escrito por     ║
:::       ╔══════════════╗   │[■■■■]o│   ║       Alplox       ║
:::       ║              ║   ├───────┤   ║                    ║
:::       ║   Scripts y  ║   │       │   ╚════════╤══╤══════o═╝
:::       ║ Herramientas ║   │ v0.03 │─────┘  ____│__│____
:::       ║              ║   │       │─┐     /____________\
:::       ╚══════════════╝   └───────┘ │   ________________
:::      /::::::::::::::::\            └──/::::::::::::::::\   /T\
:::     /:::::════════:::::\             /:::::════════:::::\  \_/
:::     ════════════════════             ════════════════════
for /f "delims=: tokens=*" %%x in ('findstr /b ::: "%~f0"') do @echo(%%x
echo.
echo       ___________________________________________________________
echo.
echo             Bienvenido al menú de scripts:
echo.
echo             [1] Ver datos PC (dominio, hostname, serial, mac)
echo             [2] Optimización-Reparación-Análisis disco duro
echo             [3] Reparar perfil temporal
echo             [4] Soluciones problemas directivas dominio
echo             [5] Limpiar cola impresion-Spooler
echo             [6] Buscar drivers desde sitios oficiales
echo             [ ] 
echo             [8] Ver teles
echo             [ ] ?
echo             [0] Reiniciar en inicio avanzado
echo          __________________________________________________
echo.
echo             [A] Abrir administrador de tareas (taskmgr.exe)
echo             [D] Abrir administrador de dispositivos (devmgmt.msc)
echo             [T] Abrir teclado en pantalla (osk.exe)
echo.
echo             [R] Ir a repositorio GitHub (https://github.com/Alplox/ScriptsPlox)
echo          __________________________________________________
echo.
echo             [S] Salir
echo       ___________________________________________________________
echo.   
title ScriptsPlox
set /p opcion=Ingrese el número de la opción deseada:
if %opcion%==1 goto menu-inicio-opcion-1
if %opcion%==2 goto menu-inicio-opcion-2
if %opcion%==3 goto menu-inicio-opcion-3
if %opcion%==4 goto menu-inicio-opcion-4
if %opcion%==5 goto menu-inicio-opcion-5
if %opcion%==6 goto menu-inicio-opcion-6

if %opcion%==8 goto menu-inicio-opcion-8
if %opcion%==9 goto menu-inicio-opcion-9
if %opcion%==0 goto menu-inicio-opcion-0
if /i "%opcion%"=="A" goto abrir-administrador-de-tareas
if /i "%opcion%"=="D" goto abrir-administrador-de-dispositivos
if /i "%opcion%"=="T" goto abrir-teclado-en-pantalla
if /i "%opcion%"=="R" goto abrir-repositorio-github
if /i "%opcion%"=="S" goto fin
echo Opción inválida, intenta de nuevo.
goto menu-inicio

:volver-a-menu-inicio
echo. 
echo -------------- VOLVER A MENU INICIO -------------- 
echo. 
echo ¿Volver a Menu Inicio? 
set /p answer=Escribe S para sí o N para cerrar ventana:
if /i "%answer%"=="S" goto menu-inicio
goto fin





REM  ██████  ██████   ██████ ██  ██████  ███    ██      ██ 
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ███ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██      ██ 
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██      ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████      ██ 

:menu-inicio-opcion-1
cls
mode con: cols=190 lines=45
REM Mostramos la información del equipo en la consola https://stackoverflow.com/a/29026783
echo --------------Información del equipo -------------- 
echo Nombre del equipo: %computername%
echo Nombre de usuario: %username%
bcdedit /enum
echo.
echo -------------- getmac /v -------------- 
getmac /v 
echo. 
echo -------------- set L -------------- 
echo. 
set L
sysdm.cpl 
echo. 
echo -------------- whoami -------------- 
echo. 
whoami 
echo. 
echo -------------- wmic csproduct -------------- 
echo. 
wmic csproduct 
goto volver-a-menu-inicio





REM  ██████  ██████   ██████ ██  ██████  ███    ██     ██████  
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██          ██ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██      █████  
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██     ██      
REM  ██████  ██       ██████ ██  ██████  ██   ████     ███████ 

:menu-inicio-opcion-2
cls
mode con: cols=120 lines=25
echo       ___________________________________________________________
echo.
echo             Bienvenido al submenú de Optimización/Reparación/Analisis disco duro:
echo.
echo             ////////// Reparar \\\\\\\\\\
echo             [1] sfc /scannow [Reparar - Archivos OS]
echo             [2] dism.exe /online /cleanup-image /restorehealth [Reparar - Componentes OS]
echo             [3] chkdsk /f: [Reparar - Errores Disco Duro]
echo.
echo             ////////// Optimizar \\\\\\\\\\
echo             [4] defrag C: /V /A [Optimizar - Fragmentación Disco Duro]
echo             [5] cleanmgr.exe [Optimizar - Liberar espacio Disco Duro]
echo             [6] Mover archivos temporales [Optimizar - Liberar espacio Disco Duro]
echo.
echo             ////////// Ver datos \\\\\\\\\\
echo             [7] wmic diskdrive get status [Ver Salud Disco Duro]
echo          __________________________________________________
echo.
echo             [S] Regresar a menú inicio
echo       ___________________________________________________________
echo.   
set /p opcion=Ingrese el número de la opción deseada:
if %opcion%==1 goto menu-inicio-opcion-2-submenu-opcion-1
if %opcion%==2 goto menu-inicio-opcion-2-submenu-opcion-2
if %opcion%==3 goto menu-inicio-opcion-2-submenu-opcion-3
if %opcion%==4 goto menu-inicio-opcion-2-submenu-opcion-4
if %opcion%==5 goto menu-inicio-opcion-2-submenu-opcion-5
if %opcion%==6 goto menu-inicio-opcion-2-submenu-opcion-6
if %opcion%==7 goto menu-inicio-opcion-2-submenu-opcion-7
if /i "%opcion%"=="S" goto menu-inicio
echo Opción inválida, intenta de nuevo.
goto menu-inicio-opcion-2

:volver-a-menu-inicio-opcion-2-submenu
echo. 
echo -------------- VOLVER A MENU INICIO -------------- 
echo. 
echo ¿Volver a Menu Inicio? 
set /p answer=Escribe S para sí o N para regresar a submenu Optimización/Reparación/Analisis disco duro:
if /i "%answer%"=="S" goto menu-inicio
goto menu-inicio-opcion-2

:menu-inicio-opcion-2-submenu-opcion-1
REM OPCION 1
cls
    REM El comando sfc /scannow se puede usar para verificar la integridad de 
    REM los archivos del OS y reparar cualquier problema que se encuentre.
    REM SFC verifica todos los archivos del OS y comparará sus versiones con una copia de referencia almacenada en una base de datos de archivos de sistema.
    REM Si encuentra algún archivo dañado o corrupto, intentará repararlo utilizando una copia de repuesto del archivo en cuestión.
    REM El comando sfc /scannow es útil cuando se experimentan problemas de estabilidad o rendimiento en el OS, 
    REM ya que puede ayudar a reparar cualquier problema de integridad de los archivos del OS. 
echo -------------- sfc -------------- 
echo. 
echo ¿Comenzar SFC ahora?
echo. 
set /p answer=Escribe S para sí o N para no:
if /i "%answer%"=="S" sfc /scannow
goto volver-a-menu-inicio-opcion-2-submenu

:menu-inicio-opcion-2-submenu-opcion-2
REM OPCION 2
cls
    REM Este comando ejecuta DISM (Deployment Image Servicing and Management) y utiliza las opciones
    REM /online indica que la imagen a la que se aplicarán los cambios es la imagen del sistema operativo que se está ejecutando actualmente.
    REM /cleanup-image para eliminar archivos no utilizados .
    REM /restorehealth para reparar cualquier componente dañado de la imagen del sistema operativo.
    REM Esto puede ayudar a reparar cualquier problema de integridad de la imagen de Windows que no haya sido detectado por el SFC.
echo -------------- dism -------------- 
echo. 
echo ¿Comenzar DISM ahora?
echo. 
set /p answer=Escribe S para sí o N para no:
if /i "%answer%"=="S" dism.exe /online /cleanup-image /restorehealth
goto volver-a-menu-inicio-opcion-2-submenu

:menu-inicio-opcion-2-submenu-opcion-3
REM OPCION 3
cls
    REM Este comando ejecuta la herramienta CHKDSK (Check Disk) y utiliza la opción f para buscar y reparar errores en el disco duro.
    REM Esto puede ayudar a reparar problemas de integridad de los archivos del sistema operativo causados por errores en el disco duro.
echo -------------- chkdsk --------------
echo.
echo ¿Reparar errores disco con chkdsk ahora?
echo.
set /p answer=Escribe S para sí o N para no:
if /i "%answer%"=="S" chkdsk /f:
goto volver-a-menu-inicio-opcion-2-submenu

:menu-inicio-opcion-2-submenu-opcion-4
REM OPCION 4
cls
echo -------------- defrag -------------- 
echo. 
echo ¿Desfragmentar disco ahora?
echo. 
set /p answer=Escribe S para sí o N para no:
	if /i ("%answer%"=="S") (
		cls
		echo. 
		echo Iniciando la desfragmentación del disco C...
		defrag C: /V /A
		echo. 
		echo Desfragmentación del disco C completa.
	)
goto volver-a-menu-inicio-opcion-2-submenu

:menu-inicio-opcion-2-submenu-opcion-5
REM OPCION 5
cls
start cleanmgr.exe
cls
goto menu-inicio-opcion-2

:menu-inicio-opcion-2-submenu-opcion-6
REM OPCION 6
cls
echo -------------- Mover archivos temporales -------------- 
echo.
echo ¿Quieres mover los archivos temporales ahora? (seran movidos a nueva carpeta en el escritorio, NO borrados)
echo %USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp\
echo C:\Windows\Temp\
echo C:\Windows\Prefetch\
echo.
set /p answer=Escribe S para sí o N para regresar a submenu Optimización/Reparación/Analisis disco duro:
if /i ("%answer%"=="S") (
	REM Create a new folder on the desktop named "Temporales - DD-MM-YYYY"
	REM where "DD-MM-YYYY" is the current date
	set FOLDERNAME=Temporales - %date:~0,2%-%date:~3,2%-%date:~6,4%
	md "%USERPROFILE%\Desktop\%FOLDERNAME%"

	REM Move all the files from the "%Temp%" folder to the new folder
	set COUNT=0
	set ERRORCOUNT=0
	set TOTALSIZE=0
	md "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp"
	for /f "tokens=*" %%f in ('dir "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp\*" /b /a-d') do (
	  set /a COUNT+=1
	  echo Moving file %COUNT% of %TOTAL%: %USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp\%%f
	  move "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp\%%f" "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp"
	  if %errorlevel% neq 0 (
		set /a ERRORCOUNT+=1
	  )
	  echo "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp\%%f" >> "%USERPROFILE%\Desktop\%FOLDERNAME%\moved_files.log"
	)

	REM Move all the files from the "C:\Windows\Temp" folder to the new folder
	md "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp(C)"
	for /f "tokens=*" %%f in ('dir "C:\Windows\Temp\*" /b /a-d') do (
	  set /a COUNT+=1
	  echo Moving file %COUNT% of %TOTAL%: C:\Windows\Temp\%%f
	  move "C:\Windows\Temp\%%f" "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Temp(C)"
	  if %errorlevel% neq 0 (
		set /a ERRORCOUNT+=1
	  )
	  echo "C:\Windows\Temp\%%f" >> "%USERPROFILE%\Desktop\%FOLDERNAME%\moved_files.log"
	)

	REM Move all the files from the "C:\Windows\Prefetch" folder to the new folder
	md "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Prefetch"
	for /f "tokens=*" %%f in ('dir "C:\Windows\Prefetch\*" /b /a-d') do (
	  set /a COUNT+=1
	  echo Moving file %COUNT% of %TOTAL%: C:\Windows\Prefetch\%%f
	  move "C:\Windows\Prefetch\%%f" "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Prefetch"
	  if %errorlevel% neq 0 (
		set /a ERRORCOUNT+=1
	  )
	  echo "C:\Windows\Prefetch\%%f" >> "%USERPROFILE%\Desktop\%FOLDERNAME%\moved_files.log"
	)

	REM Calculate the total size of the files moved in MB
	for /f "tokens=3" %%f in ('dir "%USERPROFILE%\Desktop\%FOLDERNAME%\Windows\Prefetch\*" /s /a-d ^| find /c "bytes"') do set /a TOTALSIZE+=%%f
	set /a TOTALSIZE/=1048576

	REM Display a summary of the results
	echo Total files moved: %COUNT%
	echo Total files not moved: %ERRORCOUNT%
	echo Total size of files moved: %TOTALSIZE% MB
	echo Done!
	pause
	goto volver-a-menu-inicio-opcion-2-submenu
) else (
	cls
	goto menu-inicio-opcion-2
)

:menu-inicio-opcion-2-submenu-opcion-7
REM OPCION 7
cls
echo -------------- wmic diskdrive get status y fsutil dirty query c: -------------- 
echo. 
echo El estado del disco duro es el siguiente: 
echo.
wmic diskdrive get status && fsutil dirty query C:
goto volver-a-menu-inicio-opcion-2-submenu





REM  ██████  ██████   ██████ ██  ██████  ███    ██     ██████  
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██          ██ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██      █████  
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██          ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████     ██████  

:menu-inicio-opcion-3
cls
mode con: cols=120 lines=25
echo       ___________________________________________________________
echo.
echo             Bienvenido al submenú de Reparar perfil temporal:
echo.
echo             [1] abrir todo C:\Usuarios y regedit ProfileList [Renombrar usuario existente]
echo             [2] abrir C:\Usuarios [Renombrar usuario existente]
echo             [3] abrir regedit ProfileList [Renombrar usuario existente]
echo             [4] Ver guía
echo          __________________________________________________
echo.
echo             [S] Regresar a menú inicio
echo       ___________________________________________________________
echo.   
set /p opcion=Ingrese el número de la opción deseada:
if %opcion%==1 goto menu-inicio-opcion-3-submenu-opcion-1
if %opcion%==2 goto menu-inicio-opcion-3-submenu-opcion-2
if %opcion%==3 goto menu-inicio-opcion-3-submenu-opcion-3
if %opcion%==4 goto menu-inicio-opcion-3-submenu-opcion-4
if /i "%opcion%"=="S" goto menu-inicio
echo Opción inválida, intenta de nuevo.
goto menu-inicio-opcion-3

:menu-inicio-opcion-3-submenu-opcion-1
REM abrir carpeta usuarios
if exist "C:\Usuarios\" (
  explorer "C:\Usuarios\"
) else (
  explorer "C:\Users\"
)
REM lanzar regedit en profilist
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /f 
start "" regedit
cls
goto menu-inicio-opcion-3

:menu-inicio-opcion-3-submenu-opcion-2
if exist "C:\Usuarios\" (
  explorer "C:\Usuarios\"
) else (
  explorer "C:\Users\"
)
cls
goto menu-inicio-opcion-3

:menu-inicio-opcion-3-submenu-opcion-3
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /f 
start "" regedit
cls
goto menu-inicio-opcion-3

:menu-inicio-opcion-3-submenu-opcion-4
cls
mode con: cols=160 lines=25
echo -------------- Guía respaldar/recuperar perfil -------------- 
echo 1- ir carpeta usuarios (C:\Usuarios\), buscar usuario con problemas y renombrar para que se deje de usar (ejem: Respaldo (DD-MM-AA) usuario)
echo 2- ir regedit profileList y renombrar en mismo formato (HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList) carpeta que incluya .BAK al final.
echo 3- volver a ingresar como aquel usuario.
echo 4- recuperar archivos desde carpeta usuario renombrada (archivos y marcadores google desde Appdata-Local-Google)
echo. 
echo -------------- VOLVER A MENU INICIO -------------- 
echo. 
echo ¿Volver a Menu Inicio? 
set /p answer=Escribe S para sí o N para regresar a submenu reparar perfil temporal:
if /i "%answer%"=="S" goto menu-inicio
goto menu-inicio-opcion-3





REM  ██████  ██████   ██████ ██  ██████  ███    ██     ██   ██ 
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ██   ██ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██     ███████ 
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██          ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████          ██ 

:menu-inicio-opcion-4
cls
echo -------------- Dominio troubleshooting -------------- 
echo.
set domain=%userdnsdomain%
if "%domain%" == "" (
  echo El equipo no está conectado a un dominio.
) else (
  echo El equipo está conectado al dominio %domain%.
)
echo. 
echo -------------- gpupdate /force -------------- 
echo. 
echo ¿Ejecutar gpupdate force?
set /p answer=Escribe S para sí o N para no:
if /i "%answer%"=="S" gpupdate /force
goto volver-a-menu-inicio





REM  ██████  ██████   ██████ ██  ██████  ███    ██     ███████ 
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ██      
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██     ███████ 
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██          ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████     ███████ 

:menu-inicio-opcion-5
cls
REM /Q: Elimina los archivos de forma silenciosa sin pedir confirmación.
REM /F: Fuerza la eliminación de los archivos, incluso si están en uso.
REM /S: Elimina los archivos de todas las subcarpetas bajo la carpeta especificada.
echo. 
echo -------------- Limpiar cola impresion/Spooler -------------- 
echo. 
echo ¿Reiniciar cola impresion/spooler ahora?
set /p answer=Escribe S para sí o N para no:
if /i "%answer%"=="S" net stop spooler && del %systemroot%\System32\spool\printers\* /Q /F /S && net start spooler
goto volver-a-menu-inicio





REM  ██████  ██████   ██████ ██  ██████  ███    ██      ██████  
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ██       
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██     ███████  
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██     ██    ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████      ██████  

:menu-inicio-opcion-6
cls
echo       ___________________________________________________________
echo.
echo             Bienvenido al submenú de Buscar drivers desde sitios oficiales:
echo.
echo             [1] Ir sitio Lenovo
echo             [2] Ir sitio HP
echo             [3] Ir sitio DELL
echo             [4] Ir sitio INTEL
echo             [5] Ir sitio AMD
echo             [6] Ir sitio NVIDIA
echo             [7] Ir sitio Snappy driver
echo          __________________________________________________
echo.
echo             [S] Regresar a menú inicio
echo       ___________________________________________________________
echo.   
set /p opcion=Ingrese el número de la opción deseada:
if %opcion%==1 goto menu-inicio-opcion-6-submenu-opcion-1
if %opcion%==2 goto menu-inicio-opcion-6-submenu-opcion-2
if %opcion%==3 goto menu-inicio-opcion-6-submenu-opcion-3
if %opcion%==4 goto menu-inicio-opcion-6-submenu-opcion-4
if %opcion%==5 goto menu-inicio-opcion-6-submenu-opcion-5
if %opcion%==6 goto menu-inicio-opcion-6-submenu-opcion-6
if %opcion%==7 goto menu-inicio-opcion-6-submenu-opcion-7
if /i "%opcion%"=="S" goto menu-inicio
echo Opción inválida, intenta de nuevo.
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-1
REM LENOVO
explorer "https://pcsupport.lenovo.com/cl/es"
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-2
REM HP
explorer "https://support.hp.com/cl-es/drivers"
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-3
REM DELL
explorer "https://www.dell.com/support/home/es-cl?app=drivers"
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-4
REM INTEL
explorer "https://www.intel.la/content/www/xl/es/download-center/home.html"
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-5
REM AMD
explorer "https://www.amd.com/es/support"
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-6
REM NVIDIA
explorer "https://www.nvidia.es/Download/index.aspx?lang=es"
goto menu-inicio-opcion-6

:menu-inicio-opcion-6-submenu-opcion-7
REM Snapy driver
explorer "https://www.snappy-driver-installer.org/"
goto menu-inicio-opcion-6





REM  ██████  ██████   ██████ ██  ██████  ███    ██     ███████ 
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██          ██ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██         ██  
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██        ██   
REM  ██████  ██       ██████ ██  ██████  ██   ████        ██   
                                                           
REM aún nada                                                     





REM  ██████  ██████   ██████ ██  ██████  ███    ██      █████  
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ██   ██ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██      █████  
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██     ██   ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████      █████  

:menu-inicio-opcion-8
REM teles temporalmente mientras encuentro algo mejor que asignar
explorer "https://alplox.github.io/teles/"
goto menu-inicio





REM  ██████  ██████   ██████ ██  ██████  ███    ██      █████  
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ██   ██ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██      ██████ 
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██          ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████      █████  

:menu-inicio-opcion-9
REM ??? temporal mientras encuentro algo mejor que asignar
cls
title Descuida son solo números aleatorios, puedes revisar el código :)
mode con: cols=190 lines=45
color 02
set contador=0
:bucle
echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
timeout /t 0
set /a contador=%contador%+1
if %contador% LSS 40 goto bucle
echo.
echo.
echo.
echo.
echo.
echo “Ya sé Kung fú.”
echo.
set /p answer=Escribe S:
if /i "%answer%"=="S" (
  color 0F
  goto menu-inicio
) else (
  goto rabbit
)

:rabbit
cls
mode con: cols=220 lines=45
color C0
echo.
echo.
echo ████████ ██   ██ ███████     ███    ███  █████  ████████ ██████  ██ ██   ██     ██   ██  █████  ███████     ██    ██  ██████  ██    ██                                                                             
echo    ██    ██   ██ ██          ████  ████ ██   ██    ██    ██   ██ ██  ██ ██      ██   ██ ██   ██ ██           ██  ██  ██    ██ ██    ██                                                                             
echo    ██    ███████ █████       ██ ████ ██ ███████    ██    ██████  ██   ███       ███████ ███████ ███████       ████   ██    ██ ██    ██                                                                             
echo    ██    ██   ██ ██          ██  ██  ██ ██   ██    ██    ██   ██ ██  ██ ██      ██   ██ ██   ██      ██        ██    ██    ██ ██    ██                                                                             
echo    ██    ██   ██ ███████     ██      ██ ██   ██    ██    ██   ██ ██ ██   ██     ██   ██ ██   ██ ███████        ██     ██████   ██████  ██ ██ ██                                                                    
echo.
echo.                                                                                                                                                                                                                  
echo  ███████  ██████  ██      ██       ██████  ██     ██     ████████ ██   ██ ███████     ██     ██ ██   ██ ██ ████████ ███████     ██████   █████  ██████  ██████  ██ ████████    
echo  ██      ██    ██ ██      ██      ██    ██ ██     ██        ██    ██   ██ ██          ██     ██ ██   ██ ██    ██    ██          ██   ██ ██   ██ ██   ██ ██   ██ ██    ██       
echo  █████   ██    ██ ██      ██      ██    ██ ██  █  ██        ██    ███████ █████       ██  █  ██ ███████ ██    ██    █████       ██████  ███████ ██████  ██████  ██    ██       
echo  ██      ██    ██ ██      ██      ██    ██ ██ ███ ██        ██    ██   ██ ██          ██ ███ ██ ██   ██ ██    ██    ██          ██   ██ ██   ██ ██   ██ ██   ██ ██    ██       
echo  ██       ██████  ███████ ███████  ██████   ███ ███         ██    ██   ██ ███████      ███ ███  ██   ██ ██    ██    ███████     ██   ██ ██   ██ ██████  ██████  ██    ██    ██ 
echo.                                                                                                                                                                                                             
echo.
timeout /t 5
color 0F
goto menu-inicio    





REM  ██████  ██████   ██████ ██  ██████  ███    ██      ██████  
REM ██    ██ ██   ██ ██      ██ ██    ██ ████   ██     ██  ████ 
REM ██    ██ ██████  ██      ██ ██    ██ ██ ██  ██     ██ ██ ██ 
REM ██    ██ ██      ██      ██ ██    ██ ██  ██ ██     ████  ██ 
REM  ██████  ██       ██████ ██  ██████  ██   ████      ██████  

:menu-inicio-opcion-0
cls
echo       ___________________________________________________________
echo.
echo             Bienvenido al submenú de Reinicio-Apagado:
echo.
echo             [1] Reiniciar el PC
echo             [2] Apagar el PC
echo             [3] Reiniciar en modo avanzado
echo             [4] Reiniciar en BIOS
echo          __________________________________________________
echo.
echo             [S] Regresar a menú inicio
echo       ___________________________________________________________
echo.   
set /p opcion=Selecciona una opción:
if "%opcion%"=="1" goto menu-inicio-opcion-0-submenu-opcion-1
if "%opcion%"=="2" goto menu-inicio-opcion-0-submenu-opcion-2
if "%opcion%"=="3" goto menu-inicio-opcion-0-submenu-opcion-3
if "%opcion%"=="4" goto menu-inicio-opcion-0-submenu-opcion-4
if /i "%opcion%"=="S" goto menu-inicio


:menu-inicio-opcion-0-submenu-opcion-1
echo.
echo Reiniciando el PC...
shutdown /r /t 10
goto script-Reinicio-avanzado

:smenu-inicio-opcion-0-submenu-opcion-2
echo.
echo Apagando el PC...
shutdown /s /t 10
goto script-Reinicio-avanzado

:menu-inicio-opcion-0-submenu-opcion-3
echo.
echo Reiniciando en modo avanzado...
shutdown /r /o /t 10
goto script-Reinicio-avanzado

:menu-inicio-opcion-0-submenu-opcion-4
echo.
echo Reiniciando en BIOS...
shutdown /r /o /m \\%computername% /t 10
goto script-Reinicio-avanzado





:abrir-administrador-de-dispositivos
start devmgmt.msc
goto menu-inicio





:abrir-administrador-de-tareas
start taskmgr
goto menu-inicio





:abrir-teclado-en-pantalla
start osk
goto menu-inicio





:abrir-repositorio-github
explorer "https://github.com/Alplox/ScriptsPlox"
goto menu-inicio





:fin
REM Código final del script/cierra ventana