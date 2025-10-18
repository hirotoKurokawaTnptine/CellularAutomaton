class LGStep {
    [uint32]$Width

    [bigint[]]next([bigint[]]$board) {
        $Height = $board.Count-1
        [bigint[]]$nextState = 0..($Height-1) | & { process {
            Get-LGNextState -Board $board -Width $this.Width -y $_
        }}
        return $nextState
    }
}

function New-LGStepFunc {
    param(
        [Parameter(Mandatory)][UInt32]$Width,
    )

    return [LGStep]@{
        Width = $Width
    }
}