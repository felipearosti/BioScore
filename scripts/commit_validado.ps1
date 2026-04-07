param(
    [Parameter(Mandatory = $true)]
    [string]$Message
)

$ErrorActionPreference = 'Stop'

$messageTrimmed = $Message.Trim()

if ([string]::IsNullOrWhiteSpace($messageTrimmed)) {
    throw 'Mensagem de commit vazia. Use um texto curto e objetivo em portugues.'
}

if ($messageTrimmed.Length -gt 60) {
    throw 'Mensagem muito longa. Limite: 60 caracteres.'
}

Write-Host '==> Executando flutter analyze...'
flutter analyze

Write-Host '==> Executando flutter test...'
flutter test

Write-Host '==> Criando commit...'
git add .
git commit -m $messageTrimmed

Write-Host 'Commit criado com sucesso.'
