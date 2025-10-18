class EcaRuleBitMasks {
    [ValidateCount(8,8)]
    [bigint[]]$masks

    EcaRuleBitMasks([bigint[]]$masks) {
        $this.masks = $masks
    }
}