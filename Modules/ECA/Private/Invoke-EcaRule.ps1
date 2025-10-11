function Invoke-EcaRule {
    [OutputType([bigint])]
    param(
        [Parameter(Mandatory)]
        [EcaStateBitMasks]$StateMasks,
        [Parameter(Mandatory)]
        [EcaRuleBitMasks]$RuleMasks,
        [Parameter(Mandatory)]
        [EcaContext]$Context
    )

    $byteDigits = 7
    0..$byteDigits | ForEach-Object -Begin { [bigint]$acc = 0 } -Process {
        $acc = $acc -bor ($StateMasks.masks[$_] -band $RuleMasks.masks[$_])
    } -End { [bigint]($acc -band $Context.Mask) }
}