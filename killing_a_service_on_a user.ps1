$continue = $true
while ($continue) {
    $ip = Read-Host "Digite o IP"
    if ($ip -eq $null) {
        Write-Host "IP não existe"
        pause
    }

    $username = Read-Host "Digite o nome do consultor"
    if ($username -eq $null) {
        Write-Host "Usuário não encontrado"
        pause
    }

    $command1 = "taskkill -f -im NomedoServiço* -s $ip /FI ""USERNAME eq $username"""
    $command2 = "taskkill -f -im NomedoServiço* -s $ip /FI ""USERNAME eq $username"""

    Invoke-Expression $command1
    Invoke-Expression $command2

    $choice = Read-Host "Deseja executar novamente? (S/N)"
    if ($choice -ne "S") {
        $continue = $false
    } Else {cls}
}
