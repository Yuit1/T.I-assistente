# Solicita o HostName e o nome de usuário
$comeco = Read-Host "Informe o HostName onde deseja executar os comandos"
$user = Read-Host "Digite o nome do usuário que está utilizando"

try {
    # Executa os comandos remotamente no computador especificado
    $result = Invoke-Command -ComputerName $comeco -ScriptBlock {
    
        # Atualiza as políticas de grupo
        gpupdate /force

        # Aguarda um momento para garantir que as políticas são aplicadas antes de executar o gpresult
        Start-Sleep -Seconds 10

        # Gera o relatório do gpresult
        $reportPath = "C:\Users\$using:user\Documents\RSOP.html"
        gpresult /H:$reportPath

        # Retorna o caminho do relatório gerado
        $reportPath
    }
    if ($result -eq $null) {
        Write-Host "Usuário não encontrado no Host $comeco." -ForegroundColor Red
    } else {
        Write-Host "Comandos executados com sucesso no Host $comeco para o usuário $user." -ForegroundColor Green
        Write-Host "Relatório gerado em: $result" -ForegroundColor Green
    }
} catch {
    Write-Host "Erro ao conectar-se ao host $comeco. Verifique o nome do host e a conectividade." -ForegroundColor Red
} finally {
    
    pause
    Clear-Host
}
