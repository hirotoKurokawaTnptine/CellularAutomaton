class EcaContext {
    [ValidateRange(1,[uint32]::MaxValue)]
    [uint32]$Width
    [bigint]$Mask

    EcaContext([uint32]$Width) {
        $this.Width = $Width
        $this.Mask = ([bigint]1 -shl $Width) - 1
    }
}