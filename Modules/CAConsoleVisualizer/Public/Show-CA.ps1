$TrueMoji = "*"
$FalseMoji = " "
$RowBorderMoji = "-"
$ColumnBorderMoji = "|"
$NewLineCode = "`r`n"

$sb = [System.Text.StringBuilder]::new()

function Show-CA {
    param(
        [Parameter(Mandatory)][bigint[]]$Board,
        [Parameter(Mandatory)][uint32]$StartWidth,
        [Parameter(Mandatory)][uint32]$LengthWidth,
        [Parameter(Mandatory)][uint32]$StartHeight,
        [Parameter(Mandatory)][uint32]$LengthHeight
    )
    
    [CAConsoleVisualizer]::ShowCA($Board, $StartWidth, $LengthWidth, $StartHeight, $LengthHeight)
}