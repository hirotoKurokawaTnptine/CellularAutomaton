class EcaStateBitMasks {
    [ValidateCount(8,8)]
    [bigint[]]$masks

    EcaStateBitMasks([bigint[]]$masks) {
        $this.masks = $masks
    }
}