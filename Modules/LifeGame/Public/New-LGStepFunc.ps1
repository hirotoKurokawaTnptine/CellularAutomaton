class LGStep {
    [uint32]$Width
    [uint32]$Height

    [bigint[]]next([bigint[]]$board) {
        [bigint[]]$nextState = 0..($this.Height-1) | & { process {
            Get-LGNextState -Board $board -Width $this.Width -y $_
        }}
        return $nextState
    }
}

function New-LGStepFunc {
    param(
        [Parameter(Mandatory)][UInt32]$Width,
        [Parameter(Mandatory)][UInt32]$Height
    )

    return [LGStep]@{
        Width = $Width
        Height = $Height
    }
}