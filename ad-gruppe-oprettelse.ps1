cls
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$fornavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/fornavne.txt").content
$Efternavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/efternavne.txt").content




Write-host "antal" -NoNewline
$antal = Read-host " "

1..$antal | % {
    #Name
    $fornavn = $fornavne.Split([Environment]::NewLine) | Get-Random
    $efternavn = $efternavne.Split([Environment]::NewLine) | Get-Random
    write-host "Navn:`t" $fornavn $efternavn

    #Username
    $part1 = $fornavn.Substring(0,3).toLower().replace("ø","o").replace("æ","a").replace("å","a")
    $part2 = $efternavn.Substring(0,3).toLower().replace("ø","o").replace("æ","a").replace("å","a")
    $part3 = "01"
    $part4 = "@god.rm.dk"
    Write-Host "AD:`t`t" $part1$part2$part3$part4
    "";

}