$ErrorActionPreference = 'Stop';

$packageName = 'pijul'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile = Get-Item "$toolsDir\*_x64.exe"

Move-Item -Path "$exeFile" -Destination "$toolsDir\pijul.exe"
