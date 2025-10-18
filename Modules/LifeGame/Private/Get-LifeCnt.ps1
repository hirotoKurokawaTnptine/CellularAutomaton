function Get-LifeCnt {
    param(
        [Parameter(Mandatory)][bigint[]]$State,
        [Parameter(Mandatory)][bigint]$Mask,
        [Parameter(Mandatory)][uint32]$y
    )

    $Height = $State.Count-1

    # 近傍の状態を取得
    [bigint]$Up = $(if($y -eq 0) { [bigint]::Zero } else {  $State[$y-1] -band $Mask })
    [bigint]$Down = $(if($y -ge $Height) { [bigint]::Zero } else {  $State[$y+1] -band $Mask })

    [bigint]$Left = $State[$y] -shr 1 -band $Mask
    [bigint]$LeftUp = $Up -shr 1 -band $Mask
    [bigint]$LeftDown = $Down -shr 1 -band $Mask

    [bigint]$Right = $State[$y] -shl 1 -band $Mask
    [bigint]$RightUp = $Up -shl 1 -band $Mask
    [bigint]$RightDown = $Down -shl 1 -band $Mask

    # すべての近傍から生の数をカウント
    [bigint[]]$sum = $Up,0,0
    $sum = Add-Bit3Digits -left $sum -right $Down
    $sum = Add-Bit3Digits -left $sum -right $Left
    $sum = Add-Bit3Digits -left $sum -right $LeftUp
    $sum = Add-Bit3Digits -left $sum -right $LeftDown
    $sum = Add-Bit3Digits -left $sum -right $Right
    $sum = Add-Bit3Digits -left $sum -right $RightUp
    $sum = Add-Bit3Digits -left $sum -right $RightDown

    return $sum
}