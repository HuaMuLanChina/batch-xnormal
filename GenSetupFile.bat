echo off

rem  Adding files from Svn Repo
echo Adding files from Svn Repo...


rem update to get the latest file list;
svn update

svn list -R > files.txt

echo Adding .svn to setup file...

winrar a xNormal.zip @files.txt

winrar a -r xNormal.zip .svn\*
rename xNormal.zip xNormal.mzp
move/y xNormal.mzp Installation\xNormal.mzp

echo Del timp files...

del files.txt
del xNormal.mzp

rem DONE
echo.
echo.
echo Done.
pause