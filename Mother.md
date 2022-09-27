$obj=@()

Foreach($p In (Get-Process -IncludeUserName | where {$_.UserName} | `
  select Id, ProcessName, UserName)) {
      $properties = @{ 'PID'=$p.Id;
                       'ProcessName'=$p.ProcessName;
                       'UserName'=$p.UserName;
                     }
      $psobj = New-Object -TypeName psobject -Property $properties
      $obj+=$psobj
  }

Get-NetTCPConnection | where {$_.State -eq "Established"} | select `
  RemoteAddress, `
  RemotePort, `
  @{n="PID";e={$_.OwningProcess}}, @{n="ProcessName";e={($obj |? PID -eq $_.OwningProcess | select -ExpandProperty ProcessName)}}, `
  @{n="UserName";e={($obj |? PID -eq $_.OwningProcess | select -ExpandProperty UserName)}} |
  sort -Property ProcessName, UserName |
  ft -auto
  
pause
