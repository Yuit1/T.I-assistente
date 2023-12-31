
                # Obtém a lista de programas instalados no Registro
                $uninstallKeys = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
                    Select-Object DisplayName, UninstallString | 
                    Where-Object { $_.DisplayName -ne $null -and $_.UninstallString -ne $null }

                # Lista os programas instalados
                Write-Host "Programas instalados no sistema:"
                $counter = 1
                foreach ($program in $uninstallKeys) {
                    Write-Host "$counter. $($program.DisplayName)"
                    $counter++
                }

                # Solicita ao usuário que escolha um programa para desinstalar
                $selection = Read-Host "Digite o número do programa que deseja desinstalar (ou 'S' para sair)"

                if ($selection -ne 'S' -and $selection -ge 1 -and $selection -le $uninstallKeys.Count) {
                    $selectedProgram = $uninstallKeys[$selection - 1]
                    Write-Host "Desinstalando $($selectedProgram.DisplayName)..."
    
                    # Executa o comando de desinstalação
                    Start-Process "cmd.exe" -ArgumentList "/c $($selectedProgram.UninstallString)" -Wait
                    Write-Host "Desinstalação concluída."
                } elseif ($selection -ne 'S') {
                    Write-Host "Seleção inválida."
                }

                pause
                cls
