Write-Host "Você escolheu a opção 9. Ação 9 será executada."
                start-Sleep -Seconds 2
                cls

                # Atualiza as políticas e retorna um documento com possiveis erros e quais políticas forão atualizadas.
                gpupdate /force
                $user = Read-Host "Digite o seu usuário que esta utilizando"
                gpresult /H:"C:\Users\$user\Documents\RSOP.html"
                pause
                cls
