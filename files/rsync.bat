@echo off
set RSYNC_HOME=C:\Program Files (x86)\ICW\bin
cd %RSYNC_HOME%
E:
rsync -avzP --progress rsync://116.62.15.77:873/test /cygdrive/e/ERP/CloudWMS