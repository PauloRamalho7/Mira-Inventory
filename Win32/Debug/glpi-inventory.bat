@echo off
for %%p in (".") do pushd "%%~fsp"
cd /d "%~dp0"

perl\bin\glpi-agent.exe perl\bin\glpi-inventory %* >> tempxml.xml

popd
