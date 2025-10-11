param(
    [Parameter(Mandatory)][int]$GenerationCnt,
    [byte]$RuleNo = [byte]90
)

Import-Module (Join-Path $PSScriptRoot '..\Modules\ECA\ECA.psm1') -Force
Import-Module (Join-Path $PSScriptRoot '..\Modules\CAConsoleVisualizer\CAConsoleVisualizer.psm1') -Force

$ErrorActionPreference = "Stop"


$cnt = $GenerationCnt-1
$Height   = [Console]::BufferHeight
$Width = 500 #[Console]::BufferWidth
$IntervalMs = 0

[bigint]$InitState = [bigint]::One -shl ($Width / 2)

$step = New-EcaStepFunc -Width $width -RuleNo $RuleNo

[bigint]$state = $InitState 
[bigint[]]$board = New-Object bigint[] $Height

Clear-Host

try {
0..$cnt | & { Begin { $y=0 } Process {
    $board[$y] = $state
    if($y -ge ($Height-1)) {
        1..($Height-1) | & { process { $board[$_-1] = $board[$_] } }
    }
    Show-CA -Board $board -StartWidth 0 -LengthWidth $Width -StartHeight 0 -LengthHeight $Height
    $state = $step.next($state)
    Start-Sleep -Milliseconds $IntervalMs
    $y++
    if($y -ge $Height) { $y=$Height-1 }
}}
} finally {
    Start-Sleep -Milliseconds 1000
    [Console]::CursorVisible = $true
    Clear-Host
}