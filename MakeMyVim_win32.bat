@echo off

set currentPath=%~dp0
set targetPath=%currentPath%\vim
cd /d %currentPath%

if "%1"=="" goto PARAMETER_ERROR
if not exist "%1" goto MAIN_FILE_NOT_FOUND

echo Extracting VIM ................ Start
"C:\Program Files\7-Zip\7z.exe" x %1                                            > nul
rename %currentPath%\vim74-kaoriya-win32 vim                                    > nul
echo ............................... End

echo Copying vimrc files ........... Start
xcopy /Y %currentPath%\vimrc\Windows_vimrc\* %targetPath%\                      > nul
xcopy /Y %currentPath%\vimrc\encode_japan.vim %targetPath%\plugins\kaoriya\     > nul
xcopy /Y %currentPath%\vimrc\vimrc_example.vim %targetPath%\vim74\              > nul
xcopy /Y %targetPath%\switches\catalog\utf-8.vim %targetPath%\switches\enabled\ > nul
echo ............................... End

echo Copying colorscheme file ...... Start
del %targetPath%\vim74\colors\*.vim                                             > nul
rem molokai
xcopy /Y %currentPath%\colors\molokai.vim %targetPath%\vim74\colors\            > nul
echo (molokai)
rem ir_dark
xcopy /Y %currentPath%\colors\ir_dark.vim %targetPath%\vim74\colors\            > nul
echo (ir_dark)
rem solarized
xcopy /Y %currentPath%\colors\solarized.vim %targetPath%\vim74\colors\          > nul
echo (solarized)
rem PaperColor
xcopy /Y %currentPath%\colors\PaperColor.vim %targetPath%\vim74\colors\         > nul
echo (PaperColor)
rem yowish
xcopy /Y %currentPath%\colors\yowish.vim %targetPath%\vim74\colors\             > nul
echo (yowish)
echo ............................... End

echo Copying plugin files .......... Start
rem taglist   20120417_commented
rem "C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\taglist_45.zip       > nul
rem xcopy /S /E /Y %currentPath%\taglist_45 %targetPath%\vim74\                 > nul
rem rmdir /S /Q %currentPath%\taglist_45                                        > nul
rem echo (taglist)

rem tagbar
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\tagbar.zip               > nul
xcopy /S /E /Y %currentPath%\tagbar %targetPath%\vim74\                         > nul
rmdir /S /Q %currentPath%\tagbar                                                > nul
echo (tagbar)

rem snipMate
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\snipMate.zip             > nul
xcopy /S /E /Y %currentPath%\snipMate %targetPath%\vim74\                       > nul
rmdir /S /Q %currentPath%\snipMate                                              > nul
xcopy /S /E /Y %currentPath%\snipMate_snippets %targetPath%\vim74\snippets      > nul
echo (snipMate)

rem cmdline-complete
xcopy /Y %currentPath%\plugin\cmdline-complete.vim %targetPath%\vim74\plugin\   > nul
echo (cmdline-complete)

rem visual-star-search
xcopy /Y %currentPath%\plugin\visual-star-search.vim %targetPath%\vim74\plugin\ > nul
echo (visual-star-search)

rem tabular   20120804_commented
rem "C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\tabular.zip          > nul
rem xcopy /S /E /Y %currentPath%\tabular %targetPath%\vim74\                    > nul
rem rmdir /S /Q %currentPath%\tabular                                           > nul
rem echo (tabular)

rem vim-alignta 2015047_commented
rem "C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\vim-alignta.zip      > nul
rem xcopy /S /E /Y %currentPath%\vim-alignta %targetPath%\vim74\                > nul
rem rmdir /S /Q %currentPath%\vim-alignta                                       > nul
rem echo (vim-alignta)

rem vim-easy-align
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\vim-easy-align.zip       > nul
xcopy /S /E /Y %currentPath%\vim-easy-align %targetPath%\vim74\                 > nul
rmdir /S /Q %currentPath%\vim-easy-align                                        > nul
echo (vim-easy-align)

rem mru
xcopy /Y %currentPath%\plugin\mru.vim %targetPath%\plugins\                     > nul
echo (mru)

rem vim-ps1-master
"C:\Program Files\7-Zip\7z.exe" x %currentPath%\plugin\vim-ps1-master.zip       > nul
xcopy /S /E /Y %currentPath%\vim-ps1-master %targetPath%\vim74\                 > nul
rmdir /S /Q %currentPath%\vim-ps1-master                                        > nul
echo (vim-ps1-master)

rem fencview
xcopy /Y %currentPath%\plugin\fencview.vim %targetPath%\vim74\plugin\           > nul
echo (fencview)

rem vim-swoop
xcopy /Y %currentPath%\plugin\vim-swoop.vim %targetPath%\vim74\plugin\          > nul
echo (vim-swoop)

echo ............................... End

goto OK_END

:PARAMETER_ERROR
echo Missing parameter !
goto END

:MAIN_FILE_NOT_FOUND
echo [vim74-kaoriya-win32-*.zip] is not found !
goto ERROR_END

:ERROR_END
echo ............................... Failed !
goto END

:OK_END
echo ............................... Successful !
goto END

:END
