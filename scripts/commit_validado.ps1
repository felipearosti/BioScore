param(
    [Parameter(Mandatory = $true)]
    [string]$Message
)

$ErrorActionPreference = 'Stop'

Write-Host '==> Executando flutter analyze...'
flutter analyze

Write-Host '==> Executando flutter test...'
flutter test

Write-Host '==> Criando commit...'
git add .
git commit -m $Message

Write-Host 'Commit criado com sucesso.'
