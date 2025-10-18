class LGStep {
    [uint32]$Width

    [bigint[]]next([bigint[]]$board) {
        $Height = $board.Count-1
        [bigint[]]$nextState = 0..$Height | & { process {
            Get-LGNextState -Board $board -Width $this.Width -y $_
        }}

        if($board.Length -ne $nextState.Length) {
            throw [System.Exception] "Next state generation failed: Length mismatch."
        }

        return $nextState
    }
}

function New-LGStepFunc {
    param(
        [Parameter(Mandatory)][UInt32]$Width
    )

    return [LGStep]@{
        Width = $Width
    }
}