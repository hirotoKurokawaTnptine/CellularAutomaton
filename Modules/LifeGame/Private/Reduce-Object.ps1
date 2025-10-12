function Reduce-Object {
    param(
        [Parameter(Mandatory,ValueFromPipeline)]$e,
        [Parameter(Mandatory)]$acc,
        [Parameter(Mandatory)][scriptblock]$func
    )

    begin { $_acc = $acc }
    process { $_acc = & $func $_acc $e }
    end { $_acc }

}