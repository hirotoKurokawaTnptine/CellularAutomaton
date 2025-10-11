class EcaStep {
    [ValidateNotNull()]
    [EcaContext]$Context
    [ValidateNotNull()]
    [EcaRuleBitMasks]$RuleMasks

    [bigint]next([bigint]$state) {
        $neighbors = Get-EcaNeighbors -State $State -Context $this.Context
        $stateMasks = ConvertTo-EcaStateBitMasks -Neighbors $neighbors -Context $this.Context
        return (Invoke-EcaRule -StateMasks $stateMasks -RuleMasks $this.RuleMasks -Context $this.Context)
    }
}

function New-EcaStepFunc {
    param(
        [Parameter(Mandatory)]
        [UInt32]$Width,
        [Parameter(Mandatory)]
        [byte]$RuleNo
    )

    
    $Context = New-EcaContext -Width $Width
    $RuleMasks = ConvertTo-EcaRuleBitMasks -RuleNo $RuleNo -Context $Context
    return [EcaStep]@{
        Context = $Context
        RuleMasks = $RuleMasks
    }
}