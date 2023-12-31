
             $comeco = Read-Host "Você irá executar os comandos em qual HostName?"

try {
    $result = Invoke-Command -ComputerName $comeco -ScriptBlock {
        # Obter a lista de serviços em execução
        $listaServicos = Get-Service | Where-Object { $_.Status -eq 'Running' }

        # Exibir a lista de serviços
        Write-Host "Serviços em execução:"
        foreach ($servico in $listaServicos) {
            Write-Host "$($servico.DisplayName) (Nome do Serviço: $($servico.ServiceName))"
        }

        # Perguntar ao usuário se deseja encerrar um serviço
        $nomeServicoEncerrar = Read-Host "Digite o nome do serviço que você deseja encerrar (ou pressione Enter para sair)"

        if ($nomeServicoEncerrar -ne "") {
            # Tentar encontrar o serviço com o nome fornecido pelo usuário
            $servicoEncerrar = $listaServicos | Where-Object { $_.DisplayName -eq $nomeServicoEncerrar -or $_.ServiceName -eq $nomeServicoEncerrar }

            if ($servicoEncerrar) {
                # Encerrar o serviço
                Stop-Service -Name $servicoEncerrar.ServiceName
                Write-Host "O serviço $($servicoEncerrar.DisplayName) foi encerrado."
            } else {
                Write-Host "Nenhum serviço correspondente ao nome fornecido foi encontrado."
            }
        } else {
            Write-Host "Você optou por não encerrar nenhum serviço."
        }
    }

    if ($result -eq $null) {
        Write-Host "Verifique a conexão no Host $comeco." -ForegroundColor Yellow
    } else {
        Write-Host "Comandos executados com sucesso no Host $comeco." -ForegroundColor Green
        Write-Host $result
    }
} catch {
    Write-Host "Erro ao conectar-se ao host $comeco. Verifique o nome do host e a conectividade." -ForegroundColor Red
} finally {
    # Pausa para visualização
    pause
    Clear-Host
}
