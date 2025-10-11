# ECA.psm1

# Classesフォルダのps1をすべて読み込む
Get-ChildItem -Path $PSScriptRoot/Classes -Filter *.ps1 |
    Sort-Object Name | ForEach-Object { . $_.FullName }

# Privateフォルダのps1をすべて読み込む（公開しない）
Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" | 
    ForEach-Object { . $_.FullName }

# Publicフォルダのps1をすべて読み込む
Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" | 
    ForEach-Object { . $_.FullName }

Export-ModuleMember -Function (Get-ChildItem "$PSScriptRoot\Public\*.ps1" | ForEach-Object { 
    $_.BaseName
})