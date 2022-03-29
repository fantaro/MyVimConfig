@echo off

set currentPath=%~dp0
set targetPath=%currentPath%\vim
cd /d %currentPath%

if "%1"=="" goto PARAMETER_ERROR
if not exist "%1" goto MAIN_FILE_NOT_FOUND

echo Extracting VIM ................ Start
"C:\Program Files\7-Zip\7z.exe" x %1                                            > nul
rename %currentPath%\vim82-kaoriya-win64 vim                                    > nul
echo ............................... End

echo Copying vimrc files ........... Start
xcopy /Y %currentPath%\vimrc\Windows_vimrc\* %targetPath%\                      > nul
xcopy /Y %currentPath%\vimrc\encode_japan.vim %targetPath%\plugins\kaoriya\     > nul
rem xcopy /Y %currentPath%\vimrc\vimrc_example.vim %targetPath%\vim82\          > nul
xcopy /Y %targetPath%\switches\catalog\utf-8.vim %targetPath%\switches\enabled\ > nul
echo ............................... End

echo Copying colorscheme file ...... Start
del %targetPath%\vim82\colors\*.vim                                             > nul
xcopy /Y %currentPath%\colors\*.vim %targetPath%\vim82\colors\                  > nul
echo ............................... End

echo Copying plugin files .......... Start

rem cmdline-complete
xcopy /Y %currentPath%\plugin\cmdline-complete.vim %targetPath%\vim82\plugin\   > nul
echo (cmdline-complete)

rem visual-star-search
xcopy /Y %currentPath%\plugin\visual-star-search.vim %targetPath%\vim82\plugin\ > nul
echo (visual-star-search)

rem vim-easy-align
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\vim-easy-align.zip       > nul
xcopy /S /E /Y %currentPath%\vim-easy-align %targetPath%\vim82\                 > nul
rmdir /S /Q %currentPath%\vim-easy-align                                        > nul
echo (vim-easy-align)

rem mru
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\mru.zip                  > nul
xcopy /S /E /Y %currentPath%\mru %targetPath%\vim82\                            > nul
rmdir /S /Q %currentPath%\mru                                                   > nul
echo (mru)

rem vim-ps1-master
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\vim-ps1-master.zip       > nul
xcopy /S /E /Y %currentPath%\vim-ps1-master %targetPath%\vim82\                 > nul
rmdir /S /Q %currentPath%\vim-ps1-master                                        > nul
echo (vim-ps1-master)

rem fencview
xcopy /Y %currentPath%\plugin\fencview.vim %targetPath%\vim82\plugin\           > nul
echo (fencview)

rem vim-swoop
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\vim-swoop.zip            > nul
xcopy /S /E /Y %currentPath%\vim-swoop %targetPath%\vim82\                      > nul
rmdir /S /Q %currentPath%\vim-swoop                                             > nul
echo (vim-swoop)

echo ............................... End

goto OK_END

:PARAMETER_ERROR
echo Missing parameter !
goto END

:MAIN_FILE_NOT_FOUND
echo [vim82-kaoriya-win64-*.zip] is not found !
goto ERROR_END

:ERROR_END
echo ............................... Failed !
goto END

:OK_END
echo ............................... Successful !
goto END

:END
