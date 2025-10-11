function Get-EcaNeighbors {
    [OutputType([EcaNeighborhood])]
    param(
        [Parameter(Mandatory)]
        [bigint]$State,
        [Parameter(Mandatory)]
        [EcaContext]$Context
    )

    [bigint]$L = ($State -shr 1) -band $Context.Mask
    [bigint]$C = $State -band $Context.Mask
    [bigint]$R = ($State -shl 1) -band $Context.Mask

    [EcaNeighborhood]@{
        Left = $L
        Center = $C
        Right = $R
    }

}