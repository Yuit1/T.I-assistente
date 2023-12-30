if([string](Get-Module -list -Name ActiveDirectory).Name -eq ""){

    Write-Host "VocÃª nÃ£o possui o MÃ³dulo ActiveDirectory instalado! Instalando o mÃ³dulo necessÃ¡rio" -ForegroundColor Yellow
    try {
        Write-Host "Instalando o MÃ³dulo ActiveDirectory"
        Add-WindowsCapability -Name 'Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0' -Online
        Write-Host "MÃ³dulo instalado com sucesso" -ForegroundColor Green
    }
    catch {
        Write-Host "NÃ£o foi possÃ­vel instalar o mÃ³dulo necessÃ¡rio" -ForegroundColor RED
    }

    Write-Host -NoNewLine "`nPressione qualquer tecla para continuar..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

}
else {
    if([string](Get-Module -Name ActiveDirectory).Name -eq ""){
        Write-Host "Importando o MÃ³dulo ActiveDirectory..."
        Import-Module ActiveDirectory -Function Get-ADuser,Get-ADComputer
    }
}
