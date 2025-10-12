# ビット列LeftとRightの加算を行う
# Leftは3要素のbigint配列で、各要素がそれぞれ1桁目、2桁目、3桁目を表す
# Rightは1要素のbigintで、1桁目のビット列を表す
# 戻り値は3要素のbigint配列で、各要素がそれぞれ1桁目、2桁目、3桁目を表す
function Add-Bit3Digits {
    param(
        [Parameter(Mandatory)][ValidateCount(3,3)][bigint[]]$left,
        [Parameter(Mandatory)][bigint]$right
    )

    # b0~b2で１つのビット列を表す
    $b0,$b1,$b2 = $left

    # 1桁目の桁上がりを表す
    [bigint]$c0 = $b0 -band $right
    # 2桁目の桁上がりを表す
    [bigint]$c1 = $b1 -band $c0

    [bigint]$_b0 = $b0 -bxor $right
    [bigint]$_b1 = $b1 -bxor $c0
    [bigint]$_b2 = $b2 -bxor $c1

    return $_b0,$_b1,$_b2
}