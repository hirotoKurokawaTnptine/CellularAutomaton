param(
    [Parameter(Mandatory)][int]$GenerationCnt
)

Import-Module (Join-Path $PSScriptRoot '..\Modules\LifeGame\LifeGame.psm1') -Force
Import-Module (Join-Path $PSScriptRoot '..\Modules\CAConsoleVisualizer\CAConsoleVisualizer.psm1') -Force

$ErrorActionPreference = "Stop"
$rnd = [System.Security.Cryptography.RandomNumberGenerator]::Create()

$cnt = $GenerationCnt-1
$Height   = [Console]::WindowHeight - 2
$Width    = [Console]::WindowWidth - 2 
$IntervalMs = 0

[bigint[]]$board = 0..($Height-1) | ForEach-Object { Get-BigIntRandom -rndObj $rnd -BitLength $Width }

$step = New-LGStepFunc -Width $width -Height $Height

Clear-Host
try {
    0..$cnt | & { Process {
        Show-CA -Board $board -StartWidth 0 -LengthWidth $Width -StartHeight 0 -LengthHeight $Height
        $board = $step.next($board)
        Start-Sleep -Milliseconds $IntervalMs
    }}
} finally {
    Start-Sleep -Milliseconds 500
    [Console]::CursorVisible = $true
    Clear-Host
}