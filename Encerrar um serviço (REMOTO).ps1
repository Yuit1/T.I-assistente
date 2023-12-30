Write-Host "Você escolheu a opção 8. Ação 8 será executada."
                start-Sleep -Seconds 2
                cls

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

                pause
                cls
