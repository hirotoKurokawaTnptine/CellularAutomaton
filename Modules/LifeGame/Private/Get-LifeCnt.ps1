function Get-LifeCnt {
    param(
        [Parameter(Mandatory)][LGNeighbors]$Neighbors
    )

    [LGNeighbors]$N = $Neighbors

    # すべての近傍から生の数をカウント
    [bigint[]]$lifeCnt = $N.PSObject.Properties | Select-Object -Skip 1 | & { process { $_.Value }} `
        | Reduce-Object -acc ([bigint[]]($N.Up,0,0)) -func ${Function:Add-Bit3Digits}
    return $lifeCnt
}