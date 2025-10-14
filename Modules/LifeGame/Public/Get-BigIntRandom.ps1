function Get-BigIntRandom {
    param(
        [Parameter(Mandatory)][object]$RndObj,
        [Parameter(Mandatory)][uint32]$BitLength
    )

    $byteLen = [math]::Ceiling($BitLength / 8)
    $byteArr = New-Object byte[] $byteLen
    $RndObj.GetBytes($byteArr)
    $bigint = [bigint]::new($byteArr)
    return [bigint]::Abs($bigint)
}