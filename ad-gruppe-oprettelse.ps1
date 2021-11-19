Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$fornavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/fornavne.txt").content
$Efternavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/efternavne.txt").content


Write-host "antal" -NoNewline
$antal = Read-host " "

1..$antal | % {
    $fornavn = $fornavne.Split([Environment]::NewLine) | Get-Random
    $efternavn = $efternavne.Split([Environment]::NewLine) | Get-Random
    write-host $fornavn $efternavn





}