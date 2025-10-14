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

    if ($StartWidth -ge $LengthWidth)   { throw "StartWidth must be less than LengthWidth"   }
    if ($StartHeight -ge $LengthHeight) { throw "StartHeight must be less than LengthHeight" }
    

    $Height = [Console]::WindowHeight - 2
    $Width  = [Console]::WindowWidth  - 2

    if (($StartWidth+$LengthWidth-3) -le $Width) { 
        $Width = $StartWidth + $LengthWidth - 3
    }

    if(($StartHeight+$LengthHeight-3) -le $Height) {
        $Height = $StartHeight + $LengthHeight - 3
    }

    
    $RowBorder = $RowBorderMoji * ($Width + 2)

    [void]$sb.Append($RowBorder)
    [void]$sb.Append($NewLineCode)
    $StartHeight..($StartHeight + $Height - 1) | & { process {
        $y=$_
        [void]$sb.Append($ColumnBorderMoji)
        $StartWidth..($StartWidth + $Width - 1) | & { process {
            $x=$_
            [bool][int]$binary = ($Board[$y] -shr $x) -band 1
            $M = $(if($binary) { $TrueMoji } else { $FalseMoji })
            [void]$sb.Append($M)
        }}
        [void]$sb.Append($ColumnBorderMoji)
        [void]$sb.Append($NewLineCode)
    }}
    [void]$sb.Append($RowBorder)

    
    [Console]::CursorVisible = $false
    [Console]::SetCursorPosition(0,0)
    [Console]::Write($sb)
    $sb.Clear() | Out-Null
}