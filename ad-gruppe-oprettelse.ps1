cls
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force




#OU Oprettelse
$ou = (invoke-webrequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/afdelinger.txt").content





#Bruger oprettelse
$fornavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/fornavne.txt").content
$Efternavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/efternavne.txt").content

Write-host "antal" -NoNewline
$antal = Read-host " "

1..$antal | % {
    #Name
    $fornavn = $fornavne.Split([Environment]::NewLine) | Get-Random
    $efternavn = $efternavne.Split([Environment]::NewLine) | Get-Random
    #Username
    $part1 = $fornavn.Substring(0,3).toLower().replace("æ","a").replace("ø","o").replace("å","a")
    $part2 = $efternavn.Substring(0,3).toLower().replace("æ","a").replace("ø","o").replace("å","a")
    $part3 = 1
    $part4 = "@god.rm.dk"
    $navn = "$fornavn $efternavn"
    $username = $part1+$part2+$part3
    $email = $part1+$part2+$part3+$part4
    
    Write-Host "Navn:`t`t" $navn
    Write-Host "username:`t" $username
    Write-Host "email:`t`t" $email
    "";

}