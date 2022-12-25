[CmdletBinding()] param (
  [Parameter(Mandatory = $false)]
  [string]
  $NvimExe = $null
)
$ErrorActionPreference = "Stop"

# Install pynvim; vim-plug requires pynvim
if (Get-Command -Name pip3 -ErrorAction SilentlyContinue) {
  pip3 install --user pynvim jedi
}

# Install vim-plug
$VimPlugUrl = `
  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
New-Item -ItemType Directory -Path nvim\autoload -ErrorAction SilentlyContinue
Invoke-WebRequest $VimPlugUrl -OutFile nvim\autoload\plug.vim

# Download hanja.txt
$HanjaUrl = `
  "https://github.com/choehwanjin/libhangul/raw/main/data/hanja/hanja.txt"
Invoke-WebRequest $HanjaUrl -OutFile hanja.txt

# Link neovim configuration to %LOCALAPPDATA%\nvim
$NvimrcName = "init.nvim"
$NvimDirName = "nvim"
$SourceNvimDir = Join-Path $PSScriptRoot $NvimDirName
Write-Debug "SourceNvimDir: $SourceNvimDir"
$SourceNvimrc = Join-Path $SourceNvimDir $NvimrcName
Write-Debug "SourceNvimrc: $SourceNvimrc"
$DestinationNvimDir = Join-Path $env:LocalAppData $NvimDirName
Write-Debug "DestinationNvimDir: $DestinationNvimDir"
$DestinationNvimrc = Join-Path $DestinationNvimDir $NvimrcName
Write-Debug "DestinationNvimrc: $DestinationNvimrc"

if ((Get-Item $DestinationNvimDir -ErrorAction SilentlyContinue).Target -ne `
    $SourceNvimDir) {
  Remove-Item -Force -Recurse -ErrorAction SilentlyContinue $DestinationNvimrc
  New-Item `
    -ItemType Directory `
    -Path $env:LocalAppData `
    -ErrorAction SilentlyContinue
  New-Item `
    -ItemType SymbolicLink `
    -Path $env:LocalAppData `
    -Name $NvimDirName `
    -Value $SourceNvimDir
}

# Install plugins using vim-plug
if ($NvimExe -eq $null) {
  &$NvimExe +PlugInstall +PlugUpdate +PlugClean! +qall
} else {
  nvim +PlugInstall +PlugUpdate +PlugClean! +qall
}
