# セルの近傍のパターン000~111に対応するビットマスクを格納するクラス
class EcaRuleBitMasks {
    [ValidateCount(8,8)]
    [bigint[]]$masks

    EcaRuleBitMasks([bigint[]]$masks) {
        $this.masks = $masks
    }
}