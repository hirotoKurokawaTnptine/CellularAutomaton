function New-EcaContext {
    param(
        [Parameter(Mandatory)]
        [UInt32]$Width
    )
    
    [EcaContext]$Width
}