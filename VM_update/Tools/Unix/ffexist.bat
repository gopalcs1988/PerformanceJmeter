@echo off
REM Retrieved from
REM http://windowsitpro.com/article/articleid/77717/jsi-tip-6415-how-can-a-batch-script-test-if-a-folder-is-empty-or-contains-folders-files-or-both-folders-and-files.html
REM
REM Returned values
REM   XX - The FolderPath does NOT exist.
REM   NN - The FolderPath is empty.
REM   YN - The FolderPath contains sub-folders and does NOT contain files.
REM   NY - The FolderPath contains files and does NOT contain sub-folders.
REM   YY - The FolderPath contains both sub-folders and files.


if {%2}=={} @echo Syntax: ffexist FolderPath Answer&goto :EOF
setlocal
if not exist %1 endlocal&set %2=XX&goto :EOF
dir %1 /a|findstr /c:" 0 File">NUL:&&(set file=N)||(set file=Y)
dir %1 /a|findstr /c:" 2 Dir">NUL:&&(set fold=N)||(set fold=Y)
endlocal&set %2=%fold%%file%