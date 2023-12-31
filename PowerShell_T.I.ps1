$continue = $true

while ($continue) {
    $Name = Read-Host "Digite o seu usuário"

    if ($Name -eq $null) {
        Write-Host "Usuário não existe"
        exit
    } else {
        Start-Process -FilePath "runas" -ArgumentList "/noprofile", "/netonly", "/user:youvr.local\$Name", "powershell.exe"

        $choice = Read-Host "Deseja executar novamente? (S/N)"
        
        if ($choice -ne "S") {
            $continue = $false
        } else {
            Clear-Host
        }
    }
}
