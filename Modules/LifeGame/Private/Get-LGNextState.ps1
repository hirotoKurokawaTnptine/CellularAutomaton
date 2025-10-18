function Get-LGNextState {
    param(
        [Parameter(Mandatory)][bigint[]]$Board,
        [Parameter(Mandatory)][uint32]$Width,
        [Parameter(Mandatory)][uint32]$y
    )

    # 境界マスク
    [bigint]$mask = ([bigint]1 -shl $Width) - 1

    $Center = $Board[$y] -band $mask
    [bigint[]]$LifeCnt = Get-LifeCnt -State $Board -Mask $mask -y $y

    # 生の数がちょうど２，３の場合のパターンのセルを抽出
    $bit2 = -bnot $LifeCnt[2] -band $LifeCnt[1] # 近傍に生が４つ以上のセル。3bit目が1のセルは4以上なので除外
    $lifeCnt2 = $bit2 -band (-bnot $LifeCnt[0]) # 近傍に生が２つのセル
    $lifeCnt3 = $bit2 -band $LifeCnt[0]         # 近傍に生が３つのセル
    
    return $Center -band $lifeCnt2 -bor $lifeCnt3
}