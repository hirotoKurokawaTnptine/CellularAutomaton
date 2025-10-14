# 1次元セルオートマトン
Import-Module (Join-Path $PSScriptRoot '..\..\Modules\CAConsoleVisualizer\CAConsoleVisualizer.psm1') -Force

function Invoke-ECA1D {
    param(
        [Parameter(Mandatory)][bigint]$state,
        [Parameter(Mandatory)][uint32]$width,
        [Parameter(Mandatory)][byte]$rule
    )

    # 幅マスク（番兵法）
    [bigint]$mask = ([bigint]1 -shl $width) - 1
    [bigint]$maskedState = $state -band $mask

    # 近傍
    [bigint]$L = ($maskedState -shr 1)
    [bigint]$C = $maskedState
    [bigint]$R = ($maskedState -shl 1) -band $mask

    [bigint]$nL = (-bnot $L) -band $mask
    [bigint]$nC = (-bnot $C) -band $mask
    [bigint]$nR = (-bnot $R) -band $mask

    # stateの各3bitパターン位置のマスク
    [bigint]$s000 =  $nL -band $nC -band $nR
    [bigint]$s001 =  $nL -band $nC -band  $R
    [bigint]$s010 =  $nL -band  $C -band $nR
    [bigint]$s011 =  $nL -band  $C -band  $R
    [bigint]$s100 =   $L -band $nC -band $nR
    [bigint]$s101 =   $L -band $nC -band  $R
    [bigint]$s110 =   $L -band  $C -band $nR
    [bigint]$s111 =   $L -band  $C -band  $R
    
    # ruleの各3bitパターン位置のマスク。結果は全１ビットマスク or 全0ビットマスク
    [bigint]$r000 = $mask * ($rule -shr 0 -band 1)
    [bigint]$r001 = $mask * ($rule -shr 1 -band 1)
    [bigint]$r010 = $mask * ($rule -shr 2 -band 1)
    [bigint]$r011 = $mask * ($rule -shr 3 -band 1)
    [bigint]$r100 = $mask * ($rule -shr 4 -band 1)
    [bigint]$r101 = $mask * ($rule -shr 5 -band 1)
    [bigint]$r110 = $mask * ($rule -shr 6 -band 1)
    [bigint]$r111 = $mask * ($rule -shr 7 -band 1)

	($s000 -band $r000) -bor
	($s001 -band $r001) -bor
	($s010 -band $r010) -bor
	($s011 -band $r011) -bor
	($s100 -band $r100) -bor
	($s101 -band $r101) -bor
	($s110 -band $r110) -bor
	($s111 -band $r111)
    
}

$ruleNo = 90
$Height = [Console]::BufferHeight - 2
$width = [Console]::BufferWidth - 2
$cnt = 1000
$IntervalMs = 10

$init = [Bigint]::One -shl ($width/2)
$state = $init
[bigint[]]$board = New-Object bigint[] $Height

Clear-Host
try {
    0..$cnt | & { Begin { $y=0 } Process {
        $board[$y] = $state
        if($y -ge ($Height-1)) {
            1..($Height-1) | & { process { $board[$_-1] = $board[$_] } }
        }
        Show-CA -Board $board -StartWidth 0 -LengthWidth $Width -StartHeight 0 -LengthHeight $Height
        $state = Invoke-ECA1D -state $state -width $width -rule $ruleNo
        Start-Sleep -Milliseconds $IntervalMs
        $y++
        if($y -ge $Height) { $y=$Height-1 }
    }}
} finally {
    Start-Sleep -Milliseconds 500
    [Console]::CursorVisible = $true
    Clear-Host
}