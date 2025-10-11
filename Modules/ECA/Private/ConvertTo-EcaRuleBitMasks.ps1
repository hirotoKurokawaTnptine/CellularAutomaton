
function ConvertTo-EcaRuleBitMasks {
    [OutputType([EcaRuleBitMasks])]
    param(
        [Parameter(Mandatory)]
        [byte]$RuleNo,
        [Parameter(Mandatory)]
        [EcaContext]$Context
    )

    $byteDigits = 7

    [bigint[]]$masks = 0..$byteDigits | ForEach-Object {
        $bit = $RuleNo -shr $_ -band 1
        $Context.Mask * $bit
    }
    [EcaRuleBitMasks]$masks
}