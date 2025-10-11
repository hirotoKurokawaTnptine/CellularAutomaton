function ConvertTo-EcaStateBitMasks {
    [OutputType([EcaStateBitMasks])]
    param(
        [Parameter(Mandatory)]
        [EcaNeighborhood]$Neighbors,
        [Parameter(Mandatory)]
        [EcaContext]$Context
    )
    $L = $Neighbors.Left
    $C = $Neighbors.Center
    $R = $Neighbors.Right

    $nL = -bnot $L -band $Context.Mask
    $nC = -bnot $C -band $Context.Mask
    $nR = -bnot $R -band $Context.Mask

    $m000 = $nL -band $nC -band $nR
    $m001 = $nL -band $nC -band $R
    $m010 = $nL -band $C -band $nR
    $m011 = $nL -band $C -band $R
    $m100 = $L -band $nC -band $nR
    $m101 = $L -band $nC -band $R
    $m110 = $L -band $C -band $nR
    $m111 = $L -band $C -band $R
    
    [EcaStateBitMasks][bigint[]]($m000, $m001, $m010, $m011, $m100, $m101, $m110, $m111)
}